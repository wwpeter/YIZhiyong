//
//  BITRequestManager.h
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

#import <Foundation/Foundation.h>
#import "AFURLRequestSerialization.h"
typedef  NS_ENUM(NSInteger, BusinessHeadType){
    BusinessHeadTypeNone = 0,      // 参数类型，默认
    BusinessHeadTypeRefreshJwt = 1, // 参数类型，签名
    BusinessHeadTypeLogin = 2      // 参数类型，登录
};
// 内部调试日志开关 0 关闭、1 打开
#ifndef BITRequestLoggingEnabled
#define BITRequestLoggingEnabled 1
#endif

@class BITRequestApi;

@interface BITRequestManager : NSObject

+ (nonnull BITRequestManager *)sharedManager;

//发起请求
- (void)startRequestApi:(nonnull BITRequestApi *)requestApi
               filePath:(nullable NSString *)filePath
               progress:(nullable void (^)(NSProgress * _Nullable loadProgress))loadProgressBlock
constructingBodyWithBlock:(void (^_Nonnull)(_Nullable id <AFMultipartFormData>))constructingBlock
        completeHandler:(void (^_Nonnull)(NSDictionary *_Nullable, NSError *_Nullable))completeHandler;


//取消请求
- (void)cancelRequestApi:(nonnull BITRequestApi *)requestApi;

/**
 取消某几个请求
 
 @param apis 请求对应的api
 */
- (void)cancelRequestApis:(NSArray <BITRequestApi *>*_Nonnull)apis;

/**
 取消当前进行的所有请求
 */
- (void)cancelAllRequests;

@end
