//
//  BITMobilePassword.h
//  YXB
//
//  Created by huihui on 2022/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BITMobilePassword : NSObject
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber;
#pragma 正则匹配数字
+ (BOOL)checkNumber:(NSString *) number;

+(BOOL)isValidateMobile:(NSString *)mobile;

+(BOOL)isValidatePassword:(NSString *)password;

+(BOOL)isValidateVerificationCode:(NSString *)verificationCode;

+(NSString *)checkValidateMobile:(NSString *)mobile;

+(NSString *)checkValidatePassword:(NSString *)password;

+(NSString *)checkValidateVerificationCode:(NSString *)verificationCode;

+(NSString *)formatMobile:(NSString *)mobile;

#pragma mark - store Phone
//设置手机号，该手机号不依赖于清空用户信息而消失
+ (void)storePhone:(id)value key:(NSString *)key;
//获取手机号，该手机号不依赖于清空用户信息而消失，不用get为了防止和系统函数类似
+ (NSString *)fetchPhone:(NSString *)key;

+ (void)setUserDefaultsValue:(id)value key:(NSString *)key;
+ (NSString *)valueForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
