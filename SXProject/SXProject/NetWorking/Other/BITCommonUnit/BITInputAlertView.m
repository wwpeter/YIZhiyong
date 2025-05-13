//
//  BITInputAlertView.m
//  Pods
//
//  Created by huihui on 2019/1/2.
//  Copyright © 2019年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import "BITInputAlertView.h"
#import "BITCommonUnitKeys.h"
#import "BITLogMacro.h"
#import "ReactiveObjC.h"
#import "BITCocoaLumberjack.h"
#import "BITCocoaLumberjackMacro.h"

#define titleSize        18.f
#define messageSize      14.f
#define titleColor       [UIColor colorWithHexValue:0x0a0a0a]
//#define ALERT_WIDTH      300.f
#define montLayerColor   [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]//[[UIColor colorWithHexValue:0x848484)colorWithAlphaComponent:0.5f]
#define lineColor        [UIColor colorWithHexValue:0xc7c7c7]
#define DefaultHeight    27.f
#define MARGIN           25.f
#define titleLabelHeight 20.f
#define ButtonHeight     50.f
#define isIpad ([[UIScreen mainScreen] bounds].size.width >= 768 && [[UIScreen mainScreen] bounds].size.height >= 768)
#define ALERT_WIDTH      (isIpad ? 600 : 300)

@interface BITInputAlertAction ()

@property (nonatomic, copy) void(^handler)(BITInputAlertAction *action, NSString *cancelReason);

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) BITInputAlertActionStyle style;

@property (nonatomic, strong) UIColor *actionTitleColor;

@end
@implementation BITInputAlertAction

+ (instancetype)actionWithTitle:(NSString *)title
                          style:(BITInputAlertActionStyle)style
                        handler:(void (^)(BITInputAlertAction *action, NSString *cancelReason))handler
{
    BITInputAlertAction *action = [[BITInputAlertAction alloc] init];
    action.title = title;
    action.style = style;
    action.handler = handler;
    if (style == BITInputAlertActionStyleOK) {
        action.actionTitleColor = [UIColor colorWithHexValue:0x0a0a0a];
    } else {
        action.actionTitleColor = [UIColor colorWithHexValue:0x0a0a0a];
    }
    return action;
}

@end



@interface BITInputAlertView ()<UITextViewDelegate>

@property (nonatomic, strong) UIView         *montLayerView;//蒙层

@property (nonatomic, strong) UILabel        *titleLabel;//标题

@property (nonatomic, strong) UIButton       *rightBtn;//右上角按钮

@property (nonatomic, strong) UIView         *containerView;//内容

@property (nonatomic, strong) NSMutableArray <BITInputAlertAction *>*actionBtns;//下方按钮事件集合

@property (nonatomic, strong) UIWindow       *window;//window

@property (nonatomic, assign) CGFloat        alertWidth;//宽度

@property (nonatomic, strong) UILabel        *messageLabel;//消息内容

@property (nonatomic, strong) UIView         *btnContainer;//按钮view

@property (nonatomic, strong) UITextView     *cancelReasonTextView;//取消原因
@property (nonatomic, strong) UILabel        *placeholderLabel;

@end

