//
//  NSArray+BitInfo.h
//  Pods
//
//  Created        on 2017/7/21.
//
//

#import <Foundation/Foundation.h>

@interface NSArray (BitInfo)

- (id)objectAtSafeIndex:(NSUInteger)index;

- (NSString*)jsonString;

/**
 Returns the object located at a random index.
 
 @return The object in the array with a random index value.
 If the array is empty, returns nil.
 */
- (nullable id)bitrandomObject;

/**
 Returns the object located at index, or return nil when out of bounds.
 It's similar to `objectAtIndex:`, but it never throw exception.
 
 @param index The object located at index.
 */
- (nullable id)bitobjectOrNilAtIndex:(NSUInteger)index;
@end
