//
//  BITRequestClient.m
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

#import "BITRequestClient.h"
#import "BITRequestApi.h"
#import "BITRequestConfig.h"
#import "BITRequestManager.h"
#import "BITCacheCenter.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import "BITCommonUnit.h"
#import <BITCategories/BITFDCategories.h>
#import <objc/message.h>
#import <MJExtension/MJExtension.h>

#define IsEmptyString(str)      (!str || [str isEqual:[NSNull null]] || [str isEqualToString : @""])

@interface BITRequestClient ()
    
    
@end


@implementation BITRequestClient

+ (BITRequestClient *)sharedClient
{
    static BITRequestClient *client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    return client;
}
    
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
//        [[BITRequestConfig sharedConfig] addExtraBuiltinParameters:^NSDictionary *{
//            return [BITRequestConfig sharedConfig].debugEnabled ? @{@"_json": @"1", @"_debug": @"1"} : nil;
//        }];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netStatusChanged:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(systemClockDidChange:) name:NSSystemClockDidChangeNotification object:nil];

    }
    return self;
}

- (void)netStatusChanged:(NSNotification *)notification
{
    self.networkStatus = [notification.userInfo[AFNetworkingReachabilityNotificationStatusItem] integerValue];
}

- (void)systemClockDidChange:(NSNotification *)notification
{
    [self syncServeTime];
}


- (void)loadDataWithApi:(BITRequestApi *)requestApi
           successBlock:(SuccessBlock)successBlock
           failureBlock:(FailureBlock)failureBlock
{
    [self loadDataWithApi:requestApi
                 filePath:nil
                 progress:nil
constructingBodyWithBlock:nil
             successBlock:successBlock
             failureBlock:failureBlock];

}


#pragma mark - download request

- (void)downloadTaskWithApi:(BITRequestApi *)requestApi
                   filePath:(NSString *)filePath
               successBlock:(SuccessBlock)successBlock
               failureBlock:(FailureBlock)failureBlock
{
    [self downloadTaskWithApi:requestApi
                     filePath:filePath
                     progress:nil
                 successBlock:successBlock
                 failureBlock:failureBlock];
}

- (void)downloadTaskWithApi:(BITRequestApi *)requestApi
                   filePath:(NSString *)filePath
                   progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgressBlock
               successBlock:(SuccessBlock)successBlock
               failureBlock:(FailureBlock)failureBlock
{
    [self loadDataWithApi:requestApi
                 filePath:filePath
                 progress:downloadProgressBlock
constructingBodyWithBlock:nil
             successBlock:successBlock
             failureBlock:failureBlock];
}

#pragma mark - upload request

- (void)uploadTaskWithApi:(BITRequestApi *)requestApi
constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))constructingBlock
             successBlock:(SuccessBlock)successBlock
             failureBlock:(FailureBlock)failureBlock
{
    [self uploadTaskWithApi:requestApi
  constructingBodyWithBlock:constructingBlock
                   progress:nil
               successBlock:successBlock
               failureBlock:failureBlock];
}

- (void)uploadTaskWithApi:(BITRequestApi *)requestApi
constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))constructingBlock
                 progress:(void (^)(NSProgress *uploadPrgress))uploadProgressBlock
             successBlock:(SuccessBlock)successBlock
             failureBlock:(FailureBlock)failureBlock
{
    [self loadDataWithApi:requestApi
                 filePath:nil
                 progress:uploadProgressBlock
constructingBodyWithBlock:constructingBlock
             successBlock:successBlock
             failureBlock:failureBlock];
}

- (void)validateProperty:(BITRequestApi *)requestApi
{
    if (IsEmptyString(requestApi.apiPath)) {
        NSCAssert(NO, @"请求URL的path不应为空,请检查");
        return;
    }
    if (IsEmptyString(requestApi.baseURL)) {
        if (IsEmptyString([BITRequestConfig sharedConfig].baseURL)) {
            NSCAssert(NO, @"请求URL的path不应为空,请检查");
            return;
        } else {
            requestApi.setBaseURL([BITRequestConfig sharedConfig].baseURL);
        }
    }
}

- (void)loadDataWithApi:(BITRequestApi *)requestApi
               filePath:(NSString *)filePath
               progress:(nullable void (^)(NSProgress *loadProgress))loadProgressBlock
constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))constructingBlock
           successBlock:(SuccessBlock)successBlock
           failureBlock:(FailureBlock)failureBlock
{
    //校验api的各个属性值得正确性
    [self validateProperty:requestApi];
        
    //判断是否需要展示提示框
    if (requestApi.showClearHUD) {
        requestApi.setShowHUD(NO);
        requestApi.setShowFirstHUD(NO);
        if (!IsEmptyString([BITRequestConfig sharedConfig].hudClassName)) {
            ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(showClearHUD));
        } else {
            NSCAssert(NO, @"请配置HUD类名");
        }
    }
    else if (requestApi.showHUD) {
        requestApi.setShowFirstHUD(NO);
        if (!IsEmptyString([BITRequestConfig sharedConfig].hudClassName)) {
            ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(show));
        } else {
            NSCAssert(NO, @"请配置HUD类名");
        }
    }
    else if (requestApi.showFirstHUD) {
        if (!IsEmptyString([BITRequestConfig sharedConfig].hudClassName)) {
            ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(showFirstHub));
        } else {
            NSCAssert(NO, @"请配置HUD类名");
        }
    }
    else if (requestApi.showFirstClearHUD) {
        if (!IsEmptyString([BITRequestConfig sharedConfig].hudClassName)) {
            ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(showFirstClearHub));
        } else {
            NSCAssert(NO, @"请配置HUD类名");
        }
    }
    else
    {
        if (!IsEmptyString([BITRequestConfig sharedConfig].hudClassName)) {
            ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(resetResponseDisplayFlag));
        } else {
            NSCAssert(NO, @"请配置HUD类名");
        }
    }
    
    //开始请求
    [[BITRequestManager sharedManager] startRequestApi:requestApi
                                             filePath:filePath
                                             progress:loadProgressBlock
                            constructingBodyWithBlock:constructingBlock
                                      completeHandler:^(NSDictionary *result, NSError *error) {
        
        //处理几个全局的blockHandler
        if ([BITRequestConfig sharedConfig].errorMsgHandler) {
            [BITRequestConfig sharedConfig].errorMsgHandler(result, error);
        }
        
        if ([BITRequestConfig sharedConfig].logoutAccountHandler) {
            [BITRequestConfig sharedConfig].logoutAccountHandler(result, error);
        }
        
        if ([BITRequestConfig sharedConfig].changeTokenHandler) {
            [BITRequestConfig sharedConfig].changeTokenHandler(result, error);
        }
        
        if (!error) {//请求成功的回调
            if ([BITRequestConfig sharedConfig].hudClassName) {
                ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(hide));
            }
            if (successBlock) {
                successBlock(result);
            }
            if (requestApi.needCache) {
                [[BITCacheCenter sharedInstance] setObject:result
                                                   forKey:requestApi.apiPath
                                               withParams:requestApi.params
                                             withCallback:nil];
            }
        } else {//请求失败的回调
            if (failureBlock) {
                if (!IsEmptyString([BITRequestConfig sharedConfig].hudClassName)) {
                    ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(resetResponseDisplayFlag));
                } else {
                    NSCAssert(NO, @"请配置HUD类名");
                }
                if (requestApi.needCache) {//需要缓存,从缓存中读取数据
                    [[BITCacheCenter sharedInstance] objectForKey:requestApi.apiPath
                                                      withParams:requestApi.params
                                                    withCallback:^(NSString *key, id object) {
                                                        if ([BITRequestConfig sharedConfig].hudClassName) {
                                                            ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(hide));
                                                        }
                                                        if (object && successBlock && [object isKindOfClass:[NSDictionary class]]) {
                                                            successBlock(object);
                                                        } else {
                                                            NSError *anotherError = error;
                                                            if (!(requestApi.needNotShowErrorMessage)) {
//                                                                [[BITNoticeView currentNotice] showErrorNotice:anotherError.domain];
//                                                                anotherError = [NSError errorWithDomain:@"" code:error.code userInfo:error.userInfo];
                                                            }
                                                            failureBlock(anotherError);
                                                        }
                                                    }];
                } else {
                    if ([BITRequestConfig sharedConfig].hudClassName) {
                        ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(hide));
                    }
                    NSError *anotherError = error;
                    if (!(requestApi.needNotShowErrorMessage)) {
//                        [[BITNoticeView currentNotice] showErrorNotice:anotherError.domain];
//                        anotherError = [NSError errorWithDomain:@"" code:error.code userInfo:error.userInfo];
                    }
                    failureBlock(anotherError);
                }
            } else {
                if ([BITRequestConfig sharedConfig].hudClassName) {
                    ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(hide));
                }
            }
        }
    }];

}

/**
 取消小菊花加载框，真对一般依次发送两个请求，当时特别情况下，发送第一个请求后不发送第二个请求，需要取消加载框的情况
 */
-(void)hiddenHub
{
    if (!IsEmptyString([BITRequestConfig sharedConfig].hudClassName)) {
        ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(resetResponseDisplayFlag));
    } else {
        NSCAssert(NO, @"请配置HUD类名");
    }
    if ([BITRequestConfig sharedConfig].hudClassName) {
        ((void (*)(id, SEL))objc_msgSend)([NSClassFromString([BITRequestConfig sharedConfig].hudClassName) class], @selector(hide));
    }
}

#pragma mark - 取消请求

- (void)cancelRequestApi:(BITRequestApi *)requestApi
{
    [[BITRequestManager sharedManager] cancelRequestApi:requestApi];
}

- (void)cancelRequestApis:(NSArray<BITRequestApi *> *)apis
{
    if (!apis || apis.count == 0) {
        return;
    }
    [[BITRequestManager sharedManager] cancelRequestApis:apis];
}

- (void)cancelAllRequests
{
    [[BITRequestManager sharedManager] cancelAllRequests];
}

#pragma mark - 同步服务器时间

- (void)syncServeTime
{
    [self syncServeTimeWithSuccessBlock:nil failureBlock:nil];
}

- (void)syncServeTimeWithSuccessBlock:(SuccessBlock)successBlock
                         failureBlock:(FailureBlock)failureBlock
{
    BITRequestApi *syncTimeApi = [[BITRequestApi alloc] init];
    syncTimeApi.setBaseURL([BITRequestConfig sharedConfig].baseURL)
    .setApiPath(@"cap/syncTime/1.0")
    .setRequestMethodType(YX_Request_GET)
    .setShowHUD(NO)
    .setParams(@{});
    [[BITRequestClient sharedClient] loadDataWithApi:syncTimeApi successBlock:^(NSString *result) {
        NSDictionary *tempDic = [result mj_JSONObject];
        NSTimeInterval serverTime = [[tempDic objectForKey:@"serialNo"] doubleValue];
        NSTimeInterval localTime = ceil([[NSDate date] timeIntervalSince1970] * 1000);
        if (fabs(serverTime - localTime) > 300 * 1000) {
            [BITRequestConfig sharedConfig].timeOffset = serverTime - localTime;
        } else {
            [BITRequestConfig sharedConfig].timeOffset = 0;
        }
        if (successBlock) {
            successBlock(result);
        }
    } failureBlock:^(NSError *error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}



@end