@implementation BITInputAlertView

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
            alertStyle:(BITInputAlertViewStyle)alertStyle
{
    NSMutableAttributedString *attributedString = nil;
    NSString *loadMessage = message;
    if (!isCommonUnitEmpty(title)) {
        attributedString = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedString addAttributes:@{NSFontAttributeName:sCommonUnitBoldFont(titleSize), NSForegroundColorAttributeName:titleColor} range:NSMakeRange(0, attributedString.length)];
    } else {
        if (!isCommonUnitEmpty(message)) {
            attributedString = [[NSMutableAttributedString alloc] initWithString:message];
            [attributedString addAttributes:@{NSFontAttributeName:sCommonUnitBoldFont(titleSize), NSForegroundColorAttributeName:titleColor} range:NSMakeRange(0, attributedString.length)];
            loadMessage = nil;
        }
    }
    BITInputAlertView *alertView = [[BITInputAlertView alloc] initWithWidth:ALERT_WIDTH
                                                 attributeTitle:attributedString
                                                        message:loadMessage
                                                  containerView:containerView
                                                     alertStyle:alertStyle];
    return alertView;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                containerView:(UIView *)containerView
                   alertStyle:(BITInputAlertViewStyle)alertStyle
{
    NSMutableAttributedString *attributedString = nil;
    NSString *loadMessage = message;
    if (!isCommonUnitEmpty(title)) {
        attributedString = [[NSMutableAttributedString alloc] initWithString:title];
        [attributedString addAttributes:@{NSFontAttributeName:sCommonUnitBoldFont(titleSize), NSForegroundColorAttributeName:titleColor} range:NSMakeRange(0, attributedString.length)];
    } else {
        if (!isCommonUnitEmpty(message)) {
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
                   alertStyle:(BITInputAlertViewStyle)alertStyle
{
    self = [super init];
    if (self) {
        self.shouldAutoDismiss = YES;
        self.opaque = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 3.f;
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
        self.window.windowLevel = UIWindowLevelStatusBar + 2;
        self.window.opaque = NO;
        //初始化蒙层
        self.montLayerView.backgroundColor = montLayerColor;
        self.montLayerView.opaque = NO;
        [self.window addSubview:self.montLayerView];
        CGFloat totalHeight = 20.f;
      
    }
    return self;
}

- (void)addAction:(BITInputAlertAction *)action
{
    
    if (action && [action isKindOfClass:[BITInputAlertAction class]]) {
        [self.actionBtns addObject:action];
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
    for (BITInputAlertAction *action in self.actionBtns) {
        if (BITInputAlertActionStyleCancel == action.style) {
            [okActions addObject:action];
        } else if(BITInputAlertActionStyleOK == action.style) {
            [cancelActions addObject:action];
        } else {
            [defaultActions addObject:action];
        }
    }
    self.actionBtns = [NSMutableArray arrayWithArray:cancelActions];
    [self.actionBtns addObjectsFromArray:defaultActions];
    [self.actionBtns addObjectsFromArray:okActions];
    [self.window makeKeyAndVisible];
    NSInteger numberOfButtons = self.actionBtns.count;
    if (numberOfButtons > 0) {
        if (numberOfButtons == 2) {
            for (int i = 0; i < self.actionBtns.count; i++) {
                BITInputAlertAction *action = [self.actionBtns objectAtSafeIndex:i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame  = CGRectMake(0.f + ((self.alertWidth-sCommonUnit1PX())/2.f + sCommonUnit1PX()) * i, sCommonUnit1PX(), (self.alertWidth-sCommonUnit1PX())/2.f, ButtonHeight);
                button.titleLabel.font = sCommonUnitBoldFont(titleSize);
                [button setTitle:action.title forState:UIControlStateNormal];
                [button setTitleColor:action.actionTitleColor forState:UIControlStateNormal];
                [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.btnContainer addSubview:button];
                button.tag = 100 + i;
            }
            
            UIView *contentBtnSegementLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.alertWidth, sCommonUnit1PX())];
            contentBtnSegementLine.backgroundColor = [UIColor colorWithHexValue:0xc7c7c7];
            [self.btnContainer addSubview:contentBtnSegementLine];
            
            UIView *btnSegmentLine = [[UIView alloc] initWithFrame:CGRectMake((self.alertWidth-sCommonUnit1PX())/2.f, 0.f, sCommonUnit1PX(), ButtonHeight)];
            btnSegmentLine.backgroundColor = [UIColor colorWithHexValue:0xc7c7c7];
            [self.btnContainer addSubview:btnSegmentLine];
      
        } else {
            CGFloat btnHeight = 0.f;
            for (int i = 0; i < self.actionBtns.count; i++) {
                UIView *contentBtnSegementLine = [[UIView alloc] initWithFrame:CGRectMake(0.f, btnHeight, self.alertWidth, sCommonUnit1PX())];
                contentBtnSegementLine.backgroundColor = [UIColor colorWithHexValue:0xc7c7c7];
                [self.btnContainer addSubview:contentBtnSegementLine];
                BITInputAlertAction *action = [self.actionBtns objectAtSafeIndex:i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame  = CGRectMake(0.f, btnHeight + sCommonUnit1PX(), self.alertWidth, ButtonHeight);
                button.titleLabel.font = sCommonUnitBoldFont(titleSize);
                [button setTitle:action.title forState:UIControlStateNormal];
                [button setTitleColor:action.actionTitleColor forState:UIControlStateNormal];
                [button addTarget:self action:@selector(handleAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.btnContainer addSubview:button];
                button.tag = 100 + i;
                btnHeight = button.bottom;
            }
       
        }
    }
    [self.window addSubview:self];

    [self addNotification];
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
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
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
    BITInputAlertAction *action = [self.actionBtns objectAtSafeIndex:tag - 100];
    if (action && action.handler) {
        action.handler(action, self.cancelReasonTextView.text);
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
        [self endEditing:NO];
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

- (void)textChanged:(NSNotification *)notification
{
    if(self.cancelReasonTextView.text.length == 0)
    {
        self.placeholderLabel.hidden = NO;
        return;
    }
    else
    {
        if(!(self.placeholderLabel.hidden))
        {
            self.placeholderLabel.hidden = YES;
        }
        
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if (text.length > 0) {
        
        if(self.cancelReasonTextView.text.length + text.length > 200)
        {
            return NO;
        }
    }
    
    return YES;
}

@end
