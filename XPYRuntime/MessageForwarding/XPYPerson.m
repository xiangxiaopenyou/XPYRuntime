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
//处理类方法
+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(eat:)) {
        return class_addMethod(object_getClass(self), sel, class_getMethodImplementation(object_getClass(self), @selector(xpy_eat:)), "v@");
    }
    return [class_getSuperclass(self) resolveClassMethod:sel];
}

//处理实例方法
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(sing:)) {
        return class_addMethod(self, sel, class_getMethodImplementation(self, @selector(xpy_sing:)), "v@");
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
@end
