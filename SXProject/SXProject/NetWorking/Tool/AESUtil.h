//
//  AESUtil.h
//  haohuitui
//
//  Created by huihui on 2022/8/5.
//

#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
 
/**
 * AES工具类
 */
@interface AESUtil : NSObject
 
/**
 * AES加密
 */
+ (NSString *)aesEncrypt:(NSString *)sourceStr;
 
/**
 * AES解密
 */
+ (NSString *)aesDecrypt:(NSString *)secretStr;
 
@end


