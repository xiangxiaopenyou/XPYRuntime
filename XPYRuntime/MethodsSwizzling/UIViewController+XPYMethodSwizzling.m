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
+ (void)load {
    SEL viewDidAppearSel = @selector(viewDidAppear:);
    SEL xpyViewDidAppearSel = @selector(xpy_viewDidAppear:);
    Method viewDidAppearMethod = class_getInstanceMethod([self class], viewDidAppearSel);
    Method xpyViewDidAppearMethod = class_getInstanceMethod([self class], xpyViewDidAppearSel);
    BOOL isAdded = class_addMethod([self class], viewDidAppearSel, method_getImplementation(xpyViewDidAppearMethod), method_getTypeEncoding(xpyViewDidAppearMethod));
    if (isAdded) {
        class_replaceMethod([self class], xpyViewDidAppearSel, method_getImplementation(viewDidAppearMethod), method_getTypeEncoding(viewDidAppearMethod));
    } else {
        method_exchangeImplementations(viewDidAppearMethod, xpyViewDidAppearMethod);
    }
}
- (void)xpy_viewDidAppear:(BOOL)animated {
    NSLog(@"交换方法成功");
}

@end
