//
//  NSString+swift.h
//  LCDeviceAddModule
//
//  Created by hehe on 2021/5/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (swift)
+ (NSString *)getGatewayIpForCurrentWiFi;
+ (NSString *)getCurreWiFiSsid;
@end

NS_ASSUME_NONNULL_END
