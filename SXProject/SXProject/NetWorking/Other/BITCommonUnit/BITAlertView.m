//
//  BITAlertView.m
//  Pods
//
//  Created by huihui on 2019/1/2.
//  Copyright © 2019年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import "BITAlertView.h"
#import "BITCommonUnitKeys.h"
#import "BITLogMacro.h"
#import "ReactiveObjC.h"
#import "BITCocoaLumberjack.h"
#import "BITCocoaLumberjackMacro.h"

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

@interface BITAlertAction ()

@property (nonatomic, copy) void(^handler)(BITAlertAction *action);

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BITAlertActionStyle style;

@property (nonatomic, strong) UIColor *actionTitleColor;
@property (nonatomic, strong) UIColor *actionColor;
@end

@implementation BITAlertAction

+ (instancetype)actionWithTitle:(NSString *)title
                          style:(BITAlertActionStyle)style
                        handler:(void (^)(BITAlertAction *))handler
{
    BITAlertAction *action = [[BITAlertAction alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    if (style == BITAlertActionStyleOK) {
        action.actionTitleColor = [UIColor colorWithHexValue:0x222222];
    } else {
        action.actionTitleColor = [UIColor colorWithHexValue:0xBBBBBB];
    }
    return action;
}

+ (instancetype)actionWithTitle:(NSString *)title style:(BITAlertActionStyle)style actionColor:(UIColor *)actionColor handler:(void(^)(BITAlertAction *action))handler
{
    BITAlertAction *action = [[BITAlertAction alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    action.actionColor = actionColor;
    if (style == BITAlertActionStyleOK) {
        action.actionTitleColor = [UIColor whiteColor];
    } else {
        action.actionTitleColor = [UIColor colorWithHexValue:0x222222];
    }
    return action;
}

@end



@interface BITAlertView ()

@property (nonatomic, strong) UIView         *montLayerView;//蒙层

@property (nonatomic, strong) UILabel        *titleLabel;//标题

@property (nonatomic, strong) UIButton       *rightBtn;//右上角按钮

@property (nonatomic, strong) UIView         *containerView;//内容

@property (nonatomic, strong) NSMutableArray <BITAlertAction *>*actionBtns;//下方按钮事件集合

@property (nonatomic, strong) UIWindow       *window;//window

@property (nonatomic, assign) CGFloat        alertWidth;//宽度

@property (nonatomic, strong) UILabel        *messageLabel;//消息内容

@property (nonatomic, strong) UIView         *btnContainer;//按钮view

@end

@implementation BITAlertView

#pragma mark - load

- (NSMutableArray *)actionBtns
{
    if (!_actionBtns) {
        _actionBtns  = [NSMutableArray array];
    }
    return _actionBtns;
}

#pragma mark - init

+ (instancetype)alertWithTitle:(NSString *)title
               message:(NSString *)message
         containerView:(UIView *)containerView
            alertStyle:(BITAlertViewStyle)alertStyle
{
    NSMutableAttributedString *attributedString = nil;
    NSString *loadMessage = message;
    if (!isCommonUnitEmptyString(title)) {
        attributedString = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedString addAttributes:@{NSFontAttributeName:sCommonUnitBoldFont(titleSize), NSForegroundColorAttributeName:titleColor} range:NSMakeRange(0, attributedString.length)];
    } else {
        if (!isCommonUnitEmptyString(message)) {
            attributedString = [[NSMutableAttributedString alloc] initWithString:message];
            [attributedString addAttributes:@{NSFontAttributeName:sCommonUnitBoldFont(titleSize), NSForegroundColorAttributeName:titleColor} range:NSMakeRange(0, attributedString.length)];
            loadMessage = nil;
        }
    }
    BITAlertView *alertView = [[BITAlertView alloc] initWithWidth:ALERT_WIDTH
                                                 attributeTitle:attributedString
                                                        message:loadMessage
                                                  containerView:containerView
                                                     alertStyle:alertStyle];
    return alertView;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                containerView:(UIView *)containerView
                   alertStyle:(BITAlertViewStyle)alertStyle
{
    NSMutableAttributedString *attributedString = nil;
    NSString *loadMessage = message;
    if (!isCommonUnitEmptyString(title)) {
        attributedString = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedString addAttributes:@{NSFontAttributeName:sCommonUnitBoldFont(titleSize), NSForegroundColorAttributeName:titleColor} range:NSMakeRange(0, attributedString.length)];
    } else {
        if (!isCommonUnitEmptyString(message)) {
            attributedString = [[NSMutableAttributedString alloc] initWithString:message];
            [attributedString addAttributes:@{NSFontAttributeName:sCommonUnitBoldFont(titleSize), NSForegroundColorAttributeName:titleColor} range:NSMakeRange(0, attributedString.length)];
            loadMessage = nil;
        }
    }
    return [self initWithWidth:ALERT_WIDTH
                attributeTitle:attributedString
                       message:loadMessage
                 containerView:containerView
                    alertStyle:alertStyle];
}

- (instancetype)initWithWidth:(CGFloat)width
               attributeTitle:(NSMutableAttributedString *)attributeTitle
                      message:(NSString *)message
                containerView:(UIView *)containerView
                   alertStyle:(BITAlertViewStyle)alertStyle
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
                self.montLayerView = [[UIView alloc] initWithFrame:self.window.bounds];
            }
            else
            {
                self.window = [[UIWindow alloc] initWithFrame:CGRectMake((sCommonUnitFullHeight() -sCommonUnitFullWidth())/2, (sCommonUnitFullWidth() - sCommonUnitFullHeight())/2, sCommonUnitFullWidth(), sCommonUnitFullHeight())];
                //初始化蒙层
                self.montLayerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, sCommonUnitFullWidth(), sCommonUnitFullHeight())];
                self.window.transform = CGAffineTransformRotate (self.window.transform , M_PI_2);
            }
        }
        else
        {
            self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            //初始化蒙层
            self.montLayerView = [[UIView alloc] initWithFrame:self.window.bounds];
        }
        NSLog(@"self.window.frame.origin.x:%f,self.window.frame.origin.y:%f,self.window.frame.size.width:%f,self.window.frame.size.height:%f, sCommonUnitFullWidth():%f, sCommonUnitFullHeight():%f", self.window.frame.origin.x,self.window.frame.origin.y,self.window.frame.size.width,self.window.frame.size.height, sCommonUnitFullWidth(), sCommonUnitFullHeight());
        NSLog(@"self.window.rootViewController.view.frame.origin.x:%f,self.window.rootViewController.view.frame.origin.y:%f,self.window.rootViewController.view.frame.size.width:%f,self.window.rootViewController.view.frame.size.height:%f", self.window.rootViewController.view.frame.origin.x,self.window.rootViewController.view.frame.origin.y,self.window.rootViewController.view.frame.size.width,self.window.rootViewController.view.frame.size.height);
        self.window.windowLevel = UIWindowLevelStatusBar + 2;
        self.window.opaque = NO;
        self.window.backgroundColor = [UIColor clearColor];
        self.montLayerView.backgroundColor = montLayerColor;
        self.montLayerView.opaque = NO;
        [self.window addSubview:self.montLayerView];
        CGFloat totalHeight = 27.f;
        if (attributeTitle) {
            self.titleLabel = [[UILabel alloc] init];
            self.titleLabel.backgroundColor = [UIColor clearColor];
            self.titleLabel.attributedText = attributeTitle;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.titleLabel];
