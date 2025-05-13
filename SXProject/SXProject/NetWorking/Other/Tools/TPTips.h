//
//  TPTips.h
//  threepointer
//
//  Created by 赵晨宇 on 17/3/15.
//  Copyright © 2017年 YLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPTips : UIView
{
    UILabel *_label;
}

+ (TPTips *)sharedInstance;
+ (id)allocWithZone:(NSZone *)zone;

//底部提示框
- (void)normalPopShow:(NSString *)title andFont:(CGFloat)font andWidth:(CGFloat)width andTime:(CGFloat)time;

//中间提示框
- (void)centerPopShow:(NSString *)title andFont:(CGFloat)font andWidth:(CGFloat)width andTime:(CGFloat)time;
@end
