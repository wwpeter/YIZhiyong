//
//  BITRequestApi.h
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

#import "BITBaseRequestApi.h"

@interface BITRequestApi : BITBaseRequestApi

/**
 请求接口的path
 */
@property (nonatomic, copy, readonly)   NSString          *apiPath;
/**
 请求的http类型,默认GET类型
 */
@property (nonatomic, assign, readonly) RequestMethodType requestMethodType;
/**
 请求基于的URL
 */
@property (nonatomic, copy, readonly)   NSString          *baseURL;
/**
 请求的参数
 */
@property (nonatomic, strong, readonly) id      params;
/**
 接口超时时间,默认是20秒
 */
@property (nonatomic, assign, readonly) NSInteger         timeoutInterval;
/**
 是否展示加载框,默认展示，优先级为中等
 */
@property (nonatomic, assign, readonly) BOOL              showHUD;
/**
 是否展示透明加载框,默认不展示，优先级别最高
 */
@property (nonatomic, assign, readonly) BOOL              showClearHUD;
/**
 是否展示加载框,默认不展示，双请求合并，第一个请求显示加载框，返回成功时不取消加载框，失败时取消加载框，优先级别最低
 */
@property (nonatomic, assign, readonly) BOOL              showFirstHUD;
/**
 是否展示透明加载框,默认不展示，双请求合并，第一个请求显示加载框，返回成功时不取消加载框，失败时取消加载框，优先级别最低
 */
@property (nonatomic, assign, readonly) BOOL              showFirstClearHUD;
/**
 是否取消加载框,默认不取消，双请求合并，第二个请求不显示加载框，返回后取消加载框
 */
@property (nonatomic, assign, readonly) BOOL              cancelEndHUD;
/**
 是否需要缓存数据,默认不需要
 */
@property (nonatomic, assign, readonly) BOOL              needCache;
/**
 是否允许同时发送多个同一请求,默认NO
 */
@property (nonatomic, assign, readonly) BOOL              allowConcurrentExecution;
/**
 baseURL+apiPath组成的完整URL
 */
@property (nonatomic, copy, readonly)   NSString          *intactURL;
/**
 是否不需要统一显示错误信息
 */
@property (nonatomic, assign, readonly) BOOL              needNotShowErrorMessage;

//链式调用方式

/**
 设置接口路径
 */
- (BITRequestApi *(^)(NSString *apiPath))setApiPath;
/**
 设置接口请求方式
 */
- (BITRequestApi *(^)(RequestMethodType requestMethodType))setRequestMethodType;
/**
 设置接口请求URL
 */
- (BITRequestApi *(^)(NSString *baseURL))setBaseURL;
/**
 设置接口请求参数
 */
- (BITRequestApi *(^)(id params))setParams;
/**
 重新设置接口请求参数
 */
- (BITRequestApi *(^)(NSDictionary *params))reSetParams;
/**
 设置接口超时时间
 */
- (BITRequestApi *(^)(NSInteger timeoutInterval))setTimeoutInterval;
/**
 设置接口是否展示菊花
 */
- (BITRequestApi *(^)(BOOL showHUD))setShowHUD;
/**
 设置接口是否展示透明菊花
 */
- (BITRequestApi *(^)(BOOL showClearHUD))setShowClearHUD;
/**
 设置接口是否展示第一个请求菊花
 */
- (BITRequestApi *(^)(BOOL showFirstHUD))setShowFirstHUD;

/**
 设置接口是否展示第一个请求透明菊花
 */
- (BITRequestApi *(^)(BOOL showClearHUD))setShowFirstClearHUD;
/**
 设置接口是否需要缓存
 */
- (BITRequestApi *(^)(BOOL needCache))setNeedCache;
/**
 设置接口是否不需要统一显示错误信息
 */
- (BITRequestApi *(^)(BOOL needNotShowErrorMessage))setNeedNotShowErrorMessage;
/**
 是否允许同时发送多个同一请求
 */
- (BITRequestApi *(^)(BOOL allowConcurrentExecution))setAllowConcurrentExecution;


@end
