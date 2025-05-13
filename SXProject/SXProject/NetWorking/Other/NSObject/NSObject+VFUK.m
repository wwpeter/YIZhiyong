//
//  NSObject+VFUK.m
//  haohuitui
//
//  Created by huihui on 2022/6/6.
//

#import "NSObject+VFUK.h"
#import <CoreData/CoreData.h>
#import <objc/message.h>
@implementation NSObject (VFUK)
+ (void)addCustomValueForUndefinedKeyImplementation:(IMP)handler{
Class clazz = self;
if (clazz == nil) {
    return;
}
if (clazz == [NSObject class] || clazz == [NSManagedObject class])
{
    return;
}

SEL vfuk = @selector(valueForUndefinedKey:);
SEL svfuk = @selector(setValue:forUndefinedKey:);

@synchronized([NSObject class]){
    Method nsoMethod = class_getInstanceMethod([NSObject class], vfuk);
    Method nsmoMethod = class_getInstanceMethod([NSManagedObject class], vfuk);
    Method origMethod = class_getInstanceMethod(clazz, vfuk);
    
    Method set_nsoMethod = class_getInstanceMethod([NSObject class], svfuk);
    Method set_nsmoMethod = class_getInstanceMethod([NSManagedObject class], svfuk);
    Method set_origMethod = class_getInstanceMethod(clazz, svfuk);
    
    
    if (set_origMethod != set_nsoMethod && set_origMethod != set_nsmoMethod) {
        return;
    }
    if (origMethod != nsoMethod && origMethod != nsmoMethod) {
        return;
    }
    
    if(!class_addMethod(clazz, svfuk, handler, method_getTypeEncoding(set_nsmoMethod))) {
    }
    
    if(!class_addMethod(clazz, vfuk, handler, method_getTypeEncoding(nsoMethod))) {
    }
}

}

@end
