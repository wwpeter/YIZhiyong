//
//  UIColor+BitInfo.h
//  ChildishBeautyParent
//
//  Created        on 16/8/7.
//  Copyright (c) 2016年 jiaguoshang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIColor (BitInfo)

+ (UIColor *) colorWithHexValue: (uint32_t)hexValue;
/**
 *  颜色转换 iOS中十六进制的颜色转换为UIColor
 */
+ (UIColor *) colorWithHexString: (NSString *)color;
/**
 *  颜色转换(支持透明度) iOS中十六进制的颜色转换为UIColor
 */
+ (UIColor *) colorAlphaWithHexString: (NSString *)hexString;

+ (instancetype)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
/**
 *  @brief  随机颜色
 *
 *  @return UIColor
 */
+ (UIColor *)RandomColor;
@end
