//
//  BGCommonScrollToolPanel.m
//  ChildishBeautyParent
//
//  Created by jiaguoshang on 2017/6/6.
//  Copyright © 2018年 Hangzhou bingo Internet Technology Co., Ltd. All rights reserved.
//

#import "BGCommonScrollToolPanel.h"
#import "NSArray+BitInfo.h"
#import "BITCommonUnitKeys.h"

#define TOOL_TITLE_LEFT_Margin     15
#define TOOL_UNDERLINE_LEFT_Margin 22
#define TOOL_CHARACTER_WIDTH       15
#define TOOL_TITLE_INTERVAL        20

@interface BGCommonScrollToolPanel ()<UIScrollViewDelegate>
@property (nonatomic,strong) UIScrollView *alertBackgroundView;
@property (nonatomic,strong) NSMutableArray *titleBtnsArr;
@property (nonatomic,strong) UIPanGestureRecognizer *painRecognize1;
@property (nonatomic,strong) NSMutableArray *titleArr;
@property (nonatomic,strong) NSMutableArray *titleBtnWidthArr;
//@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) NSMutableArray *underlineViewsArr;
//@property (nonatomic,strong) NSMutableArray *widthArr;
@property (nonatomic,assign) NSUInteger selectIndex;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *selectTextColor;
@property (nonatomic,assign) long totalWidth;
@property (nonatomic,strong) UIColor *underlineColor;
@property (nonatomic, assign) BOOL isLoad;
@end

@implementation BGCommonScrollToolPanel

//+ (instancetype)createPanelWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr
//{
//    return [[self alloc] initFramPanelWithTitleArr:titleArr];
//}

- (instancetype)initWithFrame:(CGRect)frame underlineColor:(UIColor *)underlineColor TitleArr:(NSMutableArray *)titleArr textColor:(UIColor *)textColor selectTextColor:(UIColor *)selectTextColor
{
    self.backgroundColor = [UIColor clearColor];
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSubPanelWithTitleArr:titleArr underlineColor:underlineColor textColor:textColor selectTextColor:selectTextColor];
    }
    return self;
}

- (long )getSizeOfString:(NSString *)string{
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};     //字体属性，设置字体的font
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);     //设置字符串的宽高  MAXFLOAT为最大宽度极限值  30为固定高度
    CGSize size = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    long width = (long)(size.width + 0.5);
    return width;     //此方法结合  预编译字符串  字体font  字符串宽高  三个参数计算文本  返回字符串宽度
}


- (long)getViewRectWithTitleArr:(NSArray *)titleArr
{
    long totalWidth = 0;
    _titleArr = [NSMutableArray array];
    self.underlineViewsArr = [NSMutableArray array];
//    self.widthArr = [NSMutableArray array];
    self.titleBtnsArr = [NSMutableArray array];
    self.titleBtnWidthArr = [NSMutableArray array];
    for(NSString *title in titleArr)
    {
        if(!isCommonUnitEmptyString(title))
        {
            long width = [self getSizeOfString:title];
            if(width < 30)
            {
                width = 30;
            }
            if(0 == totalWidth)
            {
                totalWidth = width + TOOL_TITLE_LEFT_Margin*2;
            }
            else
            {
                totalWidth = totalWidth + width + TOOL_TITLE_INTERVAL;
            }
            [self.titleBtnWidthArr addObject:[NSString stringWithFormat:@"%ld",width]];
            [self.titleArr addObject:title];
        }
    }
    self.totalWidth = totalWidth;
    return totalWidth;
}


- (void)initSubPanelWithTitleArr:(NSMutableArray *)titleArr underlineColor:(UIColor *)underlineColor textColor:(UIColor *)textColor selectTextColor:(UIColor *)selectTextColor
{
    self.textColor = textColor;
    self.selectTextColor = selectTextColor;
    self.underlineColor = underlineColor;
    self.titleArr = titleArr;
}

-(void)setTitleArr:(NSMutableArray *)titleArr
{
    if((titleArr == nil) || ![titleArr isKindOfClass:[NSArray class]] || (titleArr.count == 0) || self.isLoad)
    {
        return;
    }
    self.isLoad = YES;
    self.totalWidth = [self getViewRectWithTitleArr:titleArr];
    //大背景
//    self.alertBackgroundView = [[UIScrollView alloc] init];
    self.alertBackgroundView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.alertBackgroundView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.alertBackgroundView];
    self.alertBackgroundView.delegate = self;
    self.alertBackgroundView.pagingEnabled = NO;
    self.alertBackgroundView.bounces = NO;
    self.alertBackgroundView.showsHorizontalScrollIndicator = NO;
    self.alertBackgroundView.scrollsToTop = NO;
    self.alertBackgroundView.contentSize = CGSizeMake(self.totalWidth, self.frame.size.height);
    
//    self.alertBackgroundView.userInteractionEnabled = YES;
//    self.painRecognize1 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pain1Action:)];
//    self.painRecognize1.maximumNumberOfTouches = 1;
//    [self.alertBackgroundView addGestureRecognizer:self.painRecognize1];
    
    self.selectIndex = 0;
    for (NSInteger index = 0; index < self.titleArr.count; index++)
    {
        NSString *titleStr = [self.titleArr objectAtSafeIndex:index];
        NSLog(@"titleStr=%@", titleStr);
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        titleBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        titleBtn.backgroundColor = [UIColor clearColor];
        [titleBtn setTitle:titleStr forState:UIControlStateNormal];
        titleBtn.tag = index;
        [self.alertBackgroundView addSubview:titleBtn];
        [self.titleBtnsArr addSafeObject:titleBtn];
        [titleBtn addTarget:self action:@selector(hitAction:) forControlEvents:UIControlEventTouchUpInside];
        
        //分隔横线
        UIView *underlineView = [UIView new];
        underlineView.backgroundColor = self.underlineColor;
        [self.alertBackgroundView addSubview:underlineView];
        [self.underlineViewsArr addSafeObject:underlineView];
        if(0 == index)
        {
            [titleBtn setTitleColor:self.selectTextColor forState:UIControlStateNormal];
            underlineView.hidden = NO;
        }
        else
        {
            [titleBtn setTitleColor:self.textColor forState:UIControlStateNormal];
            underlineView.hidden = YES;
        }
    }
    
//    //分隔横线
//    self.lineView = [UIView new];
//    self.lineView.backgroundColor = BACKGROUND_COLOR;
//    [self.alertBackgroundView addSubview:self.lineView];
    
    [self unitsSdLayout];
}

- (void)hitAction:(UIButton *)sender {
    if(self.isSendindRequest)
    {
        return;
    }
    NSUInteger index = sender.tag;
    if(index == self.selectIndex)
    {
        return;
    }
    [self updateBtnWithIndex:index];
    if (self.hitCallback) {
        self.hitCallback(sender.tag);
    }
}

-(void)updateBtnWithIndex:(NSUInteger)index
{
    self.selectIndex = index;
    for(NSInteger i = 0; i < self.titleBtnsArr.count; i++)
    {
        UIButton *titleBtn = [self.titleBtnsArr objectAtSafeIndex:i];
        UIView *underlineView = [self.underlineViewsArr objectAtSafeIndex:i];
        if(i != index)
        {
            [titleBtn setTitleColor:self.textColor forState:UIControlStateNormal];
            underlineView.hidden = YES;
        }
        else
        {
            [titleBtn setTitleColor:self.selectTextColor forState:UIControlStateNormal];
            underlineView.hidden = NO;
        }
    }
    

}

-(void)unitsSdLayout
{
    
    
}

@end
