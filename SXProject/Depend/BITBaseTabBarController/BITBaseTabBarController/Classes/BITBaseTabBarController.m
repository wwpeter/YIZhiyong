//
//  BITBaseTabBarController.m
//  Pods
//
//  Created        huihui on 2017/11/16.
//
//

#import "BITBaseTabBarController.h"
#import "UIView+BitInfo.h"

#define iPhoneEar \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define UXTabbarHeight (([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) ? ([[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom + 49) : 49)

//(iPhoneEar ? 83 : 49)

@interface BITBaseTabBarController ()

@property(nonatomic, strong) BITTabBar *uxTabBar;
@property(nonatomic, strong) NSArray *viewControllers;
@property(nonatomic, strong) UIViewController<BITViewControllerProtocol> *selectedViewController;
@property(nonatomic, assign) NSInteger selectIndex;

@end

@implementation BITBaseTabBarController


- (id)initWithViewControllers:(NSArray *)viewControllers
{
    self = [self initWithViewControllers:viewControllers selectedIndex:0];
    if (self) {
        //write initial method
    }
    return self;
}

- (id)initWithViewControllers:(NSArray *)viewControllers selectedIndex:(NSInteger)selectedIndex
{
    self = [super init];
    if (self) {
        
        self.selectIndex = selectedIndex;
        self.viewControllers = viewControllers;
        self.automaticallyAdjustsScrollViewInsets = NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarFrameDidChanged) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *itemsArray = [NSMutableArray array];
    for (UIViewController<BITViewControllerProtocol> *viewController in self.viewControllers) {
        viewController.defaultFrame = CGRectMake(0, 0, self.view.width, self.view.height - UXTabbarHeight);
        
        BITTabBarItem *tabBarItem = viewController.bitTabBarItem;
        if (!tabBarItem) {
            tabBarItem = [[BITTabBarItem alloc] initWithTitle:viewController.title titleColor:self.titleColor selectedTitleColor:self.selectedTitleColor icon:nil selectedIcon:nil];
            viewController.bitTabBarItem = tabBarItem;
        }
        [itemsArray addObject:tabBarItem];
        [self addChildViewController:viewController];
        viewController.bitBaseTabBarController = self;
    }
    
    self.selectedViewController = self.viewControllers[self.selectIndex];
    [self.view addSubview:[self.viewControllers[self.selectIndex] view]];
    
    self.uxTabBar = [[BITTabBar alloc] initWithFrame:CGRectMake(0, self.view.height - UXTabbarHeight, self.view.width, UXTabbarHeight) items:itemsArray delegate:self selectedIndex:self.selectIndex];
    self.uxTabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    self.uxTabBar.layer.shadowOpacity = 0.07f;
    self.uxTabBar.layer.shadowOffset = CGSizeMake(0,0);
    self.uxTabBar.layer.shadowRadius = 3.f;
    [self.view addSubview:self.uxTabBar];
    
}

- (void)selectAtIndex:(NSInteger)index {
    if (index > self.viewControllers.count - 1) {
        return;
    }
    [self.uxTabBar selectItemAtIndex:index];
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.selectedViewController;
}

#pragma mark - BITTabBarDelegate

- (BOOL)tabBar:(BITTabBar *)tabBar shouldSelectItemAtIndex:(NSUInteger)index
{
    BOOL shouldSelect = YES;
    if ([self.bitBaseTabBarControllerDelegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:atIndex:)]) {
        shouldSelect = [self.bitBaseTabBarControllerDelegate tabBarController:self shouldSelectViewController:self.viewControllers[index] atIndex:index];
    }
    
    return shouldSelect;
}

- (void)tabBar:(BITTabBar *)tabBar didSelectItemAtIndex:(NSUInteger)index
{
    if (self.selectIndex == index) {
        self.selectedViewController.view.frame = CGRectMake(0, 0, self.view.width, self.view.height - UXTabbarHeight);
        if ([self.selectedViewController respondsToSelector:@selector(didSelectedInTabBarControllerWhenAppeared)])
        {
            [self.selectedViewController performSelector:@selector(didSelectedInTabBarControllerWhenAppeared) withObject:nil];
        }
    }
    else
    {
        [self.selectedViewController.view removeFromSuperview];
        
        self.selectIndex = index;
        self.selectedViewController = self.viewControllers[self.selectIndex];
        
        [self.view insertSubview:self.selectedViewController.view belowSubview:self.uxTabBar];
        
        if ([self.bitBaseTabBarControllerDelegate respondsToSelector:@selector(tabBarController:didSelectViewController:atIndex:)]) {
            [self.bitBaseTabBarControllerDelegate tabBarController:self didSelectViewController:self.selectedViewController atIndex:self.selectIndex];
        }
        
        if ([self.selectedViewController respondsToSelector:@selector(didSelectedInTabBarController)])
        {
            [self.selectedViewController performSelector:@selector(didSelectedInTabBarController) withObject:nil];
        }
        [self.selectedViewController setNeedsStatusBarAppearanceUpdate];
    }
}

- (void)statusBarFrameDidChanged
{
    self.uxTabBar.bottom = self.view.height - ([self.view convertPoint:CGPointMake(0, self.view.height) toView:nil].y - [UIApplication sharedApplication].keyWindow.size.height);
    
}

@end
