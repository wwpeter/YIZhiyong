//
//  GetAddressIPManager.h
//  haohuitui
//
//  Created by 王威 on 2024/4/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetAddressIPManager : NSObject

+ (instancetype)sharedInstance;
//后台返回IP 地址
@property (nonatomic, copy) NSString *IP;
/// 城市
@property (nonatomic, copy) NSString *city;
/// 城市code
@property (nonatomic, assign) NSInteger cityCode;
//获取IP
- (NSString *)getMyIP;
//获取城市
- (NSString *)getMyCity;
//获取code
- (NSInteger)getMyCityCode;
//获取定位信息
- (void)getAddressIp;


@end

NS_ASSUME_NONNULL_END
