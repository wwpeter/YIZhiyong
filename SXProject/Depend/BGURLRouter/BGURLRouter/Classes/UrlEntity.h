//
//  UrlEntity.h
//  Pods
//
//  Created by jiaguoshang on 18/9/30.
//
//

#import <Foundation/Foundation.h>

@interface UrlEntity : NSObject
/*
 * https://developer.apple.com/account/ios/certificate/?teamId=5E9JBA6XT3
 */

/**
 *  scheme  https
 */
@property (strong, nonatomic, readonly) NSString *scheme;

/**
 *  host
 */
@property (strong, nonatomic, readonly) NSString *host;

/**
 *  path
 */
@property (strong, nonatomic, readonly) NSString *path;

/**
 *  URL 中的参数列表
 */
@property (strong, nonatomic, readonly) NSDictionary *params;

/**
 *  URL String
 */
@property (strong, nonatomic, readonly) NSString *absoluteString;

/**
 *  从 URL 字符串创建 URLEntity
 *
 *  @param urlString url
 *
 *  @return 对应的 URLEntity
 */
+ (instancetype)URLWithString:(NSString * _Nonnull)urlString;


@end
