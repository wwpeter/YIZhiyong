//
//  BGAlertNoticeView.m
//  Pods
//
//  Created by huihui on 2019/1/2.
//  Copyright © 2019年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import "BGAlertNoticeView.h"
#import "BITCommonUnitKeys.h"
#import "BITLogMacro.h"
#import "ReactiveObjC.h"
#import "BITCocoaLumberjack.h"
#import "BITCocoaLumberjackMacro.h"
#import "NSTimer+BitInfo.h"

#define titleSize        18.f
#define buttonSize       15.f
#define messageSize      sCommonUnitFontHeight
#define titleColor       [UIColor colorWithHexValue:0x333333]
#define messageColor     [UIColor colorWithHexValue:0x222222]
#define isIpad ([[UIScreen mainScreen] bounds].size.width >= 768 && [[UIScreen mainScreen] bounds].size.height >= 768)
//#define ALERT_WIDTH      (isIpad ? 600 : ([[UIScreen mainScreen] bounds].size.width - 60))
#define ALERT_WIDTH      (isIpad ? 500 : 315)
#define montLayerColor   [[UIColor colorWithHexValue:0x000000] colorWithAlphaComponent:0.35f]
#define DefaultHeight    27.f
#define MARGIN           25.f
#define titleLabelHeight 18.f
#define ButtonHeight     42.f

@interface BGAlertNoticeAction ()

@property (nonatomic, copy) void(^handler)(BGAlertNoticeAction *action);

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BGAlertNoticeActionStyle style;

@property (nonatomic, strong) UIColor *actionTitleColor;
@property (nonatomic, strong) UIColor *actionColor;
@end

@implementation BGAlertNoticeAction

