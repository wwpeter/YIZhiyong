//
//  BITBaseRequestApi.m
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

#import "BITBaseRequestApi.h"

@implementation BITBaseRequestApi

- (BITRequestSerializerType)requestSerializerType {
    return BITRequestSerializerTypeHTTP;
}
    
- (YXResponseSerializerType)responseSerializerType {
    return YXResponseSerializerTypeJSON;
}

@end
