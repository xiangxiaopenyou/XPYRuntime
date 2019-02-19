//
//  UIButton+XPYBlockAction.m
//  XPYRuntime
//
//  Created by zhangdu_imac on 2019/2/18.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "UIButton+XPYBlockAction.h"
#import <objc/runtime.h>

static char XPYActionBlockKey;

@implementation UIButton (XPYBlockAction)
- (void)addTapAction:(ActionBlock)block {
    objc_setAssociatedObject(self, &XPYActionBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)tapAction:(UIButton *)button {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &XPYActionBlockKey);
    if (block) {
        block(button);
    }
}

@end
