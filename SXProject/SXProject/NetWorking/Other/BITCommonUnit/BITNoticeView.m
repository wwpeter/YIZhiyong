//
//  BITNoticeView.m
//  Pods
//
//  Created by jiaguoshang on 2019/1/18.
//  Copyright © 2019年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import "BITNoticeView.h"
#import "BITCommonUnitKeys.h"
#import "NSTimer+BitInfo.h"
#import "BITLogMacro.h"
#import "ReactiveObjC.h"
#import <BITCategories/BITFDCategories.h>
#import "BITCocoaLumberjack.h"
#import "BITCocoaLumberjackMacro.h"
#import "BITSingleObject.h"


#define NoticeHeight 64.f

#define isIpad ([[UIScreen mainScreen] bounds].size.width >= 768 && [[UIScreen mainScreen] bounds].size.height >= 768)

static BITNoticeView *currentView = nil;

@interface BITNoticeView ()

@property (nonatomic, copy) NSString *notice;//展示的消息

@property (nonatomic, assign) BOOL success;//是否是成功的类型

//@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *textLabel;

@property (nonatomic, strong) UILabel *textBackgroundLabel;

//@property (nonatomic, strong) UILabel *textLabel2;
//
//@property (nonatomic, strong) UILabel *textBackgroundLabel2;
//
//@property (nonatomic, assign) BOOL isTextLabel;


@property (nonatomic, strong) UIWindow *statusWindow;//当前window

@property (nonatomic, assign) BOOL isShow;//是否正在展示

@property (nonatomic, strong) NSTimer *timer;//定时器

@property (nonatomic, assign) CGPoint startPoint;//开始点

@end

@implementation BITNoticeView

+ (BITNoticeView *)currentNotice
{
    if (!currentView) {
        currentView = [[BITNoticeView alloc] initWithFrame:CGRectMake(0, -NoticeHeight, sCommonUnitFullWidth(), NoticeHeight)];
        currentView.layer.shadowColor = [UIColor blackColor].CGColor;
        currentView.layer.shadowOpacity = 0.34f;
        currentView.layer.shadowOffset = CGSizeMake(0,0);
        currentView.layer.shadowRadius = 10.f;
        currentView.top = -NoticeHeight;
        currentView.userInteractionEnabled = NO;
    }
    return currentView;
}


- (void)showErrorNotice:(NSString *)notice
{
    if (isCommonUnitEmptyString(notice)) {
        return;
    }
    FLDDLogVerbose(@"notice:%@", notice);
    self.success = NO;
    self.notice = notice;
    [self show];
}

- (void)showErrorInfo:(NSError *)error
{
    if(error.code == 401)
    {
        return;
    }
    NSString *notice = error.domain;
    if((error.code == 0) && notice && ![notice isEqualToString:@"<null>"] && ([notice rangeOfString:@"登录"].location != NSNotFound))
    {
        return;
    }
    if (isCommonUnitEmptyString(notice)) {
        return;
    }
    self.success = NO;
    self.notice = notice;
    [self show];
}

- (void)showSuccessNotice:(NSString *)notice
{
    if (isCommonUnitEmptyString(notice)) {
        return;
    }
    self.success = YES;
    self.notice = notice;
    [self show];
}

#pragma mark - lazy load

//- (UIImageView *)iconView
//{
//    if (!_iconView) {
//        _iconView = [[UIImageView alloc] init];
//        _iconView.userInteractionEnabled = NO;
//    }
//    return _iconView;
//}

//- (UILabel *)textLabel
//{
//    if (!_textLabel) {
//        _textLabel = [[UILabel alloc] init];
//        _textLabel.userInteractionEnabled = NO;
//        _textLabel.textAlignment = NSTextAlignmentCenter;
//        _textLabel.font = sCommonUnitFont(13.f);
//        _textLabel.textColor = [UIColor whiteColor];
//        _textLabel.backgroundColor = [UIColor clearColor];
//        _textLabel.layer.cornerRadius = 2;
//        [_textLabel.layer setMasksToBounds:YES];
//    }
//    return _textLabel;
//}

//- (UILabel *)textBackgroundLabel
//{
//    if (!_textBackgroundLabel) {
//        _textBackgroundLabel = [[UILabel alloc] init];
//        _textBackgroundLabel.userInteractionEnabled = NO;
//        _textBackgroundLabel.textColor = [UIColor clearColor];
//        _textBackgroundLabel.font = sCommonUnitFont(13.f);
//        _textBackgroundLabel.backgroundColor = [UIColor blackColor];
//        _textBackgroundLabel.layer.cornerRadius = 2;
//        [_textBackgroundLabel.layer setMasksToBounds:YES];
//    }
//    return _textBackgroundLabel;
//}

