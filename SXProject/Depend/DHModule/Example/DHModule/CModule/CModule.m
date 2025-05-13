//
//  AModule.m
//  DHModuleExample
//
//  Created by iblue on 2017/7/13.
//  Copyright © 2017年 jiangbin. All rights reserved.
//

#import "CModule.h"
#import "CViewController.h"
#import "ServiceProtocol.h"

@implementation CModule

- (void)moduleInit
{
    //注册模块C
    [DHModule registerService:@protocol(CServiceProtocol) implClass:[CViewController class]];
}

- (void)moduleCustomEvent:(NSString *)eventname userInfo:(NSDictionary *)userInfo
{
    NSLog(@"Receive custom event:%@ - %@", eventname, userInfo[@"eventId"]);
}
@end
