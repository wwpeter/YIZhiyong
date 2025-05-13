//
//  BITBaseRequestApi.h
//  Pods
//
//  Created by jiaguoshang on 2017/10/31.
//
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RequestMethodType){
    YX_Request_GET,
    YX_Request_POST,
    YX_Request_PUT,
    YX_Request_DELETE,
    YX_Request_HEAD,
    YX_Request_PATCH
};

typedef NS_ENUM(NSInteger, BITRequestSerializerType) {
    BITRequestSerializerTypeHTTP,
    BITRequestSerializerTypeJSON
};

typedef NS_ENUM(NSInteger, YXResponseSerializerType) {
    YXResponseSerializerTypeHTTP,
    YXResponseSerializerTypeJSON
};

@interface BITBaseRequestApi : NSObject

/**
 唯一标识符
 */
@property (nonatomic, copy)              NSString *uniqueIdentify;

/**
 sessionTask
 */
@property (nonatomic, strong, readwrite) NSURLSessionTask *requestTask;

- (BITRequestSerializerType)requestSerializerType;
    
- (YXResponseSerializerType)responseSerializerType;
    
@end
