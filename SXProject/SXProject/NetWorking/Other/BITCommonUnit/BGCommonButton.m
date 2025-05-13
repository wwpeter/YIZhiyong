//
//  BGCommonButton.m
//  ChildishBeautyParent
//
//  Created by jiaguoshang on 2017/9/4.
//  Copyright © 2017年 Hangzhou Bingo Internet Technology Co., Ltd. All rights reserved.
//

#import "BGCommonButton.h"
#import "BITCommonUnitKeys.h"

#define COMMON_UNIT_EDGE_DISTANCE 15
//注意服务器返回数字类型的key-value的value值，若当字符串判断，结果为非字符串
static inline NSString *getCommonUnitNotNilString(id thing) {
    if(thing == nil)
    {
        return @"";
    }
    NSString *str = [NSString stringWithFormat:@"%@", thing];
    return [NSString stringWithFormat:@"%@",str];
}

@interface BGCommonButton ()

@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, strong) UIImage *smallIcon;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIImageView *decribeImageView;
@property (nonatomic, strong) UILabel *describeTitleLabel;

@end

@implementation BGCommonButton

//-(void)setIsSelect:(BOOL)isSelect{
//    _isSelect = isSelect;
//    if(_isSelect)
//    {
//        [self setImage:self.smallIcon forState:UIControlStateNormal];
//        [self setTitleColor:self.titleColor forState:(UIControlStateNormal)];
//    }
//    else
//    {
//        [self setImage:self.icon forState:UIControlStateNormal];
//        [self setTitleColor:self.titleColor forState:(UIControlStateNormal)];
//    }
////    self.layer.cornerRadius = 15;
////    [self.layer setMasksToBounds:YES];
//    if (self.selectBlock) {
//        self.selectBlock(isSelect);
//    }
//}


- (id)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor icon:(UIImage *)icon smallIcon:(UIImage *)smallIcon cornerRadius:(CGFloat)cornerRadius sno:(NSInteger)sno frame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 12, 12)];
    
    if (self)
    {
        
//        self.isSelect = NO;
             
        self.icon = icon;
        self.smallIcon = smallIcon;
        self.titleColor = titleColor;
        _title = title;
        self.cornerRadius = cornerRadius;
        self.sno = sno;
        self.frame = frame;
        [self setTitle:getCommonUnitNotNilString(@"") forState:UIControlStateNormal];
        if(self.smallIcon && title)
        {
            [self addSubview:self.decribeImageView];
            [self addSubview:self.describeTitleLabel];
            self.decribeImageView.frame = CGRectMake(COMMON_UNIT_EDGE_DISTANCE, (self.frame.size.height - self.smallIcon.size.height - 13 -10)/2, self.smallIcon.size.width, self.smallIcon.size.height);
        }
        [self setImage:self.icon forState:UIControlStateNormal];
        [self setImage:self.icon forState:UIControlStateHighlighted];
        [self setImage:self.icon forState:UIControlStateSelected];
//        [self setTitleColor:titleColor forState:(UIControlStateNormal)];
        self.imageView.layer.cornerRadius = cornerRadius;
        self.imageView.layer.masksToBounds = YES;
//        [self.imageView addCornerWithCornerRadius:cornerRadius];
        [self addTarget:self action:@selector(didSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
//    if (self = [super init]) {
//        self = [[se alloc] init];
//
//    }
    return self;
}

- (void)addCornerWithCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

-(void)didSelectAction:(UIButton *)button
{
    if (self.hitBlock) {
        self.hitBlock(self.sno);
    }
}

- (UIImageView *)decribeImageView {
    if(!_decribeImageView)
    {
        _decribeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(COMMON_UNIT_EDGE_DISTANCE, (self.frame.size.height - self.smallIcon.size.height - 13 -10)/2, self.smallIcon.size.width, self.smallIcon.size.height)];
        _decribeImageView.backgroundColor = [UIColor clearColor];
        _decribeImageView.image = self.smallIcon;
    }
    return _decribeImageView;
}

- (UILabel *)describeTitleLabel {

    if(!_describeTitleLabel)
    {
        _describeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - self.smallIcon.size.height - 13 -10)/2+self.smallIcon.size.height + 10, self.frame.size.width, 13)];
        _describeTitleLabel.backgroundColor = [UIColor clearColor];
        _describeTitleLabel.textAlignment = NSTextAlignmentCenter;
        _describeTitleLabel.font = [UIFont systemFontOfSize:13];
        _describeTitleLabel.textColor = [UIColor whiteColor];
        _describeTitleLabel.text = getCommonUnitNotNilString(self.title);
    }

    return _describeTitleLabel;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    self.describeTitleLabel.text = getCommonUnitNotNilString(self.title);
}

@end
