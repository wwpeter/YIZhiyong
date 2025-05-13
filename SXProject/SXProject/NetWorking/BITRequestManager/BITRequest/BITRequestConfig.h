//
//  BITRequestConfig.h
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

//这个类是请求的一些配置项,可以在APP启动的时候做一些配置,作为全局的开关

#import <Foundation/Foundation.h>
#import "URLDefine.h"

typedef NSDictionary *(^ExtraBuiltinParametersHandler)(void);

typedef void(^GeneralHandler)(NSDictionary *result, NSError *error);

@interface BITRequestConfig : NSObject

//请求的baseURL,默认配置正式的URL
@property (nonatomic, copy)     NSString *baseURL;

//是否允许调试,默认内部设置debug模式开启,release模式关闭
@property (nonatomic, assign)   BOOL     debugEnabled;

/**
 注册HUD类名,调起HUD显示与隐藏
 [Class show]----展示
 [Class hide]----隐藏
 param name 类名
 */
@property (nonatomic, copy)     NSString *hudClassName;

//请求默认为附加上的参数
@property (nonatomic, strong, readonly) NSDictionary *builtinParameters;

//errorMsg处理handler
@property (nonatomic, copy) GeneralHandler errorMsgHandler;

//token失效,账号被踢出处理handler
@property (nonatomic, copy) GeneralHandler logoutAccountHandler;

//token更换处理handler
@property (nonatomic, copy) GeneralHandler changeTokenHandler;

//是否需要支持HTTPS请求,默认是YES
@property (nonatomic, assign) BOOL needHTTPS;

//同步时间戳的时间差值
@property (nonatomic, assign) NSTimeInterval timeOffset;

+ (BITRequestConfig *)sharedConfig;

//添加一些额外的参数进来,reqToken可以在这里设置进来
- (void)addExtraBuiltinParameters:(ExtraBuiltinParametersHandler)extraBuiltinParameters;

//保存额外参数的block集合
- (NSArray *)extraBuiltinParameterHandlers;
    
@end
