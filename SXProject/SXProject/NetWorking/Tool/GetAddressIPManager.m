//
//  GetAddressIPManager.m
//  haohuitui
//
//  Created by 王威 on 2024/4/18.
//

#import "GetAddressIPManager.h"
#import "RSAEncryptor.h"
#import "AESUtil.h"
#import "GaodeCityModel.h"
#import <MJExtension/MJExtension.h>
#import "URLDefine.h"
#import "BITMacro.h"

@implementation GetAddressIPManager

+ (instancetype)sharedInstance {
    static GetAddressIPManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)getMyIP {
    return  self.IP;
}
- (NSString *)getMyCity {
    return  self.city;
}

- (NSInteger)getMyCityCode {
    return self.cityCode;
}

- (NSString *)dealBody:(NSString *)time {
    NSString *aesEncrypt = [AESUtil aesEncrypt:time];
    
    return  aesEncrypt;
}

- (NSString *)getTime {
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval timestampInSeconds = round(timestamp);

    NSString *timestampString = [NSString stringWithFormat:@"%ld", (long)timestampInSeconds];
    //aes
    NSDictionary *bodyString = @{@"sx_timestamp":timestampString};
  
    NSString *jsonData = [bodyString mj_JSONString];
    
    return jsonData;
}
- (void)getAddressIp {
    
#pragma - wangwei
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",kBaseURLIP]];

    // 2.创建网络请求
//    NSURLRequest *requestGet =[NSURLRequest requestWithURL:url];
    NSMutableURLRequest *requestPost = [NSMutableURLRequest requestWithURL:url];
    [requestPost setHTTPMethod:@"POST"];
    
    //公用时间戳

    NSString *jsonStr = [self getTime];
   
    //时间戳加密数据 aes
    NSString *bodyString = [self dealBody:jsonStr];
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
    [requestPost setHTTPBody:bodyData];

    //sha1 with rsa
    NSString *signStr = [RSAEncryptor sign:jsonStr withPriKey:PrivateKey];
    if (signStr == nil) {
        signStr = @"";
    }
    [requestPost setValue:signStr forHTTPHeaderField:@"sx-sign-v"];
    [requestPost setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
   
    // 3.获取会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 4.根据会话对象，创建Task任务
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:requestPost completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            return;
        }
        NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSString * tempStr = [AESUtil aesDecrypt:result];
        NSData *tempData = [tempStr dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",tempStr);
        
        //Json解析
        if (tempData != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:tempData options:NSJSONReadingMutableContainers error:nil];
            GaodeCityModel *model = [GaodeCityModel mj_objectWithKeyValues:dic[@"data"]];
            NSString *ip = [NSString stringWithFormat:@"%@", model.ip];
           
            self.IP = ip;
            self.city = [NSString stringWithFormat:@"%@", model.city];
            self.cityCode = [model.cityCode integerValue];
        }
    }];
    // 5.执行任务
    [sessionDataTask resume];
}
@end
