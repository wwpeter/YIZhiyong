//
//  WBCloudFaceNetManager.h
//  WBCloudFaceVerifySDK
//
//  Created by pp on 2017/4/14.
//  Copyright © 2017年 brownfeng. All rights reserved.
//

#import "AFNetworking.h"

@interface WBCloudFaceNetManager : AFHTTPSessionManager
@property (nonatomic, copy) NSString *baseURLString;
+ (instancetype)sharedClient;


@end
