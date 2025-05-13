//
//  BGAlertNoticeView.h
//  Pods
//
//  Created by huihui on 2019/1/2.
//  Copyright © 2019年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BGAlertNoticeAction;

typedef NS_ENUM(NSInteger, BGAlertNoticeViewStyle)
{
    BGAlertNoticeViewStyleAlert = 0,
    BGAlertNoticeViewStyleActionSheet
};

typedef NS_ENUM(NSInteger, BGAlertNoticeActionStyle)
{
    BGAlertNoticeActionStyleDefault = 0,
    BGAlertNoticeActionStyleCancel,
    BGAlertNoticeActionStyleOK
};



@interface BGAlertNoticeAction : NSObject

+ (instancetype)actionWithTitle:(NSString *)title style:(BGAlertNoticeActionStyle)style handler:(void(^)(BGAlertNoticeAction *action))handler;

+ (instancetype)actionWithTitle:(NSString *)title style:(BGAlertNoticeActionStyle)style actionColor:(UIColor *)actionColor handler:(void(^)(BGAlertNoticeAction *action))handler;

@end


@interface BGAlertNoticeView : UIView

@property (nonatomic, assign) BOOL shouldAutoDismiss;//是否自动消失,默认YES

/**
 初始化方法

 @param title 标题
 @param message 消息内容
 @param containerView 自定义view
 @param alertStyle alert的类型
 */
+ (instancetype)alertWithIcon:(UIImage *)icon  message:(NSString *)message containerView:(UIView *)containerView alertStyle:(BGAlertNoticeViewStyle)alertStyle;

- (instancetype)initWithIcon:(UIImage *)icon message:(NSString *)message containerView:(UIView *)containerView alertStyle:(BGAlertNoticeViewStyle)alertStyle;

//显示
- (void)show;

//隐藏
- (void)hide;

@end
