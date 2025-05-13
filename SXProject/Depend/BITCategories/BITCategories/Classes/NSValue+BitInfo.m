//
//  NSValue+BitInfo.m
//  Pods
//
//  Created        on 2017/12/17.
//
//

#import "NSValue+BitInfo.h"

@implementation NSValue (BitInfo)

+ (NSValue *)BitInfo_valueWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSValue *value = [NSValue valueWithBytes:&coordinate objCType:@encode(CLLocationCoordinate2D)];
    return value;
}

@end
