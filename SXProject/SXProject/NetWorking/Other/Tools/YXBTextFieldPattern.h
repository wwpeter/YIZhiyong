//
//  YXBTextFieldPattern.h
//  haohuitui
//
//  Created by huihui on 2022/4/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXBTextFieldPattern : NSObject
+ (BOOL)isInputRuleAndNumber:(NSString *)str;
+(BOOL)hasEmoji:(NSString*)str;
@end
NS_ASSUME_NONNULL_END
