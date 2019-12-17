//
//  UIViewController+XPYMethodSwizzling.m
//  XPYRuntime
//
//  Created by zhangdu_imac on 2019/2/19.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "UIViewController+XPYMethodSwizzling.h"
#import <objc/runtime.h>

@implementation UIViewController (XPYMethodSwizzling)

/// load方法在类加入到Runtime中时调用，并且只会调用一次
+ (void)load {
    //使用dispatch_once保证只会交换一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL viewDidAppearSel = @selector(viewDidAppear:);
        SEL xpyViewDidAppearSel = @selector(xpy_viewDidAppear:);
        //原方法
        Method viewDidAppearMethod = class_getInstanceMethod([self class], viewDidAppearSel);
        //替换方法
        Method xpyViewDidAppearMethod = class_getInstanceMethod([self class], xpyViewDidAppearSel);
        
        BOOL isAdded = class_addMethod([self class], viewDidAppearSel, method_getImplementation(xpyViewDidAppearMethod), method_getTypeEncoding(xpyViewDidAppearMethod));
        if (isAdded) {
            class_replaceMethod([self class], xpyViewDidAppearSel, method_getImplementation(viewDidAppearMethod), method_getTypeEncoding(viewDidAppearMethod));
        } else {
            method_exchangeImplementations(viewDidAppearMethod, xpyViewDidAppearMethod);
        }
    });
}
- (void)xpy_viewDidAppear:(BOOL)animated {
    [self xpy_viewDidAppear:animated];
    NSLog(@"交换方法成功");
}

@end
