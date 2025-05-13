//
//  NSString+SXin.h
//  SXBaseModule
//
//  Created by 王威 on 2024/1/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SXin)
/**
 国际化字符串
 */
@property(nonatomic, copy, nonnull, readonly) NSString *sx_T;

+ (NSString *_Nonnull)isoLocalizeLanguageString;

/**
 解密SK SK原始加密值
 @return 解密后的值
 */
- (NSString *_Nullable)dh_decryptSK;
/**
给字符串拼接URL参数
@return 拼接后的url
*/
- (NSString *)dh_urlAppendParmDic:(NSDictionary<NSString *,NSString *> *)dic;

/**
判断字符串是否为空
@return 是否为空
*/
+ (BOOL)isEmpty:(NSString *)str;


/// 字符串所占字节长度
- (NSUInteger)charactorNumber;
@end

NS_ASSUME_NONNULL_END
