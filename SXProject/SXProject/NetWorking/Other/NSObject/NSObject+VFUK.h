//
//  NSObject+VFUK.h
//  haohuitui
//
//  Created by huihui on 2022/6/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (VFUK)
///自定义valueForUndefinedKey:实现
+ (void)addCustomValueForUndefinedKeyImplementation:(IMP)handler;
@end

NS_ASSUME_NONNULL_END
