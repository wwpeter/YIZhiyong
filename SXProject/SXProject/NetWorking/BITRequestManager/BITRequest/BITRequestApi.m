//
//  BITRequestApi.m
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

#import "BITRequestApi.h"

@interface BITRequestApi ()

//请求接口的path
@property (nonatomic, copy, readwrite)   NSString          *apiPath;
    
//请求的http类型
@property (nonatomic, assign, readwrite) RequestMethodType requestMethodType;
    
//请求基于的URL
@property (nonatomic, copy, readwrite)   NSString          *baseURL;
    
//请求的参数
@property (nonatomic, strong, readwrite) id      params;
    
//接口超时时间,默认是30秒
@property (nonatomic, assign, readwrite) NSInteger         timeoutInterval;
    
//是否展示加载框
@property (nonatomic, assign, readwrite) BOOL              showHUD;

/**
 是否展示透明加载框,默认不展示
 */
@property (nonatomic, assign, readwrite) BOOL              showClearHUD;
/**
 是否展示加载框,默认不展示，双请求合并，第一个请求显示加载框，返回成功时不取消加载框，失败时取消加载框，优先级别最低
 */
@property (nonatomic, assign, readwrite) BOOL              showFirstHUD;

/**
 是否展示加载框,默认不展示，双请求合并，第一个请求显示加载框，返回成功时不取消加载框，失败时取消加载框，优先级别最低
 */
@property (nonatomic, assign, readwrite) BOOL              showFirstClearHUD;

//是否需要缓存数据
@property (nonatomic, assign, readwrite) BOOL              needCache;
//是否不需要统一显示错误信息
@property (nonatomic, assign, readwrite) BOOL              needNotShowErrorMessage;

//是否允许同时发送多个同一请求
@property (nonatomic, assign, readwrite) BOOL              allowConcurrentExecution;
/**
 baseURL+apiPath组成的完整URL
 */
@property (nonatomic, copy, readwrite)   NSString          *intactURL;

@end

@implementation BITRequestApi

    
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestMethodType = YX_Request_POST;
        self.timeoutInterval = 20;
        self.showHUD = YES;
        self.showClearHUD = NO;
        self.needCache = NO;
        self.needNotShowErrorMessage = NO;
        self.allowConcurrentExecution = YES;
//        self.allowConcurrentExecution = NO;
    }
    return self;
}
    
//- (id )params
//{
//    if (!_params) {
//        _params = [NSMutableDictionary dictionary];
//    }
//    return _params;
//}
//
- (BITRequestApi *(^)(NSString *apiPath))setApiPath
{
    return ^(NSString *apiPath) {
        self.apiPath = apiPath;
        if (self.baseURL && self.apiPath) {
            self.intactURL = [NSString stringWithFormat:@"%@%@", self.baseURL, self.apiPath];
        }
        return self;
    };
}

- (BITRequestApi *(^)(RequestMethodType requestMethodType))setRequestMethodType
{
    return ^(RequestMethodType requestMethodType){
        self.requestMethodType = requestMethodType;
        return self;
    };
}
    
- (BITRequestApi *(^)(NSString *baseURL))setBaseURL
{
    return ^(NSString *baseURL){
        self.baseURL = baseURL;
        if (self.baseURL && self.apiPath) {
            self.intactURL = [NSString stringWithFormat:@"%@%@", self.baseURL, self.apiPath];
        }
        return self;
    };
}

- (BITRequestApi *(^)(id params))setParams
{
    return ^(id params){
        
        if([params isKindOfClass:[NSDictionary class]]){
            NSDictionary *dic = params;
            if (dic && dic.count > 0 ) {
                [self clearLastParamsData];
                [(NSMutableDictionary *)self.params addEntriesFromDictionary:dic];
            }
            else
            {
                [self clearLastParamsData];
            }
        }else if([params isKindOfClass:[NSArray class]]){
            NSArray *arr = params;
            
            if (arr && arr.count > 0 ) {
                [self clearLastParamsData];
//                [(NSMutableArray *)self.params addObjectsFromArray:arr];
                self.params = params;
            }
            else
            {
                [self clearLastParamsData];
            }
        }else{
            [self clearLastParamsData];
        }
        
        
        return self;
    };
}

-(void)clearLastParamsData
{
    
    if(self.params)
    {
        [self.params removeAllObjects];
    }
    else
    {
        self.params = [NSMutableDictionary dictionary];
    }
}

- (BITRequestApi *(^)(NSDictionary *))reSetParams
{
    return ^(NSDictionary *params){
        if (params && params.count > 0) {
            self.params = [NSMutableDictionary dictionaryWithDictionary:params];
        }
        return self;
    };
}

- (BITRequestApi *(^)(NSInteger timeoutInterval))setTimeoutInterval
{
    return ^(NSInteger timeoutInterval){
        self.timeoutInterval = timeoutInterval;
        return self;
    };
}
    
- (BITRequestApi *(^)(BOOL showHUD))setShowHUD
{
    return ^(BOOL showHUD){
        self.showHUD = showHUD;
        return self;
    };
}

- (BITRequestApi *(^)(BOOL showClearHUD))setShowClearHUD
{
    return ^(BOOL showClearHUD){
        self.showClearHUD = showClearHUD;
        return self;
    };
}

- (BITRequestApi *(^)(BOOL showFirstClearHUD))setShowFirstClearHUD
{
    return ^(BOOL showFirstClearHUD){
        self.showFirstClearHUD = showFirstClearHUD;
        self.showFirstHUD = NO;
        self.showHUD = NO;
        self.showClearHUD = NO;
        return self;
    };
}

- (BITRequestApi *(^)(BOOL showFirstHUD))setShowFirstHUD
{
    return ^(BOOL showFirstHUD){
        self.showFirstHUD = showFirstHUD;
        self.showFirstClearHUD = NO;
        self.showHUD = NO;
        self.showClearHUD = NO;
        return self;
    };
}

- (BITRequestApi *(^)(BOOL needCache))setNeedCache
{
    return ^(BOOL needCache){
        self.needCache = needCache;
        return self;
    };
}
- (BITRequestApi *(^)(BOOL needNotShowErrorMessage))setNeedNotShowErrorMessage
{
    return ^(BOOL needNotShowErrorMessage){
        self.needNotShowErrorMessage = needNotShowErrorMessage;
        return self;
    };
}

- (BITRequestApi *(^)(BOOL allowConcurrentExecution))setAllowConcurrentExecution
{
    return ^(BOOL allowConcurrentExecution){
        self.allowConcurrentExecution = allowConcurrentExecution;
        return self;
    };
}

@end
