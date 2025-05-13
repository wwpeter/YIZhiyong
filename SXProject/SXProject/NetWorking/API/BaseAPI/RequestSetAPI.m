//
//  RequestSetAPI.m
//  SXProject
//
//  Created by 王威 on 2024/4/23.
//

#import "RequestSetAPI.h"

@interface RequestSetAPI()

@property (nonatomic, strong) NSDictionary *param;
///设备添加成功之后的状态
@property (nonatomic, strong) BITRequestApi *stateApi;

@property (nonatomic, copy) NSString *pathAPI;

@end
@implementation RequestSetAPI

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

//获取网络请求api
- (BITRequestApi *)getRequesApi:(NSString *)apiPath {
    if (isEmptyString(apiPath)) {
        return self.stateApi;
    } else {
        self.stateApi.setApiPath(apiPath);
        
        return self.stateApi;
    }
}

- (void)setParam:(NSDictionary *)param {
    _param = nil;
    _param = param;
}

@end
