//
//  BITNavigationBar.m
//  ChildishBeautyParent
//
//  Created        on 2017/2/27.
//  Copyright © 2017年 BitInfo. All rights reserved.
//

#import "BITNavigationBar.h"

#define BITNAVIGATIONBAR_TAG   52535

@interface BITNavigationBar ()

@property(nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIImageView *shadowView;

@end

@implementation BITNavigationBar

- (UIImageView *)shadowView
{
    if (!_shadowView) {
        UIImage *image = [UIImage imageNamed:@"navbar_shadow"];
        _shadowView = [[UIImageView alloc] initWithImage:image];
        _shadowView.clipsToBounds = NO;
        _shadowView.tag = 88888;
        _shadowView.frame = CGRectMake(0, CGRectGetMaxY(_containerView.frame), [[UIScreen mainScreen] bounds].size.width, image.size.height);
    }
    return _shadowView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame needBlurEffect:YES];
}

- (id)initWithFrame:(CGRect)frame needBlurEffect:(BOOL)needBlurEffect
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds = NO;
        
        self.backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.backgroundView.contentMode = UIViewContentModeTop;
        self.backgroundView.clipsToBounds = YES;
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height, frame.size.width, frame.size.height - [[UIApplication sharedApplication] statusBarFrame].size.height )];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 && needBlurEffect) {
            UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
            UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
            effectView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
            [self addSubview:effectView];
            [effectView.contentView addSubview:self.backgroundView];
            [effectView.contentView addSubview:self.containerView];
        }
        else
        {
            [self addSubview:self.backgroundView];
            [self addSubview:self.containerView];
        }
    }
    return self;
}


#pragma mark - 导航栏阴影

- (void)setNeedNaviShadow:(BOOL)needNaviShadow
{
    if (needNaviShadow) {
        BOOL hasAddShadow = NO;
        for (UIView *subView in self.subviews) {
            if (subView.tag == 88888) {
                hasAddShadow = YES;
                break;
            }
        }
        if (!hasAddShadow) {
            [self addSubview:self.shadowView];
        }
    } else {
        [self.shadowView removeFromSuperview];
    }
}


- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    self.backgroundView.backgroundColor = backgroundColor;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    if (nil == _titleView) {
        _titleView = [[UIView alloc] initWithFrame:CGRectMake((self.containerView.frame.size.width - 200)/2, 0, 200, self.containerView.frame.size.height)];
    }else {
        while (_titleView.subviews.count) {
            [_titleView.subviews.lastObject removeFromSuperview];
        }
    }
    _titleView.frame = CGRectMake((self.containerView.frame.size.width - 200)/2, 0, 200, self.containerView.frame.size.height);
    _titleView.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, _titleView.frame.size.height - 10)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = self.titleColor ? : [UIColor whiteColor];
    titleLabel.text = _title;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.minimumScaleFactor = 14 / 18.f;
    titleLabel.tag = BITNAVIGATIONBAR_TAG;
    [_titleView addSubview:titleLabel];
    
    [_titleView removeFromSuperview];
    [self.containerView addSubview:_titleView];
}

- (void)setTitleColor:(UIColor*)color
{
    _titleColor = color;
    UILabel *titleLabel = (UILabel*)[_titleView viewWithTag:BITNAVIGATIONBAR_TAG];
    titleLabel.textColor = color;
}

- (void)setTitleView:(UIView *)titleView
{
    [_titleView removeFromSuperview];
    _titleView = nil;
    if (titleView) {
        _titleView = titleView;
        _titleView.center = CGPointMake(self.containerView.frame.size.width / 2, self.containerView.frame.size.height / 2) ;
        [self.containerView addSubview:_titleView];
    }
}

- (UILabel *)titleLabel
{
    UILabel *titleLabel = (UILabel*)[_titleView viewWithTag:BITNAVIGATIONBAR_TAG];
    return titleLabel;
}

- (void)setLeftBarButton:(UIView *)leftBarButton
{
    [_leftBarButton removeFromSuperview];
    _leftBarButton = nil;
    if (leftBarButton) {
        _leftBarButton = leftBarButton;
        _leftBarButton.center = CGPointMake(_leftBarButton.frame.size.width/2, self.containerView.frame.size.height/2);
        [self.containerView addSubview:_leftBarButton];
    }
}

- (void)setRightBarButton:(UIView *)rightBarButton
{
    [_rightBarButton removeFromSuperview];
    _rightBarButton = nil;
    if (rightBarButton) {
        _rightBarButton = rightBarButton;
        _rightBarButton.center = CGPointMake(self.containerView.frame.size.width - (_rightBarButton.frame.size.width/2) - 20.f, self.containerView.frame.size.height/2);
//        _rightBarButton.backgroundColor = [UIColor blueColor];
        [self.containerView addSubview:_rightBarButton];
        [self.containerView bringSubviewToFront:_rightBarButton];
    }
}

- (UIColor *)backgroundColor
{
    return self.backgroundView.backgroundColor;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    self.backgroundView.image = backgroundImage;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.backgroundView.frame = self.bounds;
    CGRect originRect = self.containerView.frame;
    originRect.origin.y = [[UIApplication sharedApplication] statusBarFrame].size.height;
    self.containerView.frame = originRect;
}


@end
