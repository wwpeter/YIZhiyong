//
//  BITRequestConfig.m
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

#import "BITRequestConfig.h"
#import <BITCategories/BITFDCategories.h>

@interface BITRequestConfig ()

@property (nonatomic, strong) NSArray *extraBuiltinParameterHandlers;

@property (nonatomic, strong, readwrite) NSDictionary *builtinParameters;

@end

@implementation BITRequestConfig

+ (BITRequestConfig *)sharedConfig
{
    static BITRequestConfig *config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        config = [[self alloc] init];
    });
    return config;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.needHTTPS = NO;
#ifdef DEBUG
        self.debugEnabled = YES;
        self.baseURL = kBaseURL;
#else
        self.debugEnabled = NO;
        self.baseURL = kBaseURL;
#endif
        self.timeOffset = 0;
    }
    return self;
}
    
- (NSArray *)extraBuiltinParameterHandlers
{
    if (!_extraBuiltinParameterHandlers) {
        _extraBuiltinParameterHandlers = [[NSArray alloc] init];
    }
    return _extraBuiltinParameterHandlers;
}

//默认拼接的参数,手机系统的一些参数以及全局添加的参数都可以放在这里
- (NSDictionary *)builtinParameters
{
    NSMutableDictionary *muBuiltinParameters = [[NSMutableDictionary alloc] init];
//    [muBuiltinParameters setSafeObject:@"ios" forKey:@"mobileType"];//手机类型
//    [muBuiltinParameters setSafeObject:[UIDevice yixiang_appVersion] forKey:@"appVersion"];//版本号
//    [muBuiltinParameters setSafeObject:[UIDevice yixiang_buildVersion] forKey:@"buildVersion"];//build号
//    [muBuiltinParameters setSafeObject:[UIDevice yixiang_fullVersion] forKey:@"fullVersion"];//完整版本号(版本号+build号)
//    [muBuiltinParameters setSafeObject:[UIDevice yixiang_systemType] forKey:@"systemType"];//手机型号
//    [muBuiltinParameters setSafeObject:[UIDevice yixiang_systemVersion] forKey:@"systemVersion"];//系统版本
//    [muBuiltinParameters setSafeObject:[UIDevice isJailBreak]?@"1":@"0" forKey:@"isJailBreak"];//是否越狱
    //渠道
    
    return [muBuiltinParameters copy];
}
    
//更新extraBuiltinParameterHandlers
- (void)addExtraBuiltinParameters:(ExtraBuiltinParametersHandler)extraBuiltinParameters
{
    @synchronized (self) {
        NSMutableArray *mutableArray = [self.extraBuiltinParameterHandlers mutableCopy];
        [mutableArray addSafeObject:extraBuiltinParameters];
        self.extraBuiltinParameterHandlers = [NSArray arrayWithArray:mutableArray];
    }
}

@end
