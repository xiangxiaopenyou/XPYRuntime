//
//  UIButton+XPYImageURL.h
//  XPYRuntime
//
//  Created by zhangdu_imac on 2019/12/13.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (XPYImageURL)

@property (nonatomic, copy) NSString *imageURLString;

/// 移除所有关联的属性
- (void)removeAssociatedObjects;

@end

NS_ASSUME_NONNULL_END
