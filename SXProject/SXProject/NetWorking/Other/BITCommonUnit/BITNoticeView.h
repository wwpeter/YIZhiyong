//
//  BITNoticeView.h
//  Pods
//
//  Created by jiaguoshang on 2019/1/18.
//  Copyright © 2019年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BITNSObject.h"

@interface BITNoticeView : UIView


/**
 返回当前的notice对象
 
 @return currentNotice
 */
+ (BITNoticeView *)currentNotice;

/**
 成功类型的notice
 
 @param notice 消息
 */
- (void)showSuccessNotice:(NSString *)notice;

/**
 失败类型的notice
 
 @param notice 消息
 */
- (void)showErrorNotice:(NSString *)notice;
/**
 错误类型的error
 
 @param error 消息
 */
- (void)showErrorInfo:(NSError *)error;
@end

