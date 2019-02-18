//
//  ViewController.m
//  XPYRuntime
//
//  Created by 项小盆友 on 2019/2/3.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "ViewController.h"
#import "XPYPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //动态方法解析
    [XPYPerson eat:@"饭"];
    XPYPerson *person = [[XPYPerson alloc] init];
    [person sing:@"歌"];
    
    //消息接收者重定向
    [self performSelector:@selector(run:) withObject:nil];
    [self performSelector:@selector(work:) withObject:nil];
    
    //消息转发 重定向
    [self performSelector:@selector(jump:) withObject:nil];
}

#pragma mark - 消息动态处理
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}
+ (BOOL)resolveClassMethod:(SEL)sel {
    return NO;
}
#pragma mark - 消息接收者重定向
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(run:)) {
        return [XPYPerson class];
    }
    if (aSelector == @selector(work:)) {
        return [[XPYPerson alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}
#pragma mark - 消息转发 消息重定向
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return methodSignature;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    XPYPerson *person = [[XPYPerson alloc] init];
    if ([person respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:person];
    } else { //报错
        [self doesNotRecognizeSelector:sel];
    }
    
}


@end
