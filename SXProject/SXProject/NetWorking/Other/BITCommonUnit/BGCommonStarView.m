//
//  BGCommonStarView.m
//  ChildishBeautyParent
//
//  Created by jiaguoshang on 2017/6/6.
//  Copyright © 2018年 Hangzhou bingo Internet Technology Co., Ltd. All rights reserved.
//

#import "BGCommonStarView.h"
#import "BGCommonButton.h"
#import "NSMutableArray+BitInfo.h"
#import "NSArray+BitInfo.h"

@interface BGCommonStarView()

//@property (nonatomic, strong) SDCycleScrollView *imagesScrollView;
@property (nonatomic, strong) UIView *bigBackgroundView;
//@property (nonatomic, strong) UIImageView *makeFriendsImageView;
@property (nonatomic, strong) UIImageView *hot_message_backgroundImageView;

@property (nonatomic, strong) NSMutableArray *iconsList;
@property (nonatomic, strong) NSMutableArray *titlesList;
@property (nonatomic, strong) NSMutableArray *smallIconsList;
@property (nonatomic, strong) NSMutableArray *btnsList;


@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, assign) CGFloat interval;
@property (nonatomic, assign) NSUInteger count;
@end
@implementation BGCommonStarView

- (id)initWithCount:(NSUInteger)count icon:(UIImage *)icon interval:(CGFloat)interval sno:(NSInteger)sno frame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViewWithCount:count icon:icon interval:interval sno:sno frame:frame];
    }
    
    return  self;
    
}

-(void)setupViewWithCount:(NSUInteger)count icon:(UIImage *)icon interval:(CGFloat)interval sno:(NSInteger)sno frame:(CGRect)frame
{
//    self.bigBackgroundView = [[UIView alloc] init];
//    self.bigBackgroundView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:self.bigBackgroundView];
    self.frame = frame;
    self.count = count;
    self.interval = interval;
    self.icon = icon;
    if(count < 0 || !icon)
    {
        return;
    }
//    [self.bigBackgroundView addSubview:self.hot_message_backgroundImageView];

    for(NSInteger i = 0; i < count; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;//等比缩放把图片整体显示在ImageView中，所以可能会出现ImageView有空白部分 UIViewContentModeScaleAspectFill;//等比缩放图片把整个ImageView填充满，所以可能会出现图片部分显示不出来
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = [UIColor clearColor];
        imageView.image = icon;
        imageView.frame = CGRectMake(i*(interval + icon.size.width), 0, icon.size.width, icon.size.height);
        [self addSubview:imageView];
        imageView.hidden = YES;
        [self.iconsList addSafeObject:imageView];
    }
    self.sno = sno;
//    [self unitsSdLayout];

}

-(void)setSno:(NSInteger)sno
{
    for(NSInteger i = 0; i < self.count && i < self.iconsList.count; i++)
    {
        UIImageView *imageView = [self.iconsList bitobjectOrNilAtIndex:i];
        imageView.hidden = !(i < sno);
    }
    _sno = sno;
}

//-(void)unitsSdLayout
//{
//    self.bigBackgroundView.sd_layout
//    .topSpaceToView(self, 0)
//    .leftSpaceToView(self, 0)
//    .widthIs(self.frame.size.width)
//    .heightIs(self.frame.size.height);
//
//
//    self.hot_message_backgroundImageView.sd_layout
//    .topSpaceToView(self.bigBackgroundView, 0)
//    .rightSpaceToView(self.bigBackgroundView, COMMON_EDGE_DISTANCE)
//    .widthIs(FULL_WIDTH - COMMON_EDGE_DISTANCE*2)
//    .heightIs((FULL_WIDTH - COMMON_EDGE_DISTANCE*2)*160/345);
//}

//
//- (PPHotPayMessageView *)highlightedMessageView {
//
//    if(!_highlightedMessageView)
//    {
//        _highlightedMessageView = [[PPHotPayMessageView alloc] init];
//        _highlightedMessageView.hidden = YES;
//    }
//    return _highlightedMessageView;
//}

- (NSMutableArray *)iconsList {
    if(!_iconsList)
    {
        _iconsList= [NSMutableArray array];
    }
    return _iconsList;
}

