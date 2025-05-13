//
//  AModule.m
//  DHModuleExample
//
//  Created by iblue on 2017/7/13.
//  Copyright © 2017年 jiangbin. All rights reserved.
//

#import "AModule.h"
#import "AViewController.h"
#import "AServiceProtocol.h"

@implementation AModule

- (void)moduleInit
{
    //注册模块A
    [DHModule registerService:@protocol(AServiceProtocol) implClass:[AViewController class]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}
@end
