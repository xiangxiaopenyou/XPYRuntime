//
//  XPYPerson.h
//  TestProject
//
//  Created by 项小盆友 on 2019/2/3.
//  Copyright © 2019 项小盆友. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYPerson : NSObject
+ (void)eat:(NSString *)food;
- (void)sing:(NSString *)song;

+ (void)run:(NSString *)road;
- (void)work:(NSString *)jorb;
- (void)jump:(NSString *)things;

@end

NS_ASSUME_NONNULL_END