//            self.titleLabel.sd_layout.yIs(totalHeight).leftSpaceToView(self, MARGIN).widthIs(self.alertWidth - MARGIN * 2).autoHeightRatio(0);
//            CGRect rect = [attributeTitle.string boundingRectWithSize:CGSizeMake(self.titleLabel.width_sd, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.titleLabel.font} context:nil];
//            totalHeight += rect.size.height + 0.1;
        }

        if (!isCommonUnitEmptyString(message)) {
            totalHeight = nil == attributeTitle? totalHeight : totalHeight + sCommonUnitFontHeight;

            self.messageLabel = [[UILabel alloc] init];
            self.messageLabel.text = message;
            self.messageLabel.textColor = messageColor;
            self.messageLabel.backgroundColor = [UIColor clearColor];
            self.messageLabel.textAlignment = NSTextAlignmentCenter;
            self.messageLabel.font = sCommonUnitFont(messageSize);
            [self addSubview:self.messageLabel];
//            self.messageLabel.sd_layout.yIs(totalHeight).leftSpaceToView(self, MARGIN).widthIs(self.alertWidth - MARGIN * 2).autoHeightRatio(0);
//            CGRect rect = [message boundingRectWithSize:CGSizeMake(self.messageLabel.width_sd, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.messageLabel.font} context:nil];
//            totalHeight += rect.size.height + 0.1;
        }

        if (containerView) {
            if (!isCommonUnitEmpty(attributeTitle) || !isCommonUnitEmpty(message)) {
                totalHeight += sCommonUnitFontHeight;
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

- (void)addAction:(BITAlertAction *)action
{
    
    if (action && [action isKindOfClass:[BITAlertAction class]]) {
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
    for (BITAlertAction *action in self.actionBtns) {
        if(action.actionColor)
        {
            isColorAction = YES;
        }
        if (BITAlertActionStyleOK == action.style) {
            [okActions addSafeObject:action];
        } else if(BITAlertActionStyleCancel == action.style) {
            [cancelActions addSafeObject:action];
        } else {
            [defaultActions addSafeObject:action];
        }
    }
    self.actionBtns = [NSMutableArray arrayWithArray:cancelActions];
    [self.actionBtns addObjectsFromArray:defaultActions];
    [self.actionBtns addObjectsFromArray:okActions];
    [self.window makeKeyAndVisible];
    if(!isColorAction)
    {
        NSInteger numberOfButtons = self.actionBtns.count;
        if (numberOfButtons > 0) {
            if (numberOfButtons == 2) {
                for (int i = 0; i < self.actionBtns.count; i++) {
                    BITAlertAction *action = [self.actionBtns objectAtSafeIndex:i];
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame  = CGRectMake(0.f + ((self.alertWidth-sCommonUnit1PX())/2.f + sCommonUnit1PX()) * i, sCommonUnit1PX(), (self.alertWidth-sCommonUnit1PX())/2.f, ButtonHeight);
                    button.titleLabel.font = sCommonUnitBoldFont(buttonSize);
                    [button setTitle:action.title forState:UIControlStateNormal];
                    [button setTitleColor:action.actionTitleColor forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
                    [self.btnContainer addSubview:button];
                    button.tag = 100 + i;
                }
                
                UIView *contentBtnSegementLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.alertWidth, sCommonUnit1PX())];
                contentBtnSegementLine.backgroundColor = [UIColor colorWithHexValue:0xEEEEEE];
                [self.btnContainer addSubview:contentBtnSegementLine];
                
                UIView *btnSegmentLine = [[UIView alloc] initWithFrame:CGRectMake((self.alertWidth-sCommonUnit1PX())/2.f, 0.f, sCommonUnit1PX(), ButtonHeight)];
                btnSegmentLine.backgroundColor = [UIColor colorWithHexValue:0xc7c7c7];
                [self.btnContainer addSubview:btnSegmentLine];
//                self.btnContainer.sd_layout.heightIs(ButtonHeight);
            } else {
                CGFloat btnHeight = 0.f;
                for (int i = 0; i < self.actionBtns.count; i++) {
                    UIView *contentBtnSegementLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, btnHeight, self.alertWidth, sCommonUnit1PX())];
                    contentBtnSegementLine.backgroundColor = [UIColor colorWithHexValue:0xc7c7c7];
                    [self.btnContainer addSubview:contentBtnSegementLine];
                    BITAlertAction *action = [self.actionBtns objectAtSafeIndex:i];
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame  = CGRectMake(0.f, btnHeight + sCommonUnit1PX(), self.alertWidth, ButtonHeight);
                    button.titleLabel.font = sCommonUnitBoldFont(buttonSize);
                    [button setTitle:action.title forState:UIControlStateNormal];
                    [button setTitleColor:action.actionTitleColor forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
                    [self.btnContainer addSubview:button];
                    button.tag = 100 + i;
                    btnHeight = button.bottom;
                }
//                self.btnContainer.sd_layout.heightIs(btnHeight);
            }
        }
    }
    else
    {
        [self addColorAction];
    }
    [self.window addSubview:self];
//    self.sd_layout.centerXIs(sCommonUnitFullWidth() / 2).centerYIs(sCommonUnitFullHeight() / 2).widthIs(self.alertWidth).heightIs(self.btnContainer.bottom);
    [self addNotification];
}

-(void)addColorAction
{
    NSInteger numberOfButtons = self.actionBtns.count;
    if (numberOfButtons > 0) {
        if (numberOfButtons == 2) {
            for (int i = 0; i < self.actionBtns.count; i++) {
                BITAlertAction *action = [self.actionBtns objectAtSafeIndex:i];
//                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//                button.frame  = CGRectMake(0.f + ((self.alertWidth-sCommonUnit1PX())/2.f + sCommonUnit1PX()) * i, sCommonUnit1PX(), (self.alertWidth-sCommonUnit1PX())/2.f, ButtonHeight);
//                button.titleLabel.font = sCommonUnitBoldFont(buttonSize);
//                button.backgroundColor = [UIColor clearColor];
//                [button setTitle:@"" forState:UIControlStateNormal];
//                [button setTitleColor:action.actionTitleColor forState:UIControlStateNormal];
//                [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
//                [self.btnContainer addSubview:button];
//                button.tag = 200 + i;
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame  = CGRectMake(25.f*(i + 1) + 120 * i, sCommonUnit1PX(), 120, 35);
                btn.layer.cornerRadius = 35.f/2;
                btn.layer.masksToBounds = YES;
//                if(0 == i)
//                {
//                    btn.frame  = CGRectMake(25, (ButtonHeight - 35.0)/2, 120, 35);
//                }
//                else
//                {
//                    btn.frame  = CGRectMake(25, (ButtonHeight - 35.0)/2, 120, 35);
//                }
                btn.backgroundColor = action.actionColor;
                btn.titleLabel.font = sCommonUnitBoldFont(buttonSize);
                [btn setTitle:action.title forState:UIControlStateNormal];
                [btn setTitleColor:action.actionTitleColor forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.btnContainer addSubview:btn];
                btn.tag = 100 + i;
            }
            
            UIView *contentBtnSegementLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.alertWidth, sCommonUnit1PX())];
            contentBtnSegementLine.backgroundColor = [UIColor clearColor];
            [self.btnContainer addSubview:contentBtnSegementLine];
            
            UIView *btnSegmentLine = [[UIView alloc] initWithFrame:CGRectMake((self.alertWidth-sCommonUnit1PX())/2.f, 0.f, sCommonUnit1PX(), ButtonHeight)];
            btnSegmentLine.backgroundColor = [UIColor clearColor];
            [self.btnContainer addSubview:btnSegmentLine];
//            self.btnContainer.sd_layout.heightIs(35+20+sCommonUnit1PX());
        }
        else if(numberOfButtons == 1)
        {
            CGFloat btnHeight = 0.f;
            UIView *contentBtnSegementLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, btnHeight, self.alertWidth, sCommonUnit1PX())];
            contentBtnSegementLine.backgroundColor = [UIColor clearColor];
            [self.btnContainer addSubview:contentBtnSegementLine];
            BITAlertAction *action = [self.actionBtns objectAtSafeIndex:0];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame  = CGRectMake((ALERT_WIDTH - 120)/2, sCommonUnit1PX(), 120, 35);
            button.layer.cornerRadius = 35.f/2;
            button.layer.masksToBounds = YES;
            button.titleLabel.font = sCommonUnitBoldFont(buttonSize);
            [button setTitle:action.title forState:UIControlStateNormal];
            [button setTitleColor:action.actionTitleColor forState:UIControlStateNormal];
            button.backgroundColor = action.actionColor;
            [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnContainer addSubview:button];
            button.tag = 100;
            btnHeight = button.bottom;
