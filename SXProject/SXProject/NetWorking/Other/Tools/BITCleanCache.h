//
//  BITCleanCache.h
//  YXB
//
//  Created by huihui on 2022/3/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^cleanCacheBlock)();
@interface BITCleanCache : NSObject
/**
 *  清理缓存
 */
+(void)cleanCache:(cleanCacheBlock)block;

/**
 *  整个缓存目录的大小
 */
+(float)folderSizeAtPath;
@end

NS_ASSUME_NONNULL_END
