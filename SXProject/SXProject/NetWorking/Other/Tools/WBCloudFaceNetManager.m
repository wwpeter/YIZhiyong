//
//  WBCloudFaceNetManager.m
//  WBCloudFaceVerifySDK
//
//  Created by pp on 2017/4/14.
//  Copyright © 2017年 brownfeng. All rights reserved.
//

#import "WBCloudFaceNetManager.h"

@implementation WBCloudFaceNetManager
+ (instancetype)sharedClient{
    static WBCloudFaceNetManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[WBCloudFaceNetManager alloc] init];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    return _sharedClient;
}

- (NSURL *)baseURL {
    NSURL *url = [NSURL URLWithString:self.baseURLString];
    // Ensure terminal slash for baseURL path, so that NSURL +URLWithString:relativeToURL: works as expected
    if ([[url path] length] > 0 && ![[url absoluteString] hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    return url;
}
@end
