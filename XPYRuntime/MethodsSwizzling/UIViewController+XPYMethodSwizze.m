//
//  UIViewController+XPYMethodSwizze.m
//  XPYRuntime
//
//  Created by zhangdu_imac on 2019/12/13.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "UIViewController+XPYMethodSwizze.h"

#import <objc/runtime.h>


@implementation UIViewController (XPYMethodSwizze)

+ (void)load {
    Method originMethod = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method swizzlingMethod = class_getInstanceMethod([self class], @selector(xpy_viewDidLoad));
    BOOL isAdded = class_addMethod([self class], @selector(viewDidLoad), method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
    if (isAdded) {
        class_replaceMethod([self class], @selector(xpy_viewDidLoad), method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzlingMethod);
    }
}

- (void)xpy_viewDidLoad {
    [self xpy_viewDidLoad];
    NSLog(@"方法交换成功");
}

@end
