//
//  NSMutableDictionary+BitInfo.m
//  Pods
//
//  Created        on 2017/7/21.
//
//

#import "NSMutableDictionary+BitInfo.h"

@implementation NSMutableDictionary (BitInfo)


- (void)setSafeObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject && aKey) {
        [self setObject:anObject forKey:aKey];
    }
}

- (id)bitpopObjectForKey:(id)aKey {
    if (!aKey) return nil;
    id value = self[aKey];
    [self removeObjectForKey:aKey];
    return value;
}

- (NSDictionary *)bitpopEntriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) {
            [self removeObjectForKey:key];
            dic[key] = value;
        }
    }
    return dic;
}
@end