+ (instancetype)actionWithTitle:(NSString *)title
                          style:(BGAlertNoticeActionStyle)style
                        handler:(void (^)(BGAlertNoticeAction *))handler
{
    BGAlertNoticeAction *action = [[BGAlertNoticeAction alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    if (style == BGAlertNoticeActionStyleOK) {
        action.actionTitleColor = [UIColor colorWithHexValue:0x222222];
    } else {
        action.actionTitleColor = [UIColor colorWithHexValue:0xBBBBBB];
    }
    return action;
}

+ (instancetype)actionWithTitle:(NSString *)title style:(BGAlertNoticeActionStyle)style actionColor:(UIColor *)actionColor handler:(void(^)(BGAlertNoticeAction *action))handler
{
    BGAlertNoticeAction *action = [[BGAlertNoticeAction alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    action.actionColor = actionColor;
    if (style == BGAlertNoticeActionStyleOK) {
        action.actionTitleColor = [UIColor whiteColor];
    } else {
        action.actionTitleColor = [UIColor colorWithHexValue:0x222222];
    }
    return action;
}

@end



@interface BGAlertNoticeView ()

@property (nonatomic, strong) UIButton         *montLayerView;//蒙层

@property (nonatomic, strong) UILabel        *titleLabel;//标题

@property (nonatomic, strong) UIButton       *rightBtn;//右上角按钮

@property (nonatomic, strong) UIView         *containerView;//内容

@property (nonatomic, strong) NSMutableArray <BGAlertNoticeAction *>*actionBtns;//下方按钮事件集合

@property (nonatomic, strong) UIWindow       *window;//window

@property (nonatomic, assign) CGFloat        alertWidth;//宽度

@property (nonatomic, strong) UILabel        *messageLabel;//消息内容

@property (nonatomic, strong) UIView         *btnContainer;//按钮view
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, assign) BOOL isShow;//是否正在展示

@property (nonatomic, strong) NSTimer *timer;//定时器
@end

@implementation BGAlertNoticeView

#pragma mark - load

- (NSMutableArray *)actionBtns
{
    if (!_actionBtns) {
        _actionBtns  = [NSMutableArray array];
    }
    return _actionBtns;
}

#pragma mark - init

+ (instancetype)alertWithIcon:(UIImage *)icon
                      message:(NSString *)message
                containerView:(UIView *)containerView
                   alertStyle:(BGAlertNoticeViewStyle)alertStyle
{
    BGAlertNoticeView *alertView = [[BGAlertNoticeView alloc] initWithWidth:ALERT_WIDTH
                                                                       icon:(UIImage *)icon
                                                                    message:message
                                                              containerView:containerView
                                                                 alertStyle:alertStyle];
    return alertView;
}

- (instancetype)initWithIcon:(UIImage *)icon
                     message:(NSString *)message
               containerView:(UIView *)containerView
                  alertStyle:(BGAlertNoticeViewStyle)alertStyle
{
    return [self initWithWidth:ALERT_WIDTH
                          icon:(UIImage *)icon
                       message:message
                 containerView:containerView
                    alertStyle:alertStyle];
}

- (instancetype)initWithWidth:(CGFloat)width
                         icon:(UIImage *)icon
                      message:(NSString *)message
                containerView:(UIView *)containerView
                   alertStyle:(BGAlertNoticeViewStyle)alertStyle
{
    self = [super init];
    if (self) {
        self.shouldAutoDismiss = YES;
        self.opaque = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5.f;
        self.layer.masksToBounds = YES;
        self.alertWidth = width;
        if (self.alertWidth <= 0) {
            self.alertWidth = ALERT_WIDTH;
        }
        //初始化window
        
        if(isIpad)
        {
            if(sCommonUnitFullWidth() <= sCommonUnitFullHeight())
            {
                self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                //初始化蒙层
                self.montLayerView = [[UIButton alloc] initWithFrame:self.window.bounds];
            }
            else
            {
                self.window = [[UIWindow alloc] initWithFrame:CGRectMake((sCommonUnitFullHeight() -sCommonUnitFullWidth())/2, (sCommonUnitFullWidth() - sCommonUnitFullHeight())/2, sCommonUnitFullWidth(), sCommonUnitFullHeight())];
                //初始化蒙层
                self.montLayerView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, sCommonUnitFullWidth(), sCommonUnitFullHeight())];
                self.window.transform = CGAffineTransformRotate (self.window.transform , M_PI_2);
            }
        }
        else
        {
            self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            //初始化蒙层
            self.montLayerView = [[UIButton alloc] initWithFrame:self.window.bounds];
        }
        NSLog(@"self.window.frame.origin.x:%f,self.window.frame.origin.y:%f,self.window.frame.size.width:%f,self.window.frame.size.height:%f, sCommonUnitFullWidth():%f, sCommonUnitFullHeight():%f", self.window.frame.origin.x,self.window.frame.origin.y,self.window.frame.size.width,self.window.frame.size.height, sCommonUnitFullWidth(), sCommonUnitFullHeight());
        NSLog(@"self.window.rootViewController.view.frame.origin.x:%f,self.window.rootViewController.view.frame.origin.y:%f,self.window.rootViewController.view.frame.size.width:%f,self.window.rootViewController.view.frame.size.height:%f", self.window.rootViewController.view.frame.origin.x,self.window.rootViewController.view.frame.origin.y,self.window.rootViewController.view.frame.size.width,self.window.rootViewController.view.frame.size.height);
        self.window.windowLevel = UIWindowLevelStatusBar + 2;
        self.window.opaque = NO;
        self.window.backgroundColor = [UIColor clearColor];
        self.montLayerView.backgroundColor = montLayerColor;
//        self.montLayerView.opaque = NO;
        [self.window addSubview:self.montLayerView];
        
        [self.montLayerView setTitle:@"" forState:UIControlStateNormal];
        [self.montLayerView addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        
        self.montLayerView.userInteractionEnabled = YES;
        self.window .userInteractionEnabled = YES;
        CGFloat totalHeight = 20.f;
        if (icon) {
            [self addSubview:self.iconView];
            self.iconView.image = icon;
//            self.iconView.sd_layout.widthIs(icon.size.width).heightIs(icon.size.height).topSpaceToView(self, totalHeight).centerXEqualToView(self);

            totalHeight += icon.size.height + 20;
        }

        if (!isCommonUnitEmptyString(message)) {
//            totalHeight = icon? totalHeight + 20: totalHeight ;

            self.messageLabel = [[UILabel alloc] init];
            self.messageLabel.text = message;
            self.messageLabel.textColor = messageColor;
            self.messageLabel.backgroundColor = [UIColor clearColor];
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            self.messageLabel.font = sCommonUnitFont(15);
            [self addSubview:self.messageLabel];
//            self.messageLabel.sd_layout.yIs(totalHeight).leftSpaceToView(self, MARGIN).widthIs(self.alertWidth - MARGIN * 2).autoHeightRatio(0);
//            CGRect rect = [message boundingRectWithSize:CGSizeMake(self.messageLabel.width_sd, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.messageLabel.font} context:nil];
//            totalHeight += rect.size.height + 0.1;
        }

        if (containerView) {
            if (!isCommonUnitEmpty(message)) {
                totalHeight += 20;
            }
            self.containerView = containerView;
            [self addSubview:self.containerView];
//            self.containerView.sd_layout.yIs(totalHeight).widthIs(containerView.width).heightIs(containerView.height).centerXIs(self.alertWidth / 2.f);
//            totalHeight += self.containerView.height;
        }
        if (totalHeight > DefaultHeight) {
            totalHeight += 25.f;
        }
        if (!self.btnContainer) {
            self.btnContainer = [[UIView alloc]init];
            self.btnContainer.backgroundColor = [UIColor clearColor];
            [self addSubview:self.btnContainer];
//            self.btnContainer.sd_layout.yIs(totalHeight).widthIs(self.alertWidth).leftSpaceToView(self, 0.f).heightIs(0.f);
        }
    }
    return self;
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.userInteractionEnabled = NO;
    }
    return _iconView;
}

- (void)addAction:(BGAlertNoticeAction *)action
{
    
    if (action && [action isKindOfClass:[BGAlertNoticeAction class]]) {
        [self.actionBtns addSafeObject:action];
    } else {
        assert(NO);
    }

}

- (void)alertViewWillShow
{
    //将确定按钮放在后面、取消按钮放在前面
    NSMutableArray *okActions = [NSMutableArray array];
    NSMutableArray *defaultActions = [NSMutableArray array];
    NSMutableArray *cancelActions = [NSMutableArray array];
    BOOL isColorAction = NO;
    for (BGAlertNoticeAction *action in self.actionBtns) {
        if(action.actionColor)
        {
            isColorAction = YES;
        }
        if (BGAlertNoticeActionStyleOK == action.style) {
            [okActions addSafeObject:action];
        } else if(BGAlertNoticeActionStyleCancel == action.style) {
            [cancelActions addSafeObject:action];
        } else {
            [defaultActions addSafeObject:action];
        }
    }
    self.actionBtns = [NSMutableArray arrayWithArray:cancelActions];
    [self.actionBtns addObjectsFromArray:defaultActions];
    [self.actionBtns addObjectsFromArray:okActions];
    [self.window makeKeyAndVisible];

    [self.window addSubview:self];
//    self.btnContainer.sd_layout.heightIs(sCommonUnit1PX());
//    self.sd_layout.centerXIs(sCommonUnitFullWidth() / 2).centerYIs(sCommonUnitFullHeight() / 2).widthIs(self.alertWidth).heightIs(self.btnContainer.bottom);
}



- (void)handleAction:(UIButton *)button
{
    NSInteger tag = button.tag;
    BGAlertNoticeAction *action = [self.actionBtns objectAtSafeIndex:tag - 100];
    if (action && action.handler) {
        action.handler(action);
    }
    if (self.shouldAutoDismiss) {
        [self hide];
    }
}


- (void)show
{
    @weakify(self);
    if (self.isShow) {
        return;
    }
    self.isShow = YES;
    [self alertViewWillShow];
    
    [self animationAlert];
    self.montLayerView.alpha = 0.0f;
    [UIView animateWithDuration:0.3 delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        @strongify(self);
        self.montLayerView.alpha = 0.9f;
    } completion:^(BOOL finished) {
        //开启定时器
        @strongify(self);
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:4.f]];
    }];
}

- (void)hide
{
    @weakify(self);
    // 隐藏遮罩
    [UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        @strongify(self);
        self.montLayerView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        //开启定时器
        @strongify(self);
    }];
    
    [UIView animateWithDuration:0.3 delay:0.f options:UIViewAnimationOptionAllowUserInteraction animations:^{
        @strongify(self);
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        @strongify(self);
        self.isShow = NO;
        self.window = nil;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
    }];

}

- (void)animationAlert
{
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.3;
    popAnimation.values = @[
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2f, 1.2f, 1.0f)],

                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];

    popAnimation.keyTimes = @[@0.0f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];

    [self.layer addAnimation:popAnimation forKey:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSTimer *)timer
{
    if (!_timer) {
        @weakify(self);
        _timer = [NSTimer bitscheduledTimerWithTimeInterval:0.01f block:^(NSTimer * _Nonnull timer) {
            @strongify(self);
            [self hide];
        } repeats:YES];
    }
    return _timer;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

@end
