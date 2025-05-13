//
//  BITCacheCenter.m
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

#import "BITCacheCenter.h"
#import <BITCategories/NSString+BitInfo.h>
#import "BITCache.h"

// 设置缓存时间为30天
static const NSInteger YXCacheDuration = 30*24*60*60;

static NSString * const BITCacheCenterDirectory = @"BITCacheCenterDirectory";

@interface BITCacheCenter ()
    
@property (nonatomic, strong) BITCache *cache;

@end

@implementation BITCacheCenter

+ (instancetype)sharedInstance
    {
        static BITCacheCenter *instance;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [[self alloc] init];
        });
        return instance;
    }
    
- (instancetype)init
    {
        if (self = [super init]) {
            _cache = [[BITCache alloc] initWithName:BITCacheCenterDirectory];
            [_cache trimToDate:[[NSDate date] dateByAddingTimeInterval:-YXCacheDuration] block:
             ^(BITCache *cache) {
                 
             }];
        }
        return self;
    }
    
- (id)objectForKey:(NSString *)key withParams:(NSDictionary *)params
    {
        assert(_cache);
        assert(key);
        NSString *urlMd5Key = [[NSString combineURLWithBaseURL:key parameters:params] bitinfo_md5hashString];
        id result = [_cache objectForKey:urlMd5Key];
        return result;
    }
    
- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key withParams:(NSDictionary *)params
    {
        assert(_cache);
        assert(object);
        assert(key);
        NSString *urlMd5Key = [[NSString combineURLWithBaseURL:key parameters:params] bitinfo_md5hashString];
        return [_cache setObject:object forKey:urlMd5Key];
    }
    
- (void)removeObjectForKey:(NSString *)key withParams:(NSDictionary *)params
    {
        assert(_cache);
        assert(key);
        NSString *urlMd5Key = [[NSString combineURLWithBaseURL:key parameters:params] bitinfo_md5hashString];
        [_cache removeObjectForKey:urlMd5Key];
    }
    
- (void)clearCache
    {
        assert(_cache);
        [_cache removeAllObjects];
    }
    
- (void)objectForKey:(NSString *)key withParams:(NSDictionary *)params withCallback:(CacheObjectCallback)cb
    {
        assert(_cache);
        assert(key);
        NSString *urlMd5Key = [[NSString combineURLWithBaseURL:key parameters:params] bitinfo_md5hashString];
        [_cache objectForKey:urlMd5Key block:^(BITCache *cache, NSString *key, id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cb) {
                    cb(key, object);
                }
            });
        }];
    }
    
- (void)setObject:(id <NSCoding>)object forKey:(NSString *)key withParams:(NSDictionary *)params withCallback:(CacheObjectCallback)cb
    {
        assert(_cache);
        assert(key);
        assert(object);
        NSString *urlMd5Key = [[NSString combineURLWithBaseURL:key parameters:params] bitinfo_md5hashString];
        [_cache setObject:object forKey:urlMd5Key block:^(BITCache *cache, NSString *key, id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cb) {
                    cb(key, object);
                }
            });
        }];
    }
    
- (void)removeObjectForKey:(NSString *)key withParams:(NSDictionary *)params withCallback:(CacheObjectCallback)cb
    {
        assert(_cache);
        NSString *urlMd5Key = [[NSString combineURLWithBaseURL:key parameters:params] bitinfo_md5hashString];
        [_cache removeObjectForKey:urlMd5Key block:^(BITCache *cache, NSString *key, id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cb) {
                    cb(key, object);
                }
            });
        }];
    }
    
- (void)clearCache:(CacheCallback)cb
    {
        assert(_cache);
        [_cache removeAllObjects:^(BITCache *cache) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (cb) {
                    cb();
                }
            });
        }];
    }

@end
