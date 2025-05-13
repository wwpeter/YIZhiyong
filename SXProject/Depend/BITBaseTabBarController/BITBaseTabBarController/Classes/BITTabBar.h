//
//  BITTabBar.h
//  Pods
//
//  Created        huihui on 2017/11/16.
//
//

#import <Foundation/Foundation.h>
#import "BITTabBarItem.h"

@protocol BITTabBarDelegate;

@interface BITTabBar : UIView <BITTabBarDelegate>

/**
 *  tabbardelegate
 */
@property (nonatomic, weak) id<BITTabBarDelegate> delegate;

/**
 *  当前选中 item 的索引
 */
@property (nonatomic, assign, readonly) NSUInteger selectedIndex;

/**
 *  是否开启毛玻璃背景；
 *  注意即便开启 iOS8以下也无效;
 *  即便开启，如果调用MGJTabBar的setBackgroundImage方法（无关先后顺序），当image不为nil 此属性失效；反过来属性有效
 */
@property (nonatomic, assign) BOOL blurNeedOpen;

/**
 *  创建 tabbar
 *
 *  @param frame    frame
 *  @param items    items 数组
 *  @param delegate delegate
 *  @param selectedIndex 设置默认选中的tab为哪个
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<BITTabBarDelegate>)delegate selectedIndex:(NSUInteger)selectedIndex;

/**
 *  创建 tabbar
 *
 *  @param frame    frame
 *  @param items    items 数组
 *  @param delegate delegate
 *
 *  @return
 */
- (id)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<BITTabBarDelegate>)delegate;

/**
 *  设置背景
 *
 *  @param backgroundImage 背景图
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage;


/**
 *  选中某个 item
 *
 *  @param index 索引
 */
- (void)selectItemAtIndex:(NSInteger)index;

/**
 *  设置指定 item 的 badge
 *
 *  @param badge badge 数字
 *  @param index item 索引
 */
- (void)setBadge:(NSInteger)badge atIndex:(NSInteger)index;

@end

/**
 *  BITTabBarDelegate
 */
@protocol BITTabBarDelegate <NSObject>
@optional

/**
 *  选中了某个 item
 *
 *  @param tabBar tabbar
 *  @param index  索引
 */
- (void)tabBar:(BITTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index;

/**
 *  是否能选中某个 item
 *
 *  @param tabBar tabbar
 *  @param index  索引
 *
 *  @return
 */
- (BOOL)tabBar:(BITTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index;
@end
