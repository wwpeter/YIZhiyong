#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BITFDCategories.h"
#import "NSArray+BitInfo.h"
#import "NSData+BitInfo.h"
#import "NSDate+BitInfo.h"
#import "NSDictionary+BitInfo.h"
#import "NSMutableArray+BitInfo.h"
#import "NSMutableDictionary+BitInfo.h"
#import "NSString+BitInfo.h"
#import "NSTimer+BitInfo.h"
#import "NSValue+BitInfo.h"
#import "UIColor+BitInfo.h"
#import "UIDevice+BitInfo.h"
#import "UIView+BitInfo.h"

FOUNDATION_EXPORT double BITCategoriesVersionNumber;
FOUNDATION_EXPORT const unsigned char BITCategoriesVersionString[];

