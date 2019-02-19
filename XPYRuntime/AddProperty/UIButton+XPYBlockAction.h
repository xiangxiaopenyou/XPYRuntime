//
//  UIButton+XPYBlockAction.h
//  XPYRuntime
//
//  Created by zhangdu_imac on 2019/2/18.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ActionBlock)(UIButton *button);

@interface UIButton (XPYBlockAction)

- (void)addTapAction:(ActionBlock)block;

@end

NS_ASSUME_NONNULL_END