//            self.btnContainer.sd_layout.heightIs(35+20+sCommonUnit1PX());
        }
        else {
            CGFloat btnHeight = 0.f;
            for (int i = 0; i < self.actionBtns.count; i++) {
                UIView *contentBtnSegementLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, btnHeight, self.alertWidth, sCommonUnit1PX())];
                contentBtnSegementLine.backgroundColor = [UIColor clearColor];
                [self.btnContainer addSubview:contentBtnSegementLine];
                BITAlertAction *action = [self.actionBtns objectAtSafeIndex:i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame  = CGRectMake(25.f*(i + 1)+ (ALERT_WIDTH -25*(self.actionBtns.count+1))/(self.actionBtns.count)* i, sCommonUnit1PX(), (ALERT_WIDTH -25*(self.actionBtns.count+1))/(self.actionBtns.count), 35);
                button.layer.cornerRadius = 35.f/2;
                button.layer.masksToBounds = YES;
                button.titleLabel.font = sCommonUnitBoldFont(buttonSize);
                [button setTitle:action.title forState:UIControlStateNormal];
                [button setTitleColor:action.actionTitleColor forState:UIControlStateNormal];
                [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.btnContainer addSubview:button];
                button.tag = 100 + i;
                btnHeight = button.bottom;
            }
