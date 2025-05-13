//
//  GetDeviceStateApi.m
//  SXProject
//
//  Created by 王威 on 2024/4/22.
//

#import "AddDeviceApi.h"
#import "RequestSetAPI.h"

@interface AddDeviceApi()
///设备添加成功之后的状态
@property (nonatomic, strong) BITRequestApi *stateApi;
@property (nonatomic, strong) NSDictionary *param;

@end

@implementation AddDeviceApi

- (BITRequestApi *)stateApi
{
    if (!_stateApi) {
        _stateApi = [[BITRequestApi alloc] init];
        _stateApi.setBaseURL(kBaseURL)
            .setApiPath(SX_AddDeviceStatus)
            .setShowHUD(NO)
            .setRequestMethodType(YX_Request_POST)
            .setNeedNotShowErrorMessage(NO)
            .setParams(_param);
    
    }
    return _stateApi;
}

- (void)setParam:(NSDictionary *)param {
    _param = nil;
    _param = param;
}

- (void)requestStateNetWorking {
    SX(weakSelf);
    [[BITRequestClient sharedClient] loadDataWithApi:self.stateApi successBlock:^(NSString *result) {
        typeof(self) strongSelf = weakSelf;
        if (strongSelf.resultBlock) {
            strongSelf.resultBlock(result);
        }
    } failureBlock:^(NSError *error) {
        
    }];
}
@end
