//
//  BITRequestChain.h
//  Pods
//
//  Created by jiaguoshang on 2017/5/3.
//
//

#import <Foundation/Foundation.h>
#import "BITRequestApi.h"

typedef void(^Callback)(NSString *result, NSError *error);

@interface BITRequestChain : NSObject
/**
 链式请求成功结束之后的回调
 */
@property (nonatomic, copy) void(^chainFinishedCallback)(BITRequestApi *requestApi, NSString *result);
/**
 链式请求失败之后的回调
 */
@property (nonatomic, copy) void(^chainFailureCallback)(BITRequestApi *requestApi, NSError *error);

/**
 添加请求

 @param requestApi 请求类
 */
- (void)addChainRequest:(BITRequestApi *)requestApi;

/**
 添加请求,支持回调

 @param requestApi 请求类
 @param callback requestApi回调函数
 */
- (void)addChainRequest:(BITRequestApi *)requestApi callback:(Callback)callback;

/**
 开始链式请求
 */
- (void)start;
/**
 停止链式请求,取消正在进行或者还未开始的请求
 */
- (void)stop;

@end
