//
//  BITCacheCenter.h
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

#import <Foundation/Foundation.h>

typedef void (^CacheCallback)();

typedef void (^CacheObjectCallback)(NSString *key, id object);
@interface BITCacheCenter : NSObject
    
+ (instancetype)sharedInstance;
    
// 同步方法
    
- (id)objectForKey:(NSString *)key withParams:(NSDictionary *)params;
    
- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key withParams:(NSDictionary *)params;
    
- (void)removeObjectForKey:(NSString *)key withParams:(NSDictionary *)params;;
    
- (void)clearCache;
    
// 异步方法
    
- (void)objectForKey:(NSString *)key withParams:(NSDictionary *)params withCallback:(CacheObjectCallback)cb;
    
- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key withParams:(NSDictionary *)params withCallback:(CacheObjectCallback)cb;
    
- (void)removeObjectForKey:(NSString *)key withParams:(NSDictionary *)params withCallback:(CacheObjectCallback)cb;
    
- (void)clearCache:(CacheCallback)cb;


@end
