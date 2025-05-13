//
//  BGCommonStarView.h
//  ChildishBeautyParent
//
//  Created by jiaguoshang on 2017/6/6.
//  Copyright © 2018年 Hangzhou bingo Internet Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PPHotListEntity.h"
//#import "PPHotPayMessageView.h"
//#import "PPRoomCateListEntity.h"
//#import "PPHotListEntity.h"

@interface BGCommonStarView : UIView

@property (nonatomic, assign) NSInteger sno;
@property (nonatomic, copy) void (^hitBlock)(NSInteger sno);


- (id)initWithCount:(NSUInteger)count icon:(UIImage *)icon interval:(CGFloat)interval sno:(NSInteger)sno frame:(CGRect)frame;
@end
