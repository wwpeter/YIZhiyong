//
//  NetworkRequestManager.h
//  SXProject
//
//  Created by 王威 on 2024/4/22.
//

#import "BaseApi.h"
#import "BITRequestApi.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SuccessBlockT)(NSString * result);

typedef void(^FailureBlock)(NSError * _Nullable error);

@interface NetworkRequestManager : BaseApi
//OC 网络请求单利 综合
+ (instancetype)sharedInstance;

//终极封装 外层直接调用 这里进行处理
- (void)requestPath:(NSString *)netPath withParam:(NSDictionary *)param Success:(SuccessBlockT)success
            Failure:(FailureBlock)failure;
//上传data 弃游
- (void)uploadDataPath:(NSString *)netPath withData:(NSData *)imageData Success:(SuccessBlockT)success
               Failure:(FailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
