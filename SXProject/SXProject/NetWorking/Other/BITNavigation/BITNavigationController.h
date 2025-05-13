//
//  BITNavigationController.h
//  Pods
//
//  Created        on 18/9/30.
//
//

#import <UIKit/UIKit.h>

/**
 *  NavigationController 支持的动画类型
 */
typedef NS_ENUM(NSUInteger, PageTransitionAnimation) {
    /**
     *  水平动画
     */
    AnimationSlideHorizontal = 0,
    /**
     *  垂直动画
     */
    AnimationSlideVertical,
    /**
     *  淡入淡出
     */
    AnimationFade,
    /**
     *  无
     */
    None,
};


@interface BITNavigationController : UINavigationController

/**
 *  根 ViewController
 */
@property (nonatomic, readonly) UIViewController *rootViewController;

/**
 *  是否开启调试模式，如果是的话，内网环境下摇一摇，就能摇出调试菜单
 */
@property (nonatomic, assign) BOOL enableDebug;

/**
 *  关闭所有 Push 动画
 */
@property (nonatomic, assign) BOOL disablePushAnimation;


/**
 *  当前使用的 navigationcontroller
 *
 *  @return
 */
+ (BITNavigationController *)currentNavigationController;

/**
 *  push 到新的 ViewController
 *
 *  @param viewController 需要 push 的 ViewController
 */
- (void)pushViewController:(UIViewController *)viewController;

/**
 *  push 到新的 ViewController
 *
 *  @param viewController 需要 push 的 ViewController
 *  @param animation      动画类型
 */
- (void)pushViewController:(UIViewController *)viewController withAnimation:(PageTransitionAnimation)animation;

/**
 *  push 到新的 ViewController
 *
 *  @param viewController 需要 push 的 ViewController
 *  @param completed      动画完成后执行的 block
 */
- (void)pushViewController:(UIViewController *)viewController completed:(void (^)(void))completed;


/**
 *  push 到新的 ViewController
 *
 *  @param viewController 需要 push 的 ViewController
 *  @param animation      动画类型
 *  @param completed      动画完成后执行的 block
 */
- (void)pushViewController:(UIViewController *)viewController withAnimation:(PageTransitionAnimation)animation completed:(void (^)(void))completed;

/**
 *  弹出当前最上层的 viewcontroller，默认无动画
 *
 *  @return
 */
- (UIViewController *)popViewController;

/**
 *  弹出当前最上层的 viewcontroller
 *
 *  @param animation 动画类型
 *
 *  @return
 */
- (UIViewController *)popViewControllerWithAnimation:(PageTransitionAnimation)animation;

/**
 *  弹出当前最上层的 viewcontroller
 *
 *  @param animation 动画类型
 *  @param completed 动画完成后执行的操作
 *
 *  @return
 */
- (UIViewController *)popViewControllerWithAnimation:(PageTransitionAnimation)animation completed:(void (^)(void))completed;

/**
 *  移除指定的 viewcontroller
 *
 *  @param viewController 要移除的 viewcontroller
 */
- (void)removeViewController:(UIViewController *)viewController;

/**
 *  移除指定的 viewcontrollers
 *
 *  @param viewcontrollers 要移除的 viewcontroller 数组
 */
- (void)removeViewControllers:(NSArray *)viewControllers;

/**
 *  弹出到指定的 viewcontroller
 *
 *  @param viewController viewController
 *  @param animated       是否需要动画
 *  @param completed      动画完成后执行
 */
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completed:(void (^)(void))completed;


/**
 *  弹出到根 viewcontroller
 *
 *  @param animated  是否需要动画
 *  @param completed 动画完成后执行
 */
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated completed:(void (^)(void))completed;

@end

@interface UIViewController (BITNavigation)
/**
 *  当前 ViewController 在 BITNavigationController 中的动画。
 */
@property (nonatomic, assign) PageTransitionAnimation animation;
@property (nonatomic, copy) void(^completionBlock)();
@property (nonatomic, readonly) BITNavigationController *yxNavigationController;
/**
 *  禁用横滑返回功能
 */
@property (nonatomic, assign) BOOL disablePanGesture;


@end


