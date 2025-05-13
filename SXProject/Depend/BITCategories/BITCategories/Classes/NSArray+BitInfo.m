//
//  NSArray+BitInfo.m
//  Pods
//
//  Created        on 2017/7/21.
//
//

#import "NSArray+BitInfo.h"

@implementation NSArray (BitInfo)


- (id)objectAtSafeIndex:(NSUInteger)index
{
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

- (NSString *)jsonString
{
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0
                                                         error:&error];
    
    if (error) {
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (id)bitrandomObject {
    if (self.count) {
        return self[arc4random_uniform((u_int32_t)self.count)];
    }
    return nil;
}

- (id)bitobjectOrNilAtIndex:(NSUInteger)index {
    return index < self.count ? self[index] : nil;
}
@end
