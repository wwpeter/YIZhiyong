//
//  RequestConfigManager.m
//  SXProject
//
//  Created by 王威 on 2024/4/22.
//

#import "RequestConfigManager.h"
#import "BITRequestConfig.h"

@implementation RequestConfigManager

+ (void)requestConfig {
 
    BITRequestConfig *config = [BITRequestConfig sharedConfig];
    config.needHTTPS = NO;
//    config.baseURL = [YXSwitchEnvironment sharedEnvironment].currentENV.baseURL;
    config.hudClassName = @"BITLoadingView";
    //错误信息处理
    config.errorMsgHandler = ^(NSDictionary *result, NSError *error){
        
    };
    //账号登出处理
    config.logoutAccountHandler = ^(NSDictionary *result, NSError *error){
        if(error)
        {
            NSLog(@"result:%@;error:%@", result, error);
        }
    };
    //更换token处理
    config.changeTokenHandler = ^(NSDictionary *result, NSError *error){
        if(error)
        {
            NSLog(@"result:%@;error:%@", result, error);
            //            if((error.code == 401) || ((result) && [result isKindOfClass:[NSDictionary class]] && ([result[@"returnCode"] integerValue] == 0) && (result[@"msg"]) && [result[@"msg"] isKindOfClass:[NSString class]] && ![result[@"msg"] isEqualToString:@"<null>"] && ([result[@"msg"] rangeOfString:@"登录"].location != NSNotFound)))
            //            {
            ////                [self exitLogin];
            //                [BITRouter openURL:@"gb://HHTLoginViewController"];
            //            }
            if (error.code == 95000000) {//token失效
                //                [[YXBAccountTool sharedAccountTool] tokenOut];
            }
        }
    };
}
@end
