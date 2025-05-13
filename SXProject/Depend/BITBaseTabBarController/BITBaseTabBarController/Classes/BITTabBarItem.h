//
//  BITTabBarItem.h
//  Pods
//
//  Created        huihui on 2017/11/16.
//
//

#import <Foundation/Foundation.h>
//#import "UXBadgeView.h"
#import <UIKit/UIKit.h>

@protocol BITTabBarItemDelegate;

@interface BITTabBarItem : UIControl


@property(nonatomic, weak) id<BITTabBarItemDelegate> delegate;
//@property(nonatomic, strong) UXBadgeView *badgeView;
@property(nonatomic, assign) UIEdgeInsets imageInset;
@property (nonatomic, strong) UILabel        *label;
/**
 *  初始化 tabbaritem
 *
 *  @param title              标题
 *  @param titleColor         标题颜色
 *  @param selectedTitleColor 选中的标题颜色
 *  @param icon               icon
 *  @param selectedIcon       选中的icon
 *
 *  @return
 */
- (id)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor selectedTitleColor:(UIColor *)selectedTitleColor icon:(UIImage *)icon selectedIcon:(UIImage *)selectedIcon;

/**
 *  设置 icon，默认 isExtended 为 NO
 *
 *  @param image icon 图片
 */
- (void)setIcon:(UIImage *)image;

/**
 *  根据 isExtended 设置 icon 图片以及是否有扩展效果
 *
 *  @param image        icon 图片
 *  @param extendedIcon 是否有扩展效果
 */
- (void)setIcon:(UIImage *)image enableExtend:(BOOL)isExtended;

/**
 *  设置 selectIcon，默认 isExtended 为 NO
 *
 *  @param selectedIcon 选中的 icon 图片
 */
- (void)setSelectedIcon:(UIImage *)selectedIcon;
/**
 *  根据 isExtended 设置 selectIcon 图片以及是否有扩展效果
 *
 *  @param selectedIcon 选中的 icon 图片
 *  @param extendedIcon 是否有扩展效果
 */
- (void)setSelectedIcon:(UIImage *)selectedIcon enableExtend:(BOOL)isExtended;
/**
 *  设置title
 *
 *  @param title 标题
 */
-(void)setTitle:(NSString*)title;

/**
 *  获取 title
 *
 *  @return
 */
- (NSString *)title;
@property (nonatomic, strong) UIImageView    *imageView;

/**
 *  设置 selectedTextColor
 *
 *  @param 选中字的颜色
 */
-(void)setSelectedTextColor:(UIColor *) selectedTitleColor;

/**
 * 设置 title 颜色
 **/
- (void)setTextColor:(UIColor*)textColor;

/**
 * 重新设置 tabbarItem
 **/
- (void)resetItemWithTitle:(NSString*)title
                     color:(UIColor*)color
             selectedColor:(UIColor*)selectedColor
                      icon:(UIImage*)icon
              selectedIcon:(UIImage*)selectedIcon;
@end

/**
 *  BITTabBarItemDelegate
 */
@protocol BITTabBarItemDelegate <NSObject>

@optional

/**
 *  item 被选中时调用
 *
 *  @param item 当前item
 */
- (void)tabBarItemdidSelected:(BITTabBarItem *)item;

@end
