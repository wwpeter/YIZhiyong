//
//  YXBAccountTool.m
//  haohuitui
//
//  Created by huihui on 2022/5/26.
//
#import "YXBAccountTool.h"
#import "WTSConfigManager.h"
#import "BITAlertView.h"
#import "BITBaseTabBarController.h"
#import "BITNavigationController.h"
#import "BITRouter.h"

@interface YXBAccountTool ()
@property (nonatomic, strong)  BITAlertView *alertView;
@end
@implementation YXBAccountTool
+(YXBAccountTool *) sharedAccountTool
{
    static YXBAccountTool *sharedAccountTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedAccountTool = [[self alloc] init];
        
    });
    return sharedAccountTool;
}

- (void)removeAccount
{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"superVipFlag"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"unId"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"appChannel"];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"fundLimitSwitch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)goSelectTabbar:(NSUInteger )index{
    if ([[BITNavigationController currentNavigationController].rootViewController isKindOfClass:[BITBaseTabBarController class]]) {
        BITBaseTabBarController *rootVC = (BITBaseTabBarController *)[BITNavigationController currentNavigationController].rootViewController;
        [rootVC selectAtIndex:index];
//                        rootVC.uxTabBar.hidden = NO;
        [[BITNavigationController currentNavigationController] popToRootViewControllerAnimated:YES];
    }
}
//注册协议
-(void)goUserAgreementH5{
   
}
//隐私协议
-(void)goPrivacyAgreementH5{
    
}
//个人-平台信息授权书
-(void)goShareAgreementH5{
   
}
//个人-机构信息授权书
-(void)goPersonAgreementH5BoothId:(NSString *)boothId{
 
}
//业务知情同意书
-(void)goKnowAgreementH5:(NSString *)title{

}

-(void)tokenOut{

}
-(BITAlertView *)alertView{
    if (!_alertView) {
    }
    return _alertView;
}
@end
