//
//  BITNavigationController.m
//  Pods
//
//  Created        on 18/9/30.
//
//

#import "BITNavigationController.h"
#import "BITRouter.h"
#import <objc/runtime.h>

CGFloat const BITAnimationDuration = 0.55f;
static BITNavigationController *navigationController;
#pragma mark - animation objects

@interface BITNavigationControllerPushVerticalAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation BITNavigationControllerPushVerticalAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return BITAnimationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    toVC.view.transform = CGAffineTransformMakeTranslation(0, toVC.view.bounds.size.height);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
        toVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

@interface BITNavigationControllerPushFadeAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation BITNavigationControllerPushFadeAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return BITAnimationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    toVC.view.alpha = 0;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         toVC.view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end

@interface BITNavigationControllerPopVerticalAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation BITNavigationControllerPopVerticalAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return BITAnimationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    [[transitionContext containerView] addSubview:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:0 animations:^{
        fromVC.view.transform = CGAffineTransformMakeTranslation(0, fromVC.view.bounds.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end

@interface BITNavigationControllerPopFadeAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@end

@implementation BITNavigationControllerPopFadeAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return BITAnimationDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    [[transitionContext containerView] addSubview:toVC.view];
    [[transitionContext containerView] addSubview:fromVC.view];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                     animations:^{
                         fromVC.view.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}

@end


@interface BITNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, assign) BOOL shouldIgnorePush;

@end

@implementation BITNavigationController

+ (BITNavigationController *)currentNavigationController
{
    return navigationController;
}

- (void)setup
{
    self.delegate = self;
//    self.navigationBar.hidden = YES;
//    // 必须要加这一句，不然导航不知道 navigationBar 被隐藏了，然后会影响样式
//    self.navigationBarHidden = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    self.disablePushAnimation = NO;
    if (!navigationController) {
        navigationController = self;
    }
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass
{
    self = [super initWithNavigationBarClass:navigationBarClass toolbarClass:toolbarClass];
    if (self) {
        [self setup];
    }
    return self;
}

- (UIViewController *)rootViewController
{
    return self.viewControllers.firstObject;
}


- (void)setShouldIgnorePush:(BOOL)shouldIgnorePush
{
    _shouldIgnorePush = shouldIgnorePush;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending) {
        _shouldIgnorePush = NO;
    }
}
#pragma mark - push view controller

- (void)pushViewController:(UIViewController *)viewController
{
    [self pushViewController:viewController withAnimation:viewController.animation];
}

- (void)pushViewController:(UIViewController *)viewController completed:(void (^)(void))completed
{
    [self pushViewController:viewController withAnimation:viewController.animation completed:completed];
}

- (void)pushViewController:(UIViewController *)viewController withAnimation:(PageTransitionAnimation)animation
{
    [self pushViewController:viewController withAnimation:animation completed:nil];
}

- (void)pushViewController:(UIViewController *)viewController withAnimation:(PageTransitionAnimation)animation completed:(void (^)(void))completed
{
    viewController.animation = animation;
    viewController.completionBlock = completed;
    
    switch (animation) {
        case AnimationSlideHorizontal:
        case AnimationSlideVertical:
        case AnimationFade:
            [self pushViewController:viewController animated: self.disablePushAnimation ? NO : YES];
            break;
        case None:
        default:
            [self pushViewController:viewController animated:NO];
            break;
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //iOS 7 连续 Push 多个 VC 会 Crash
    if (self.shouldIgnorePush) {
        return;
    }
    //    // 处理全屏的手势滑动
    //    // 用到了私有接口，不过应该没什么问题
    //    NSMutableArray *targets = [self.interactivePopGestureRecognizer valueForKeyPath:@"_targets"];
    //    id targetContainer = targets[0];
    //    id target = [targetContainer valueForKeyPath:@"_target"];
    //    if ([target respondsToSelector:NSSelectorFromString(@"handleNavigationTransition:")]) {
    ////        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:NSSelectorFromString(@"handleNavigationTransition:")];
    ////        panGesture.delegate = self;
    ////        [self.interactivePopGestureRecognizer.view addGestureRecognizer:panGesture];
    //    }
    [self.view endEditing:YES];//强制收键盘
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (animated) {
        self.shouldIgnorePush = YES;
    }
    [super pushViewController:viewController animated:animated];
}


#pragma mark - pop view controller

- (UIViewController *)popViewController
{
    return [self popViewControllerWithAnimation:YES];
}

- (UIViewController *)popViewControllerWithAnimation:(PageTransitionAnimation)animation
{
    return [self popViewControllerWithAnimation:animation completed:nil];
}

- (UIViewController *)popViewControllerWithAnimation:(PageTransitionAnimation)animation completed:(void (^)(void))completed
{
    if (self.viewControllers.count >= 2) {
        
        UIViewController *toViewController = self.viewControllers[self.viewControllers.count - 2];
        UIViewController *fromViewController = self.viewControllers.lastObject;
        
        fromViewController.animation = animation;
        toViewController.completionBlock = completed;
        
        switch (animation) {
            case AnimationSlideHorizontal:
            case AnimationSlideVertical:
            case AnimationFade:
                return [self popViewControllerAnimated:YES];
                break;
            case None:
            default:
                return [self popViewControllerAnimated:NO];
                break;
        }
        
    }
    else {
        if (completed) {
            completed();
        }
        return self.viewControllers.lastObject;
    }
}

- (void)removeViewController:(UIViewController *)viewController
{
    NSMutableArray *viewControllers = [self.viewControllers mutableCopy];
    [viewControllers removeObject:viewController];
    [self setViewControllers:viewControllers animated:NO];
}

- (void)removeViewControllers:(NSArray *)viewControllers
{
    NSMutableArray *newViewControllers = [self.viewControllers mutableCopy];
    [newViewControllers removeObjectsInArray:viewControllers];
    [self setViewControllers:newViewControllers animated:NO];
}


- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated completed:(void (^)(void))completed
{
    viewController.completionBlock = completed;
    return [self popToViewController:viewController animated:animated];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated completed:(void (^)(void))completed
{
    self.rootViewController.completionBlock = completed;
    return [self popToRootViewControllerAnimated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    if (self.shouldIgnorePush) {
        return nil;
    }
    
    if (animated) {
        self.shouldIgnorePush = YES;
    }
    
    return [super popViewControllerAnimated:animated];
}


- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.shouldIgnorePush) {
        return nil;
    }
    
    if (animated) {
        self.shouldIgnorePush = YES;
    }
    
    return [super popToViewController:viewController animated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated
{
    if (self.shouldIgnorePush) {
        return nil;
    }
    
    if (animated) {
        self.shouldIgnorePush = YES;
    }
    return [super popToRootViewControllerAnimated:animated];
}


- (BOOL)canBecomeFirstResponder
{
    return self.enableDebug;
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
#if DEBUG
    if (motion == UIEventTypeMotion && self.enableDebug) {
        [BITRouter openURL:@"yx://debug"];
    }
#endif
}


#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush) {
        if (toVC.animation == AnimationSlideVertical) {
            return [BITNavigationControllerPushVerticalAnimation new];
        }
        else if (toVC.animation == AnimationFade) {
            return [BITNavigationControllerPushFadeAnimation new];
        }
    }
    else if (operation == UINavigationControllerOperationPop) {
        if (fromVC.animation == AnimationSlideVertical) {
            return [BITNavigationControllerPopVerticalAnimation new];
        }
        else if (fromVC.animation == AnimationFade) {
            return [BITNavigationControllerPopFadeAnimation new];
        }
    }
    
    return nil;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.shouldIgnorePush = NO;
    
    if (viewController.completionBlock) {
        viewController.completionBlock();
        viewController.completionBlock = nil;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    /// 手势右滑返回操作中途取消弹回，则置回shouldIgnorePush
    
    id<UIViewControllerTransitionCoordinator> tc = navigationController.topViewController.transitionCoordinator;
    __weak __typeof(self)weakSelf = self;
    [tc notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        self.shouldIgnorePush = ![context isCancelled];
    }];
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (self.shouldIgnorePush) {
        return NO;
    }
    
    //    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
    //        //        return NO;
    //    }
    
    // 如果只有一个 VC，就不要启用滑动手势了
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    
    if (self.topViewController.disablePanGesture || !(self.topViewController.animation == AnimationSlideHorizontal || self.topViewController.animation == None)) {
        return NO;
    }
    
    // 如果处在滑动过程中就不要 begin 了
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    //    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
    //        CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    //        if (translation.x <= 0) {
    //            return NO;
    //        }
    //    }
    
    return YES;
}

- (void)handleNavigationTransition:(UITapGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        self.shouldIgnorePush = NO;
    }
    
    NSMutableArray *targets = [self.interactivePopGestureRecognizer valueForKeyPath:@"_targets"];
    id targetContainer = targets[0];
    id target = [targetContainer valueForKeyPath:@"_target"];
    if ([target respondsToSelector:NSSelectorFromString(@"handleNavigationTransition:")]) {
        [target handleNavigationTransition:recognizer];
    }
}

@end

@implementation UIViewController (BITNavigation)

- (PageTransitionAnimation)animation
{
    NSNumber *value = objc_getAssociatedObject(self, "animation");
    if (value) {
        return [value integerValue];
    }
    else {
        return AnimationSlideHorizontal;
    }
}

- (void)setAnimation:(PageTransitionAnimation)animation
{
    objc_setAssociatedObject(self, "animation", [NSNumber numberWithInteger:animation], OBJC_ASSOCIATION_RETAIN);
}

- (void (^)())completionBlock
{
    return objc_getAssociatedObject(self, "completion");
}

- (void)setCompletionBlock:(void (^)())completionBlock
{
    objc_setAssociatedObject(self, "completion", completionBlock, OBJC_ASSOCIATION_COPY);
}

- (BITNavigationController *)BITNavigationController
{
    return (BITNavigationController *)self.navigationController;
}

- (BOOL)disablePanGesture
{
    NSNumber *value = objc_getAssociatedObject(self, "disablePanGesture");
    if (value) {
        return [value boolValue];
    }
    else {
        return NO;
    }
}

- (void)setDisablePanGesture:(BOOL)disablePanGesture
{
    objc_setAssociatedObject(self, "disablePanGesture", [NSNumber numberWithBool:disablePanGesture], OBJC_ASSOCIATION_RETAIN);
}



@end
