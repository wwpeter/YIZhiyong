//
//  BITRequestChain.m
//  Pods
//
//  Created by jiaguoshang on 2017/5/3.
//
//

#import "BITRequestChain.h"
#import "BITRequestClient.h"
#import <BITCategories/BITFDCategories.h>

#define MaxRequestIndex 666666

@interface BITRequestChain ()

@property (nonatomic, strong) NSMutableArray     *requestArray;

@property (nonatomic, strong) NSMutableArray     *callbackArray;

@property (nonatomic, copy)   Callback           defaultCallback;

@property (nonatomic, assign) NSUInteger         requestIndex;

@end

@implementation BITRequestChain

- (instancetype)init
{
    self = [super init];
    if (self) {
        _requestIndex = 0;
        _defaultCallback = ^(NSString *result, NSError *error){
            //empty
        };
    }
    return self;
}

- (NSMutableArray *)requestArray
{
    if (!_requestArray) {
        _requestArray = [NSMutableArray array];
    }
    return _requestArray;
}

- (NSMutableArray *)callbackArray
{
    if (!_callbackArray) {
        _callbackArray = [NSMutableArray array];
    }
    return _callbackArray;
}

- (void)addChainRequest:(BITRequestApi *)requestApi
{
    [self addChainRequest:requestApi callback:nil];
}

- (void)addChainRequest:(BITRequestApi *)requestApi callback:(Callback)callback
{
    if (!requestApi) {
        return;
    }
    [self.requestArray addSafeObject:requestApi];
    if (callback) {
        [self.callbackArray addSafeObject:callback];
    } else {
        [self.callbackArray addSafeObject:self.defaultCallback];
    }
}

- (void)start
{
    if (self.requestIndex >= self.requestArray.count) {
        [self clearSaveData];
        return;
    }
    BITRequestApi *requestApi = [self.requestArray objectAtSafeIndex:self.requestIndex];
    Callback callback = [self.callbackArray objectAtSafeIndex:self.requestIndex];
    [[BITRequestClient sharedClient] loadDataWithApi:requestApi successBlock:^(NSString * _Nullable result) {
        callback(result, nil);
        self.requestIndex++;
        if (self.requestIndex >= self.requestArray.count) {
            if (self.chainFinishedCallback) {
                self.chainFinishedCallback(requestApi, result);
            }
            [self clearSaveData];
        } else {
            [self start];
        }
    } failureBlock:^(NSError * _Nullable error) {
        if (self.chainFailureCallback) {
            self.chainFailureCallback(requestApi, error);
        }
        [self clearSaveData];
    }];
}

- (void)stop
{
    //表示当前有正在请求的接口
    if (self.requestIndex >= self.requestArray.count) {
        return;
    }
    BITRequestApi *requestApi = [self.requestArray objectAtSafeIndex:self.requestIndex];
    self.requestIndex = MaxRequestIndex;
    [[BITRequestClient sharedClient] cancelRequestApi:requestApi];
    [self clearSaveData];
}

- (void)clearSaveData
{
    [self.requestArray removeAllObjects];
    [self.callbackArray removeAllObjects];
}

@end