//            self.btnContainer.sd_layout.heightIs(35+20+sCommonUnit1PX());
        }
    }
}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - keyboard
- (void)keyboardWillShow:(NSNotification *)notification
{
    @weakify(self);
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    UIViewAnimationCurve animationCurve = [info[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    if (sCommonUnitFullHeight() - self.bottom < kbSize.height) {
        [UIView animateWithDuration:[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue] delay:0 options:(animationCurve << 16) animations:^{
            @strongify(self);
            
            self.bottom = sCommonUnitFullHeight() - kbSize.height;
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    @weakify(self);
    NSDictionary *info = [notification userInfo];
    [UIView animateWithDuration:[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        @strongify(self);
        self.centerY = sCommonUnitFullHeight()/2;
    } completion:^(BOOL finished) {
        
    }];
}


- (void)handleAction:(UIButton *)button
{
    NSInteger tag = button.tag;
    BITAlertAction *action = [self.actionBtns objectAtSafeIndex:tag - 100];
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
    [self alertViewWillShow];
    
    [self animationAlert];
    self.montLayerView.alpha = 0.0f;
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        self.montLayerView.alpha = 0.9f;
    }];
}

- (void)hide
{
    @weakify(self);
    [self removeNotification];
    // 隐藏遮罩
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        self.montLayerView.alpha = 0.0f;
    }];
    
    [UIView animateWithDuration:0.3 animations:^{
        @strongify(self);
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        @strongify(self);
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

@end
