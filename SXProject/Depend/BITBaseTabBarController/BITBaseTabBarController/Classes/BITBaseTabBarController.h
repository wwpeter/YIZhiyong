//
//  BITBaseTabBarController.h
//  Pods
//
//  Created        huihui on 2017/11/16.
//
//

#import <UIKit/UIKit.h>
#import "BITTabBarItem.h"
#import "BITTabBar.h"

@class BITBaseTabBarController;

@protocol BITViewControllerProtocol <NSObject>

@property (nonatomic, assign) CGRect defaultFrame;
@property (nonatomic, strong) BITTabBarItem *bitTabBarItem;
@property (nonatomic, weak)   BITBaseTabBarController *bitBaseTabBarController;

@end

extern CGFloat const UXTabbarHeight;

@protocol BITBaseTabBarControllerDelegate;

@interface BITBaseTabBarController : UIViewController<BITBaseTabBarControllerDelegate, BITTabBarDelegate>

@property (nonatomic, assign) CGRect defaultFrame;
@property (nonatomic, strong) BITTabBarItem *bitTabBarItem;
@property (nonatomic, weak) BITBaseTabBarController *BITBaseTabBarController;

/**
 *  文字颜色
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 *  被选中时的文字颜色
 */
@property (nonatomic, strong) UIColor *selectedTitleColor;

/**
 *  tabbar
 */
@property(nonatomic, strong, readonly) BITTabBar *uxTabBar;

/**
 *  tabbarcontroller 中的 viewcontroller
 */
@property(nonatomic, strong, readonly) NSArray *viewControllers;

/**
 *  当前选中的 viewcontroller
 */
@property(nonatomic, strong, readonly) UIViewController<BITViewControllerProtocol> *selectedViewController;

/**
 *  当前选中的 index
 */
@property(nonatomic, assign, readonly) NSInteger selectIndex;

/**
 *  delegate
 */
@property(nonatomic, weak) id<BITBaseTabBarControllerDelegate> bitBaseTabBarControllerDelegate;

/**
 *  初始化 tabbarcontroller
 *
 *  @param viewControllers tabbarcontroller 中的 viewcontroller
 *
 *  @return
 */
- (id)initWithViewControllers:(NSArray *)viewControllers;

/**
 *  初始化 tabbarcontroller
 *
 *  @param viewControllers tabbarcontroller 中的 viewcontroller
 *  @param selectedIndex 默认tabbar的选中index为哪个
 *
 *  @return
 */
- (id)initWithViewControllers:(NSArray *)viewControllers selectedIndex:(NSInteger)selectedIndex;


/**
 *  选中某个 tab
 *
 *  @param index 索引
 */
- (void)selectAtIndex:(NSInteger)index;

@end



/**
 *  BITBaseTabBarControllerDelegate
 */
@protocol BITBaseTabBarControllerDelegate <NSObject>
@optional
/**
 *  是否能选中制定的 viewcontroller
 *
 *  @param tabBarController tabbarcontroller
 *  @param viewController   将要选中的 viewcontroller
 *  @param index            将要选中的 viewcontroller 在 tabbar 中的索引
 *
 *  @return
 */
- (BOOL)tabBarController:(BITBaseTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController atIndex:(NSInteger)index;

/**
 *  选中 tabbarcontroller 中某个 viewcontroller 时调用
 *
 *  @param tabBarController tabbarcontroller
 *  @param viewController   选中的 viewcontroller
 *  @param index            选中的 viewcontroller 在 tabbar 中的索引
 */
- (void)tabBarController:(BITBaseTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController atIndex:(NSInteger)index;

@end



/**
 *  BITBaseTabBarControllerProtocal 协议
 */
@protocol BITBaseTabBarControllerProtocal <NSObject>

@optional
/**
 *  当 viewcontroller 被选中时调用，必须是切换的情况下
 */
- (void)didSelectedInTabBarController;

/**
 *  是否能选中
 *
 *  @return
 */
- (BOOL)shoudSelectedInTabBarController;

/**
 *  点击时，当前 viewcontroller 已经是选中的情况下调用
 */
- (void)didSelectedInTabBarControllerWhenAppeared;
@end
