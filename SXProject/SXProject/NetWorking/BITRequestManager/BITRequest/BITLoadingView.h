//
//  BITLoadingView.h
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

#import <UIKit/UIKit.h>

@interface BITLoadingView : UIView

+ (void)show;
+ (void)showClearHUD;

+ (void)hide;
+ (void)showFirstHub;
+ (void)showFirstClearHub;
+ (void)resetResponseDisplayFlag;

@end
