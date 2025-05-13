//
//  BGCommonButton.h
//  ChildishBeautyParent
//
//  Created by jiaguoshang on 2017/9/4.
//  Copyright © 2017年 Hangzhou Bingo Internet Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BGCommonButton : UIButton

@property (nonatomic, assign) NSInteger sno;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) void (^hitBlock)(NSInteger sno);


- (id)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor icon:(UIImage *)icon smallIcon:(UIImage *)smallIcon cornerRadius:(CGFloat)cornerRadius sno:(NSInteger)sno frame:(CGRect)frame;

@end
