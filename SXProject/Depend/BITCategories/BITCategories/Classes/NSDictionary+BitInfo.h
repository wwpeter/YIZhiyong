//
//  NSDictionary+BitInfo.h
//  Pods
//
//  Created        on 2017/7/21.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BitInfo)


- (id)safeObjectForKey:(NSString *)aKey;

- (NSString *)jsonString;

- (BOOL)containKey:(NSString *)key;

- (NSDictionary *)deepCopy;
- (NSDictionary *)bitentriesForKeys:(NSArray *)keys;
- (NSString *)bitjsonStringEncoded;
- (NSString *)bitjsonPrettyStringEncoded;
@end
