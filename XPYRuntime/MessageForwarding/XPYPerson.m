//
//  XPYPerson.m
//  TestProject
//
//  Created by 项小盆友 on 2019/2/3.
//  Copyright © 2019 项小盆友. All rights reserved.
//

#import "XPYPerson.h"
#import <objc/runtime.h>

@implementation XPYPerson
/// 处理类方法
+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(eat:)) {
        return class_addMethod(object_getClass(self), sel, class_getMethodImplementation(object_getClass(self), @selector(xpy_eat:)), "v@:");
    }
    return [class_getSuperclass(self) resolveClassMethod:sel];
}

/// 处理实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(sing:)) {
        return class_addMethod([self class], sel, class_getMethodImplementation(self, @selector(xpy_sing:)), "v@:");
    }
    return [super resolveInstanceMethod:sel];
}
+ (void)xpy_eat:(NSString *)food {
    NSLog(@"动态添加eat类方法成功");
}
- (void)xpy_sing:(NSString *)song {
    NSLog(@"动态添加sing实例方法成功");
}

+ (void)run:(NSString *)road {
    NSLog(@"消息接收者重定向类方法");
}
- (void)work:(NSString *)jorb {
    NSLog(@"消息接收者重定向实例方法");
}
- (void)jump:(NSString *)things {
    NSLog(@"消息转发完成");
}

- (void)test {
    NSLog(@"test");
}


/// 解档
/// @param coder coder
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        unsigned int count;
        //获取对象的所有属性
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i ++) {
            Ivar ivar = ivars[i];
            const char *ivarName = ivar_getName(ivar);
            NSString *key = [NSString stringWithUTF8String:ivarName];
            id value = [coder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(ivars);
    }
    return self;
}

/// 归档
/// @param coder coder
- (void)encodeWithCoder:(NSCoder *)coder {
    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:ivarName];
        id value = [self valueForKey:key];
        [coder encodeObject:value forKey:key];
    }
    free(ivars);
}

/// iOS12 NSSecureCoding协议需要实现的方法，YES表示支持SecureCoding
+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
