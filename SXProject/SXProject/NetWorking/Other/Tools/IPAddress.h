//
//  IPAddress.h
//  haohuitui
//
//  Created by huihui on 2022/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IPAddress : NSObject
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
@end

NS_ASSUME_NONNULL_END
