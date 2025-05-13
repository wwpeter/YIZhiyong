//
//  BITErrorTipsView.m
//  Pods
//
//  Created by jiaguoshang on 2019/2/6.
//  Copyright © 2019年 YiXiang. All rights reserved.
//


#import "BITErrorTipsView.h"
#import "BITCommonUnitKeys.h"
//#import "BITLogMacro.h"
#import "ReactiveObjC.h"

@interface BITErrorTipsView ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UIButton *retryBtn;

@end

@implementation BITErrorTipsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = sCommonUnitBackgroudColor();
        [self addSubview:self.imgView];
        [self addSubview:self.retryBtn];
    }
    return self;
}

#pragma mark - load

- (UIImageView *)imgView
{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UIButton *)retryBtn
{
    if (!_retryBtn) {
        _retryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _retryBtn.titleLabel.font = sCommonUnitFont(13.f);
        [_retryBtn setTitleColor:sCommonUnitAssistColor() forState:UIControlStateNormal];
        [_retryBtn addTarget:self action:@selector(retryAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retryBtn;
}

- (void)show
{
 
}

- (void)showWithTips:(NSString *)tips icon:(NSString *)icon
{

}

- (void)hide
{
    
}

#pragma mark - retryAction

- (void)retryAction:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(doRetryHandler)]) {
        [self.delegate doRetryHandler];
    }
}


@end
