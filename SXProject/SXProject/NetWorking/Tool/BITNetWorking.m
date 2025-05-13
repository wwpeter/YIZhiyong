//
//  BITNetWorking.m
//  YXB
//
//  Created by huihui on 2022/4/1.
//

#import "BITNetWorking.h"
#import "BITSingleObject.h"

@implementation BITNetWorking
+(BOOL)isNetWorking{
    return ([BITSingleObject sharedInstance].networkStatus==0);
}

@end
