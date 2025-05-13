//
//  YXBTextFieldPattern.m
//  haohuitui
//
//  Created by huihui on 2022/4/20.
//
#import "YXBTextFieldPattern.h"

@implementation YXBTextFieldPattern
#pragma mark - 谓词条件限制
/**
 pattern中,输入需要验证的通过的字符
 小写a-z
 大写A-Z
 汉字\u4E00-\u9FA5
 数字\u0030-\u0039
 @param str 要过滤的字符
 @return YES 只允许输入字母和汉字、数字
 */
+ (BOOL)isInputRuleAndNumber:(NSString *)str {
    NSString *pattern = @"[a-zA-Z\u4E00-\u9FA5\\u0030-\\u0039]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
+(BOOL)hasEmoji:(NSString*)str{
 NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
 NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
 BOOL isMatch = [pred evaluateWithObject:str];
 return isMatch;
}
@end
