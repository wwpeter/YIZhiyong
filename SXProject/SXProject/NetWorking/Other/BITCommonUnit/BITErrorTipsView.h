//
//  BITErrorTipsView.h
//  Pods
//
//  Created by jiaguoshang on 2019/2/6.
//  Copyright © 2019年 YiXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BITErrorTipsViewDelegate <NSObject>

- (void)doRetryHandler;

@end
/**
 页面加载错误提示页
 */
@interface BITErrorTipsView : UIView

@property (nonatomic, weak) id<BITErrorTipsViewDelegate> delegate;

/**
 默认错误提示和错误icon
 */
- (void)show;
/**
 默认错误提示和错误icon
 */
- (void)showWithTips:(NSString *)tips icon:(NSString *)icon;

- (void)hide;

@end
