//
//  GetDeviceStateApi.h
//  SXProject
//
//  Created by 王威 on 2024/4/22.
//

#import "BaseApi.h"
#import "BITRequestApi.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ResultBlock)(NSString *jsonStr);

@interface AddDeviceApi : BaseApi

//设置参数
- (void)setParam:(NSDictionary *)param;
///调用网络请求
- (void)requestStateNetWorking;
@property (nonatomic, copy) ResultBlock resultBlock;

@end

NS_ASSUME_NONNULL_END
