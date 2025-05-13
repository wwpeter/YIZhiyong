//
//  URLDefine.h
//  SXProject
//
//  Created by 王威 on 2024/4/18.
//

#ifndef URLDefine_h
#define URLDefine_h

/*
 AES Key：97uoohEb3LtlRQqS
 SHA256withRSA Key：MIIBVAIBADANBgkqhkiG9w0BAQEFAASCAT4wggE6AgEAAkEAx+cwxdinoQZQXZOJYwa9ILh/qFi3Q0L7YZBrF5c6O/7LswfgMUrAq/q/6l3qRAYMgjquyvleevZriMZi9X30jQIDAQABAkEAx7w+RVCmnQO8BOPHYER5cFooY0LRScmBdwhfmKCntQyq1aElYdS/+C2Z3potVQn5E1OFSzOQnIU6SlDr9qyNgQIhAOMc71O8V7YL2/XMuF/By3pP4vKsCzQC87KsizjZKZcRAiEA4VRErsE0/ryvPooAWbq5LsoTJQhWiqw35UQN2kXknb0CIFgB+mwEbCjLZ61Ua44P1v3KvzMyoBTDoBP48OpSnN9BAiBLkXJTVVKLmAYBqFCDxz5xta2D/u7fJPC9//vRVx1b1QIgb7jBYUP+YAlTVuhAgGsMlE7PPbdDOHI4QRlnTg4uiS0=
 */

/*
参数加密顺序
1、将参数转json后，使用AES加密，放入接口请求体body用于请求参数
2、接口签名sign，将AES加密后的内容再次使用SHA256withRSA进行签名
3、将SHA256withRSA签名后的内容放入请求头的hht-sign内*/

#define Lock()   dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
#define Unlock() dispatch_semaphore_signal(_semaphore)

#if BITRequestLoggingEnabled
#define LogDebug(s, ...) NSLog( @"%@:%d %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )//分别是文件名，在文件的第几行，自定义输出内容

#else
#define LogDebug(frmt, ...)     {}
#endif


#define kPageSize  @"10"

#define ENVIRONMENT 1 //  0－开发/1－正式

#if ENVIRONMENT == 0
/* ************************  开发服务器接口地址  *********************************** */

//#define HostDisUrl  [[NSUserDefaults standardUserDefaults] boolForKey:@"httpUrl"]
#define HostDisUrl  ENVIRONMENT

// 0测试|1生产环境
#define kBaseURL HostDisUrl? NSLocalizedString(@"https://www.yizhiyong.com.cn", @""):NSLocalizedString(@"https://www.yizhiyong.com.cn", @"")

//获取IP新接口
#define kBaseURLIP HostDisUrl? NSLocalizedString(@"https://map.haoyit.cn/api/ip/get", @""):NSLocalizedString(@"http://map-sit.haoyit.cn/api/ip/get", @"")

/*******************************************************************************************/

#elif ENVIRONMENT == 1

/* ************************  发布正式服务器接口地址  *********************************** */

#define kBaseURL @"https://yzy.yizhiyong.xin"
#define kBaseURLIP @"https://map.haoyit.cn/api/ip/get"

#endif

#define SX_AddDeviceStatus @"app/device/management/queryWifiConfigRecord"

#endif /* URLDefine_h */
