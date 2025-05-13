//
//  AESUtilNew.h
//  haohuitui
//
//  Created by 王威 on 2024/4/12.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * AES工具类
 */
@interface AESUtilNew : NSObject

/**
 * AES加密
 */
+ (NSString *)aesEncrypt:(NSString *)sourceStr;
 
/**
 * AES解密
 */
+ (NSString *)aesDecrypt:(NSString *)secretStr;
 

@end

NS_ASSUME_NONNULL_END
