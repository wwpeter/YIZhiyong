//
//  UIView+HDCornerBorder.h
//  piaojulicai-ios
//
//2017/11/20.
//  Copyright © 2017年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#define LineHeight 1.0/[UIScreen mainScreen].scale
@interface UIView (HDCornerBorder)

- (void)addCorner;
- (void)addCornerWithCornerRadius:(CGFloat)cornerRadius;

- (void)addCornerAndBorderWithCornerRadius:(CGFloat)cornerRadius;
- (void)addCornerAndBorderWithCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor;
- (void)createCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius shadowCornerRadius:(CGFloat)shadowCornerRadius offset:(CGSize)offset opacity:(CGFloat)opacity shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)color;
-(void)createDefaultCornerRadiusShadowWithCornerRadiusShadowColor:(UIColor *)shadowColor cornerRadius:(CGFloat)cornerRadius;
- (void)createDefaultCornerRadiusShadowWithCornerRadius;
-(void)createDefaultCornerRadiusShadowWithCornerRadiusShadowColor:(UIColor *)shadowColor;
-(void)addCornerAndBorderWithCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat )borderWidth;
-(void)createCornerRadiusShadowWithShadowCornerRadius:(CGFloat)shadowCornerRadius offset:(CGSize)offset opacity:(CGFloat)opacity shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)color;
@end
