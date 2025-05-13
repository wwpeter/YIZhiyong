//
//  BITInputAlertView.h
//  Pods
//
//  Created by huihui on 2019/1/2.
//  Copyright © 2019年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BITInputAlertAction;

typedef NS_ENUM(NSInteger, BITInputAlertViewStyle)
{
    BITInputAlertViewStyleAlert = 0,
    BITInputAlertViewStyleActionSheet
};

typedef NS_ENUM(NSInteger, BITInputAlertActionStyle)
{
    BITInputAlertActionStyleDefault = 0,
    BITInputAlertActionStyleCancel,
    BITInputAlertActionStyleOK
};



@interface BITInputAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(BITInputAlertActionStyle)style handler:(void(^)(BITInputAlertAction *action, NSString *cancelReason))handler;

@end


@interface BITInputAlertView : UIView

@property (nonatomic, assign) BOOL shouldAutoDismiss;//是否自动消失,默认YES

/**
 初始化方法

 @param title 标题
 @param message 消息内容
 @param containerView 自定义view
 @param alertStyle alert的类型
 */
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message containerView:(UIView *)containerView alertStyle:(BITInputAlertViewStyle)alertStyle;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message containerView:(UIView *)containerView alertStyle:(BITInputAlertViewStyle)alertStyle;

//添加按钮
- (void)addAction:(BITInputAlertAction *)action;

//显示
- (void)show;

//隐藏
- (void)hide;

@end
