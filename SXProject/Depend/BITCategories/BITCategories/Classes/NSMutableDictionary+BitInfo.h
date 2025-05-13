//
//  NSMutableDictionary+BitInfo.h
//  Pods
//
//  Created        on 2017/7/21.
//
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (BitInfo)

- (void)setSafeObject:(id)anObject forKey:(id<NSCopying>)aKey;
- (id)bitpopObjectForKey:(id)aKey;
- (NSDictionary *)bitpopEntriesForKeys:(NSArray *)keys;
@end
