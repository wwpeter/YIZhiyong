//
//  BITLoadingView.m
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

#import "BITLoadingView.h"
#define isIpad ([[UIScreen mainScreen] bounds].size.width >= 768 && [[UIScreen mainScreen] bounds].size.height >= 768)

static BITLoadingView *loadingView = nil;

@interface BITLoadingView ()

@property (nonatomic, strong) UIView *floatingView;//蒙层

@property (nonatomic, strong) UIView *bottomView;//底层view

@property (nonatomic, strong) UIImageView *rotationView;//旋转view

@property (nonatomic, strong) UIWindow *iWindow;//Window
@property (nonatomic, assign) BOOL showClearHUDFlag;
@property (nonatomic, assign) BOOL responseDisplayFlag;
@end

@implementation BITLoadingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.floatingView];
        [self addSubview:self.bottomView];
        [self.bottomView addSubview:self.rotationView];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(becomeActive)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
    }
    return self;
}

- (UIWindow *)iWindow
{
    if (!_iWindow) {
        if(isIpad)
        {
            if([[UIScreen mainScreen] bounds].size.width <= [[UIScreen mainScreen] bounds].size.height)
            {
                _iWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//                _statusWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, ((sCommonUnitFullHeight() - 64)/2), sCommonUnitFullWidth(), NoticeHeight)];
            }
            else
            {
                _iWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width)];
//                _statusWindow = [[UIWindow alloc] initWithFrame:CGRectMake((sCommonUnitFullHeight() -sCommonUnitFullWidth())/2, (sCommonUnitFullWidth() - sCommonUnitFullHeight())/2+((sCommonUnitFullHeight() - 64)/2), sCommonUnitFullWidth(), NoticeHeight)];
//                _statusWindow.transform = CGAffineTransformRotate (self.statusWindow.transform , M_PI_2);
            }
        }
        else
        {
            _iWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//            _statusWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, ((sCommonUnitFullHeight() - 64)/2), sCommonUnitFullWidth(), NoticeHeight)];
        }
        
        
        _iWindow.windowLevel = UIWindowLevelStatusBar + 2;//UIWindowLevelAlert;
        _iWindow.opaque = NO;
    }
    return _iWindow;
}

- (UIView *)floatingView
{
    if (!_floatingView) {
        
        if(isIpad)
        {
            if([[UIScreen mainScreen] bounds].size.width <= [[UIScreen mainScreen] bounds].size.height)
            {
                _floatingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            }
            else
            {
                _floatingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width)];
            }
        }
        else
        {
            _floatingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        }
        
        
        _floatingView.backgroundColor = [UIColor colorWithRed:46 / 255.0 green:49 / 255.0 blue:51 / 255.0 alpha:0.9];
        _floatingView.opaque = NO;
        
    }
    return _floatingView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100.f, 100.f)];
        if(isIpad)
        {
            if([[UIScreen mainScreen] bounds].size.width <= [[UIScreen mainScreen] bounds].size.height)
            {
                _bottomView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
            }
            else
            {
                _bottomView.center = CGPointMake([[UIScreen mainScreen] bounds].size.height / 2, [[UIScreen mainScreen] bounds].size.width / 2);
            }
        }
        else
        {
            _bottomView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
        }
        
        _bottomView.backgroundColor = [UIColor clearColor];
        _bottomView.layer.cornerRadius = 3.f;
        _bottomView.layer.masksToBounds = YES;
    }
    return _bottomView;
}

- (UIImageView *)rotationView
{
    if (!_rotationView) {
        _rotationView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50.f, 50.f)];
        _rotationView.center = CGPointMake(50.f, 50.f);
        UIImage *image = [UIImage imageNamed:@"common_icon_loading"];
        _rotationView.image = image;
    }
    return _rotationView;
}

+ (void)show
{
    if (!loadingView) {
        BITLoadingView *onLoadingView = [[BITLoadingView alloc] init];
        loadingView = onLoadingView;
    }
    loadingView.showClearHUDFlag = NO;
    loadingView.bottomView.hidden = NO;
    loadingView.floatingView.alpha = 0.9f;
    loadingView.responseDisplayFlag = NO;
    [loadingView doAnimation];
}

+ (void)showFirstHub
{
    if (!loadingView) {
        BITLoadingView *onLoadingView = [[BITLoadingView alloc] init];
        loadingView = onLoadingView;
    }
    loadingView.showClearHUDFlag = NO;
    loadingView.bottomView.hidden = NO;
    loadingView.floatingView.alpha = 0.9f;
    loadingView.responseDisplayFlag = YES;
    [loadingView doAnimation];
}

+ (void)showFirstClearHub
{
    if (!loadingView) {
        BITLoadingView *onLoadingView = [[BITLoadingView alloc] init];
        loadingView = onLoadingView;
    }
    loadingView.showClearHUDFlag = YES;
    loadingView.bottomView.hidden = NO;
    loadingView.floatingView.alpha = 0.9f;
    loadingView.responseDisplayFlag = YES;
    [loadingView doAnimation];
}

+ (void)resetResponseDisplayFlag
{
    if (loadingView) {
        loadingView.responseDisplayFlag = NO;
    }
}

+ (void)showClearHUD
{
    if (!loadingView) {
        BITLoadingView *onLoadingView = [[BITLoadingView alloc] init];
        loadingView = onLoadingView;
    }
    loadingView.showClearHUDFlag = YES;
    loadingView.bottomView.hidden = YES;
    loadingView.floatingView.alpha = 0.0f;
    loadingView.responseDisplayFlag = NO;
    [loadingView doAnimation];
}

- (void)doAnimation
{
    self.floatingView.alpha = 0.f;
    [UIView animateWithDuration:.05f animations:^{
        if(self.showClearHUDFlag)
        {
            self.floatingView.alpha = 0.0f;
        }
        else
        {
            self.floatingView.alpha = 0.9f;
        }
    }];
    [self.iWindow addSubview:self];
    [self.iWindow makeKeyAndVisible];
    CABasicAnimation *animation = [ CABasicAnimation
                                   animationWithKeyPath: @"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    //围绕Z轴旋转，垂直与屏幕
    animation.toValue = [ NSValue valueWithCATransform3D:
                         
                         CATransform3DMakeRotation(M_PI/2, 0.0, 0.0, 1.0)];
    animation.duration = 0.2;
    //旋转效果累计，先转180度，接着再旋转180度，从而实现360旋转
    animation.cumulative = YES;
    animation.repeatCount = 1000;
    [loadingView.rotationView.layer addAnimation:animation forKey:nil];
    
}

+ (void)hide
{
    if(!loadingView.responseDisplayFlag)
    {
        [loadingView.rotationView.layer removeAllAnimations];
        [loadingView removeFromSuperview];
        loadingView.iWindow = nil;
        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
    }
}


- (void)becomeActive{
    NSLog(@"becomeActive");
    if(loadingView.superview)
    {
        [self doAnimation];
    }
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
