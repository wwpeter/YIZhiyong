//
//  RequestSetAPI.h
//  SXProject
//
//  Created by 王威 on 2024/4/23.
//
//请求的总集合 

#import "BaseApi.h"

NS_ASSUME_NONNULL_BEGIN

@interface RequestSetAPI : BaseApi

//设置参数
- (void)setParam:(NSDictionary *)param;

//获取网络请求api
- (BITRequestApi *)getRequesApi:(NSString *)apiPath;

@end

NS_ASSUME_NONNULL_END
