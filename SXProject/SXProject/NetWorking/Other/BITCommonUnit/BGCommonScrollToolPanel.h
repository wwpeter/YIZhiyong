//
//  BGCommonScrollToolPanel.h
//  ChildishBeautyParent
//
//  Created by jiaguoshang on 2017/6/6.
//  Copyright © 2018年 Hangzhou bingo Internet Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGCommonScrollToolPanel : UIView

@property (nonatomic, copy) void(^hitCallback)(NSInteger index);
@property (nonatomic, assign) BOOL isSendindRequest;

- (instancetype)initWithFrame:(CGRect)frame underlineColor:(UIColor *)underlineColor TitleArr:(NSMutableArray *)titleArr textColor:(UIColor *)textColor selectTextColor:(UIColor *)selectTextColor;

@end
