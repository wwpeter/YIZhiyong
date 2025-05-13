//
//  BITAlertView.h
//  Pods
//
//  Created by huihui on 2019/1/2.
//  Copyright © 2019年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BITAlertAction;

typedef NS_ENUM(NSInteger, BITAlertViewStyle)
{
    BITAlertViewStyleAlert = 0,
    BITAlertViewStyleActionSheet
};

typedef NS_ENUM(NSInteger, BITAlertActionStyle)
{
    BITAlertActionStyleDefault = 0,
    BITAlertActionStyleCancel,
    BITAlertActionStyleOK
};



@interface BITAlertAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(BITAlertActionStyle)style handler:(void(^)(BITAlertAction *action))handler;

+ (instancetype)actionWithTitle:(NSString *)title style:(BITAlertActionStyle)style actionColor:(UIColor *)actionColor handler:(void(^)(BITAlertAction *action))handler;

@end


@interface BITAlertView : UIView

@property (nonatomic, assign) BOOL shouldAutoDismiss;//是否自动消失,默认YES

/**
 初始化方法

 @param title 标题
 @param message 消息内容
 @param containerView 自定义view
 @param alertStyle alert的类型
 */
+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message containerView:(UIView *)containerView alertStyle:(BITAlertViewStyle)alertStyle;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message containerView:(UIView *)containerView alertStyle:(BITAlertViewStyle)alertStyle;

//添加按钮
- (void)addAction:(BITAlertAction *)action;

//显示
- (void)show;

//隐藏
- (void)hide;

@end
