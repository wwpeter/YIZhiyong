//
//  UIView+HDCornerBorder.m
//  piaojulicai-ios
//
//2017/11/20.
//  Copyright © 2017年 . All rights reserved.
//

#import "UIView+HDCornerBorder.h"

//颜色
#define WLColor(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]

//由十六进制转换成是十进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

@implementation UIView (HDCornerBorder)

- (void)addCorner{
    self.layer.cornerRadius = 4.f;
    self.layer.masksToBounds = YES;
}
- (void)addCornerWithCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
- (void)addCornerAndBorderWithCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = WLColor(20, 123, 254, 1.0).CGColor;
    self.layer.borderWidth = LineHeight;
}
- (void)addCornerAndBorderWithCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = LineHeight;
}

- (void)addCornerAndBorderWithCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWidth:(CGFloat )borderWidth{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}
- (void)createCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius shadowCornerRadius:(CGFloat)shadowCornerRadius offset:(CGSize)offset opacity:(CGFloat)opacity shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)color{
    self.layer.shadowColor = [color CGColor];
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.cornerRadius = cornerRadius;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:shadowCornerRadius] CGPath];
    self.layer.masksToBounds = NO;
}

- (void)createDefaultCornerRadiusShadowWithCornerRadius{
    self.layer.shadowColor = WLColor(239, 239, 239, 1.0).CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 5;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.cornerRadius = 5;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:5] CGPath];
    self.layer.masksToBounds = NO;
}
-(void)createDefaultCornerRadiusShadowWithCornerRadiusShadowColor:(UIColor *)shadowColor cornerRadius:(CGFloat)cornerRadius{
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 8;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.cornerRadius = cornerRadius;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:cornerRadius] CGPath];
    self.layer.masksToBounds = NO;
}

-(void)createDefaultCornerRadiusShadowWithCornerRadiusShadowColor:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeMake(3, 3);
    self.layer.shadowRadius = 8;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    self.layer.cornerRadius = 15;
    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:15] CGPath];
    self.layer.masksToBounds = NO;
}
-(void)createCornerRadiusShadowWithShadowCornerRadius:(CGFloat)shadowCornerRadius offset:(CGSize)offset opacity:(CGFloat)opacity shadowRadius:(CGFloat)shadowRadius shadowColor:(UIColor *)color{
    self.layer.backgroundColor = color.CGColor;
    self.layer.cornerRadius = shadowCornerRadius;
    self.layer.shadowColor = [color CGColor];
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = shadowRadius;
//    self.layer.shadowColor = [color CGColor];
//    self.layer.shadowOpacity = opacity;
//    self.layer.shadowOffset = offset;
//    self.layer.shadowRadius = shadowRadius;
//    self.layer.cornerRadius = shadowRadius;
//    self.layer.shouldRasterize = YES;
//    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
//    self.layer.shadowPath = [[UIBezierPath bezierPathWithRoundedRect:[self bounds] cornerRadius:shadowCornerRadius] CGPath];
//    self.layer.masksToBounds = NO;
}
@end
