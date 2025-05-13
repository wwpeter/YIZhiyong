//
//  AModule.m
//  DHModuleExample
//
//  Created by iblue on 2017/7/13.
//  Copyright © 2017年 jiangbin. All rights reserved.
//

#import "BModule.h"
#import "BViewController.h"
#import "ServiceProtocol.h"

@implementation BModule

- (void)moduleInit
{
    //注册模块B
    [DHModule registerService:@protocol(BServiceProtocol) implClass:[BViewController class]];
    
//    [DHRouter registerURLPattern:@"example://moduleb?eventname=" toHandler:^(NSDictionary *routerParameters) {
//        BViewController *bVc = [[BViewController alloc] init];
//        bVc.eventName = routerParameters[@"eventName"];
//    }];
    
    [DHRouter registerURLPattern:@"example://moduleb?eventname=" toObjectHandler:^id(NSDictionary *routerParameters) {
        BViewController *bVc = [[BViewController alloc] init];
        bVc.eventName = routerParameters[@"eventname"];
        
        void (^ callback)(id result) = routerParameters[DHRouterParameterCompletion];
        if (callback) {
            callback(bVc);
        }
        
        return bVc;
    }];
}
    
- (void)moduleCustomEvent:(NSString *)eventname userInfo:(NSDictionary *)userInfo
{
    NSLog(@"Receive custom event:%@ - %@", eventname, userInfo[@"eventId"]);
}

@end
