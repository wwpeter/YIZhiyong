//
//  BITTextFieldProcess.h
//  Pods
//
//  Created       on 2018/8/2.
//  Copyright © 2017年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface BITTextFieldProcess : NSObject

#pragma mark - 3 4 4分割的手机号输入功能函数
+ (BOOL)inputTelephone : (UITextField *)textField : (NSRange)range : (NSString *)string;

@end

