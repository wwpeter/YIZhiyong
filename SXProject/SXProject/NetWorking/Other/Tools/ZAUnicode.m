//
//  ZAUnicode.m
//  haohuitui
//
//  Created by huihui on 2022/5/11.
//
#import "ZAUnicode.h"
#import <objc/runtime.h>

static inline void zxp_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSString (ZAUnicode)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (ZAUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        zxp_swizzleSelector(class, @selector(description), @selector(zxp_description));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zxp_descriptionWithLocale:));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zxp_descriptionWithLocale:indent:));
    });
}

/**
 *  我觉得
 *  可以把以下的方法放到一个NSObject的category中
 *  然后在需要的类中进行swizzle
 *  但是又觉得这样太粗暴了。。。。
 */

- (NSString *)zxp_description {
    return [[self zxp_description] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale {
    return [[self zxp_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zxp_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (ZAUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        zxp_swizzleSelector(class, @selector(description), @selector(zxp_description));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zxp_descriptionWithLocale:));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zxp_descriptionWithLocale:indent:));
    });
}

- (NSString *)zxp_description {
    return [[self zxp_description] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale {
    return [[self zxp_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zxp_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (ZAUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        zxp_swizzleSelector(class, @selector(description), @selector(zxp_description));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(zxp_descriptionWithLocale:));
        zxp_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(zxp_descriptionWithLocale:indent:));
    });
}

- (NSString *)zxp_description {
    return [[self zxp_description] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale {
    return [[self zxp_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)zxp_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self zxp_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end