- (UIWindow *)statusWindow
{
    if (!_statusWindow) {
//        _statusWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, (FULL_HEIGHT - NoticeHeight)/2, FULL_WIDTH, NoticeHeight)];

        if(isIpad)
        {
            if(sCommonUnitFullWidth() <= sCommonUnitFullHeight())
            {
                _statusWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, ((sCommonUnitFullHeight() - 64)/2), sCommonUnitFullWidth(), NoticeHeight)];
            }
            else
            {
                _statusWindow = [[UIWindow alloc] initWithFrame:CGRectMake((sCommonUnitFullHeight() -sCommonUnitFullWidth())/2, (sCommonUnitFullWidth() - sCommonUnitFullHeight())/2+((sCommonUnitFullHeight() - 64)/2), sCommonUnitFullWidth(), NoticeHeight)];
                _statusWindow.transform = CGAffineTransformRotate (self.statusWindow.transform , M_PI_2);
            }
            }
        else
        {
            _statusWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, ((sCommonUnitFullHeight() - 64)/2), sCommonUnitFullWidth(), NoticeHeight)];
        }
        _statusWindow.windowLevel = UIWindowLevelStatusBar + 2;
        _statusWindow.opaque = NO;
    }
    return _statusWindow;
}

- (NSTimer *)timer
{
    if (!_timer) {
        @weakify(self);
        _timer = [NSTimer bitscheduledTimerWithTimeInterval:0.01f block:^(NSTimer * _Nonnull timer) {
            @strongify(self);
            [self animationHide];
        } repeats:YES];
    }
    return _timer;
    
}

#pragma mark -hide

- (void)animationHide
{
//    if(currentView.top > -NoticeHeight)
//    {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.01f];
//        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
//        currentView.top -= 6.4;
//        [UIView commitAnimations];
//    } else {
        currentView.top = -NoticeHeight;
        currentView.statusWindow = nil;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
        currentView.isShow = NO;
        [self.timer setFireDate:[NSDate distantFuture]];
//    }
}


#pragma mark - show

- (void)show
{
    if (self.isShow) {
        return;
    }
    self.isShow = YES;
    [self startShow];
}

- (void)startShow
{
    [self willShow];
    [self animationShow];
}

- (void)willShow
{
    [self.textBackgroundLabel removeFromSuperview];
    //没有父视图的时候加载到父视图上去
//    if (!self.textBackgroundLabel.superview)
    {
        _textBackgroundLabel = [[UILabel alloc] init];
        _textBackgroundLabel.userInteractionEnabled = NO;
        _textBackgroundLabel.textColor = [UIColor clearColor];
        _textBackgroundLabel.font = sCommonUnitFont(13.f);
        _textBackgroundLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        _textBackgroundLabel.layer.cornerRadius = 2;
        [_textBackgroundLabel.layer setMasksToBounds:YES];
        [currentView addSubview:_textBackgroundLabel];

    }


        [self.textLabel removeFromSuperview];
        _textLabel = [[UILabel alloc] init];
        _textLabel.userInteractionEnabled = NO;
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = sCommonUnitFont(13.f);
        _textLabel.textColor = [UIColor whiteColor];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.layer.cornerRadius = 2;
        [_textLabel.layer setMasksToBounds:YES];
        [currentView addSubview:_textLabel];


    if (!currentView.superview) {
        [self.statusWindow addSubview:currentView];
    }
    [self.statusWindow makeKeyAndVisible];
    [self layoutViews];
}


#pragma amrk - layoutViews

- (void)layoutViews
{
//    UIImage *image = nil;
    if (self.success) {
//        image = [UIImage imageNamed:@"common_icon_tips_success"];
        currentView.backgroundColor = [UIColor clearColor];//BITMajorColor;
    } else {
//        image = [UIImage imageNamed:@"common_icon_tips_err"];
        currentView.backgroundColor = [UIColor clearColor];//RGB(210, 100, 105);
    }

}

#pragma mark - animationShow

- (void)animationShow
{
    @weakify(self);
    [UIView animateWithDuration:0.1f delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        currentView.top = 0;
    } completion:^(BOOL finished) {
        //开启定时器
        @strongify(self);
//        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.0f]];
    }];
}

@end

