//
//  NSData+ShouXin.h
//  SXBaseModule
//
//  Created by 王威 on 2024/1/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (ShouXin)

//加密
- (NSData *)lc_AES256Encrypt:(NSString *)key;

//解密
- (NSData *)lC_AES256Decrypt:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
