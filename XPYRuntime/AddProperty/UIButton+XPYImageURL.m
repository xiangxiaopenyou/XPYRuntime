//
//  UIButton+XPYImageURL.m
//  XPYRuntime
//
//  Created by zhangdu_imac on 2019/12/13.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "UIButton+XPYImageURL.h"
#import <objc/runtime.h>

@implementation UIButton (XPYImageURL)

/// Setter
/// @param imageURLString 设置的值
- (void)setImageURLString:(NSString *)imageURLString {
    objc_setAssociatedObject(self, @selector(imageURLString), imageURLString, OBJC_ASSOCIATION_COPY_NONATOMIC);
    //设置网络图片代码
    //...
}


/// Getter
- (NSString *)imageURLString {
    return objc_getAssociatedObject(self, @selector(imageURLString));
}

- (void)removeAssociatedObjects {
    objc_removeAssociatedObjects(self);
}

@end
