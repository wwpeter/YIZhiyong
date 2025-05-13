//
//  NSMutableArray+BitInfo.m
//  Pods
//
//  Created        on 2017/7/21.
//
//

#import "NSMutableArray+BitInfo.h"

@implementation NSMutableArray (BitInfo)


- (void)addSafeObject:(id)anObject
{
    if (anObject) {
        [self addObject:anObject];
    }
}

- (void)insertSafeObject:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject) {
        [self insertObject:anObject atIndex:index];
    }
}

- (void)addObjectsFromSafeArray:(NSArray *)otherArray
{
    if (otherArray && otherArray.count > 0) {
        [self addObjectsFromArray:otherArray];
    }
}

- (void)removeSafeObjectAtIndex:(NSUInteger)index
{
    if ((self.count > 0) && (self.count > index))
    {
        [self removeObjectAtIndex:index];
    }
}

- (void)bitremoveFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (id)bitpopFirstObject {
    id obj = nil;
    if (self.count) {
        obj = self.firstObject;
        [self bitremoveFirstObject];
    }
    return obj;
}

- (id)bitpopLastObject {
    id obj = nil;
    if (self.count) {
        obj = self.lastObject;
        [self removeLastObject];
    }
    return obj;
}

- (void)bitappendObject:(id)anObject {
    [self addObject:anObject];
}

- (void)bitprependObject:(id)anObject {
    [self insertObject:anObject atIndex:0];
}

- (void)bitappendObjects:(NSArray *)objects {
    if (!objects) return;
    [self addObjectsFromArray:objects];
}

- (void)bitprependObjects:(NSArray *)objects {
    if (!objects) return;
    NSUInteger i = 0;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)bitinsertObjects:(NSArray *)objects atIndex:(NSUInteger)index {
    NSUInteger i = index;
    for (id obj in objects) {
        [self insertObject:obj atIndex:i++];
    }
}

- (void)bitreverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

- (void)shuffle {
    for (NSUInteger i = self.count; i > 1; i--) {
        [self exchangeObjectAtIndex:(i - 1)
                  withObjectAtIndex:arc4random_uniform((u_int32_t)i)];
    }
}
@end
