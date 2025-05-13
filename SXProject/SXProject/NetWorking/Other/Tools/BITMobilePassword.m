//
//  BITMobilePassword.m
//  YXB
//
//  Created by huihui on 2022/3/30.
//

#import "BITMobilePassword.h"

#define VERIFICATION_CODE_MIN_LENGTH 4
#define VERIFICATION_CODE_MAX_LENGTH 10

#define PASSWORD_MIN_LENGTH 4
#define PASSWORD_MAX_LENGTH 128
@interface BITMobilePassword ()

@end
@implementation BITMobilePassword
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    if((telNumber != nil) && ([telNumber isKindOfClass:[NSString class]]) && [telNumber isEqualToString:@"12345678901"])
    {
        return YES;
    }
    NSString *pattern = @"^1+[3456789]+\\d{9}";
    BOOL isMatch = [self isValidateRegularExpression:telNumber byExpression:pattern];
    return isMatch;
}

#pragma 正则匹配数字
+ (BOOL)checkNumber:(NSString *) number
{
    NSString *pattern = @"^[0-9]+$";
    BOOL isMatch = [self isValidateRegularExpression:number byExpression:pattern];
    return isMatch;
}

#pragma 是否是有效的正则表达式

+ (BOOL)isValidateRegularExpression:(NSString *)strDestination byExpression:(NSString *)strExpression

{
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strExpression];
    
    return [predicate evaluateWithObject:strDestination];
    
}

+(BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *mobileStr = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *phoneRegex = @"^[1][3,4,5,7,8][0-9]{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobileStr];
}

+(BOOL)isValidatePassword:(NSString *)password
{
    NSString *passwordStr = [password stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(passwordStr.length < PASSWORD_MIN_LENGTH)
    {
        return NO;
    }
    else if(passwordStr.length > PASSWORD_MAX_LENGTH)
    {
        return NO;
    }
    
    NSString *regex = @"[^\\s]{6,}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:password]) {
        return NO;
    }
    return YES;
}

+(BOOL)isValidateVerificationCode:(NSString *)verificationCode
{
    NSString *verificationCodeStr = [verificationCode stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(verificationCodeStr.length < VERIFICATION_CODE_MIN_LENGTH)
    {
        return NO;
    }
    else if(verificationCodeStr.length > VERIFICATION_CODE_MAX_LENGTH)
    {
        return NO;
    }
    
    NSString *regex = @"[^\\s]{4,}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:verificationCode]) {
        return NO;
    }
    return YES;
}

+(NSString *)checkValidateMobile:(NSString *)mobile
{
    NSString *mobileStr = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(mobileStr.length == 0)
    {
        return @"手机号码为空，请输入手机号";
    }
    NSString *phoneRegex = @"^[1][3,4,5,7,8][0-9]{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    if(![phoneTest evaluateWithObject:mobileStr])
    {
        return @"手机号码格式错误，请输入正确的手机号";
    }
    else
    {
        return nil;
    }
}

+(NSString *)formatMobile:(NSString *)mobile
{
    NSString *mobileStr = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if((mobileStr == nil) || (![mobileStr isKindOfClass:[NSString class]]))
    {
        return @"";
    }
    if(mobileStr.length != 11)
    {
        return @"";
    }
    
    NSString *frontStr = [mobileStr substringToIndex:3];
    NSRange range = NSMakeRange(3, 4);
    NSString *midStr = [mobileStr substringWithRange:range];
    NSString *afterStr = [mobileStr substringFromIndex:7];
    return [NSString stringWithFormat:@"%@ %@ %@", frontStr,midStr,afterStr];
}

+(NSString *)checkValidatePassword:(NSString *)password
{
    NSString *passwordStr = [password stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(passwordStr.length == 0)
    {
        return @"密码为空，请输入密码";
    }
    else if(passwordStr.length < PASSWORD_MIN_LENGTH)
    {
        return [NSString stringWithFormat:@"密码不能少于%d位，请重新输入密码", PASSWORD_MIN_LENGTH] ;
    }
    else if(passwordStr.length > PASSWORD_MAX_LENGTH)
    {
        return @"密码超过最大限制长度，请重新输入密码";
    }
    
    NSString *regex = @"[^\\s]{4,}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:password]) {
        return nil;
    }
    return nil;
}

+(NSString *)checkValidateVerificationCode:(NSString *)verificationCode
{
    NSString *verificationCodeStr = [verificationCode stringByReplacingOccurrencesOfString:@" " withString:@""];
    if(verificationCodeStr.length == 0)
    {
        return @"验证码为空,请输入验证码";
    }
    else if(verificationCodeStr.length < VERIFICATION_CODE_MIN_LENGTH)
    {
        return @"验证码长度不正确，请输入正确的验证码";
    }
    else if(verificationCodeStr.length > VERIFICATION_CODE_MAX_LENGTH)
    {
        return @"验证码长度不正确，请输入正确的验证码";
    }
    
    NSString *regex = @"[^\\s]{4,}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if (![pred evaluateWithObject:verificationCode]) {
        return nil;
    }
    return nil;
}

#pragma mark - store Phone
//设置手机号，该手机号不依赖于清空用户信息而消失
+ (void)storePhone:(id)value key:(NSString *)key
{
    if(key.length == 0)
    {
        return;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
//获取手机号，该手机号不依赖于清空用户信息而消失，不用get为了防止和系统函数类似
+ (NSString *)fetchPhone:(NSString *)key
{
    if(key.length == 0)
    {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)setUserDefaultsValue:(id)value key:(NSString *)key
{
    if(key.length == 0)
    {
        return;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *)valueForKey:(NSString *)key
{
    if(key.length == 0)
    {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
@end
