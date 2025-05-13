//
//  BITNavigationBar.h
//  ChildishBeautyParent
//
//  Created        on 2017/2/27.
//  Copyright © 2017年 BitInfo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BITNavigationBar : UIView


/**
 *  标题文字
 */
@property(nonatomic, copy) NSString *title;

/**
 *  titleview
 */
@property(nonatomic, strong) UIView *titleView;

/**
 *  标题的 label
 */
@property(nonatomic, readonly) UILabel *titleLabel;

/**
 *  左侧按钮
 */
@property(nonatomic, strong) UIView *leftBarButton;

/**
 *  右侧按钮
 */
@property(nonatomic, strong) UIView *rightBarButton;

/**
 *  放置内容的 view，不包含状态栏
 */
@property(nonatomic, readonly) UIView *containerView;

/**
 *  title 颜色
 */
@property(nonatomic, strong) UIColor *titleColor UI_APPEARANCE_SELECTOR;

/**
 *  创建 navigation bar
 *
 *  @param frame          frame
 *  @param needBlurEffect 是否需要模糊效果 (iOS 8 以上支持)
 *
 *  @return id
 */
- (id)initWithFrame:(CGRect)frame needBlurEffect:(BOOL)needBlurEffect;

/**
 *  导航栏背景颜色
 */
- (UIColor *)backgroundColor;

/**
 *  导航栏背景图
 */
@property(nonatomic, strong) UIImage *backgroundImage UI_APPEARANCE_SELECTOR;

/**
 *  暴露出来设置alpha
 */
@property(nonatomic, strong) UIImageView *backgroundView;
/**
 *  导航栏阴影
 */
@property (nonatomic, assign) BOOL needNaviShadow;



@end