//- (NSMutableArray *)iconsList {
//    if(!_iconsList)
//    {
//        _iconsList = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"椭圆 1 拷贝"], [UIImage imageNamed:@"椭圆 1 拷贝 2"], [UIImage imageNamed:@"渐变填充 1"], [UIImage imageNamed:@"椭圆 1"], nil];
//    }
//    return _iconsList;
//}
//
//- (NSMutableArray *)titlesList {
//    if(!_titlesList)
//    {
//        _titlesList = [NSMutableArray arrayWithObjects:@"能力测评", @"我的计划", @"每日日报", @"园区介绍", nil];
//    }
//    return _titlesList;
//}
//
//- (NSMutableArray *)smallIconsList {
//    if(!_smallIconsList)
//    {
//        _smallIconsList = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"矢量智能对象(1)"], [UIImage imageNamed:@"矢量智能对象(2)"], [UIImage imageNamed:@"日报"], [UIImage imageNamed:@"矢量智能对象"], nil];
//    }
//    return _smallIconsList;
//}
//
//- (UIImageView *)hot_message_backgroundImageView {
//    if(!_hot_message_backgroundImageView)
//    {
//        _hot_message_backgroundImageView = [self createImageView];
////        _hot_message_backgroundImageView.backgroundColor = [UIColor redColor];
//        _hot_message_backgroundImageView.image = [UIImage imageNamed:@"扶助宝贝成为未来之星"];
//        [_hot_message_backgroundImageView addCornerWithCornerRadius:COMMON_CORNER_RADIUS];
////        _hot_message_backgroundImageView.userInteractionEnabled = YES;
//    }
//    return _hot_message_backgroundImageView;
//}

//- (UIImageView *)makeFriendsImageView {
//    if(!_makeFriendsImageView)
//    {
//        _makeFriendsImageView = [self createImageView];
//        _makeFriendsImageView.backgroundColor = BGColorHex(F9F9F9);
////        _makeFriendsImageView.image = [UIImage imageNamed:@"message_background"];
////        _makeFriendsImageView.userInteractionEnabled = YES;
//    }
//    return _makeFriendsImageView;
//}

//- (UIButton *)hitBtn {
//    if(!_hitBtn)
//    {
//        _hitBtn = [self createButton];
//        [_hitBtn addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
//        [_hitBtn setImage:nil forState:UIControlStateNormal];
//        [_hitBtn setTitle:@"查看全部 >" forState:UIControlStateNormal];
//        [_hitBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:12]];
//        [_hitBtn setTitleColor:BGColorHex(999999) forState:UIControlStateNormal];
//        _hitBtn.hidden = YES;
////        _hitBtn.userInteractionEnabled = YES;
//    }
//    return _hitBtn;
//}
//
//-(void)hitAction:(UIButton *)button
//{
////    [BITRouter openURL:@"gb://broadcastFriendViewController"];
//}

//-(void)setModel:(PPHotListEntity *)model{
//    if(isEmptyArray(model.roomList) || ![model.roomList isKindOfClass:[NSArray class]])
//    {
//        return;
//    }
//    _model = model;
//
////    NSMutableArray *imagesURLStrings = [NSMutableArray array];
////    for(PPHotEntity *entity in model.entityList)
////    {
////        [imagesURLStrings addSafeObject:entity.imageURL];
////    }
////
////    [self.imagesScrollView setImageURLStringsGroup:imagesURLStrings];
//}
//
//-(void)setRoomCateListEntity:(PPRoomCateListEntity *)roomCateListEntity
//{
//    _roomCateListEntity = roomCateListEntity;
//
//    NSMutableArray *imagesURLStrings = [NSMutableArray array];
//    for(PPBannerEntity *entity in roomCateListEntity.bannerList)
//    {
//        [imagesURLStrings addSafeObject:entity.banner_pic];
//    }
//    [self.imagesScrollView setImageURLStringsGroup:imagesURLStrings];
//    self.imagesScrollView.frame = CGRectMake(COMMON_EDGE_DISTANCE, 0, self.frame.size.width-COMMON_EDGE_DISTANCE*2, 104);
//}


@end
