//
//  TPTips.m
//  threepointer
//
//  Created by 赵晨宇 on 17/3/15.
//  Copyright © 2017年 YLian. All rights reserved.
//

#import "TPTips.h"
#import "NSString+Size.h"
#import "BITCommonMacro.h"

#define TPTIPS_MARGWTS 40

@implementation TPTips

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.layer setCornerRadius:4.0f];
        [self.layer setMasksToBounds:YES];
//        self.layer.backgroundColor = wts_HEXCOLORA(@"000000", 0.4).CGColor;
        _label = [[UILabel alloc]init];
        _label.textAlignment = 1;
        _label.numberOfLines = 0;
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.textColor = [UIColor whiteColor];
    }
    return self;
}

static TPTips * instance;
+ (TPTips *)sharedInstance{
    static dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TPTips alloc] init];
    });
    return instance;
}

//单例重写allocWithZone方法，alloc不产生新的实例
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized (self) {
        if (instance == nil) {
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

//添加动画
- (void)addAnimation:(CGFloat)time {
    typeof(self) __weak weakSelf = self;
    weakSelf.alpha = 0.5;
    [UIView animateKeyframesWithDuration:time delay:0.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.01 animations:^{
            weakSelf.alpha = 0.5;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.01 relativeDuration:0.30 animations:^{
            weakSelf.alpha = 1.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.30 relativeDuration:0.70 animations:^{
            weakSelf.alpha = 1.0;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.70 relativeDuration:0.99 animations:^{
            weakSelf.alpha = 0.5;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.99 relativeDuration:1.0 animations:^{
            weakSelf.alpha = 0.0;
        }];
    } completion:^(BOOL finished) {
        weakSelf.alpha = 0;
        [weakSelf.layer removeAnimationForKey:@"animation_"];
        [weakSelf removeFromSuperview];
    }];
}

//出现在底部的提示框
- (void)normalPopShow:(NSString *)title andFont:(CGFloat)font andWidth:(CGFloat)width andTime:(CGFloat)time {
    if (width == 0) {
        width = SCREEN_WIDTH / 2.0;
    }
    
    CGFloat height = [title heightWithFont:[UIFont systemFontOfSize:font] constrainedToWidth:width - TPTIPS_MARGWTS] + TPTIPS_MARGWTS;
    if (height > SCREEN_HEIGHT) {
        height = SCREEN_HEIGHT;
    }
    
    _label.text = title;
    [_label setFont:[UIFont systemFontOfSize:font]];
    [_label setFrame:CGRectMake(TPTIPS_MARGWTS/2, TPTIPS_MARGWTS/2, width - TPTIPS_MARGWTS, height - TPTIPS_MARGWTS)];
    [self addSubview:_label];
    
    [self setFrame:CGRectMake((SCREEN_WIDTH - width) / 2.0, SCREEN_HEIGHT - height - TPTIPS_MARGWTS, width, height)];
    
    [self addAnimation:time];
    
    [wts_KEY_WINDOW addSubview:self];
}
- (void)centerPopShow:(NSString *)title andFont:(CGFloat)font andWidth:(CGFloat)width andTime:(CGFloat)time {
    
    [self normalPopShow:title andFont:font andWidth:width andTime:time];
    self.center = self.superview.center;
}
@end
