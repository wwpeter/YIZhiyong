//
//  NSData+BitInfo.h
//  Pods
//
//  Created        on 2017/7/21.
//
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSData (BitInfo)

/**
 Returns a lowercase NSString for md5 hash.
 */
- (NSString *)bitmd5String;
@end

NS_ASSUME_NONNULL_END
