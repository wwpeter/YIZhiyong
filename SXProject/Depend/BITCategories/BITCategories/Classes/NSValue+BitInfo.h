//
//  NSValue+BitInfo.h
//  Pods
//
//  Created        on 2017/12/17.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface NSValue (BitInfo)

+ (NSValue *)BitInfo_valueWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
