//
//  NSString+swift.m
//  LCDeviceAddModule
//
//  Created by hehe on 2021/5/13.
//

#import "NSString+swift.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "getgateway.h"


@implementation NSString (swift)


+ (NSString *)getGatewayIpForCurrentWiFi {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                    //routerIP----192.168.1.255 广播地址
                    NSLog(@"广播地址：%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)]);
                    
                    //--192.168.1.106 本机地址
                    NSLog(@"本机地址：%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)]);
                    
                    //--255.255.255.0 子网掩码地址
                    NSLog(@"子网掩码地址：%@",[NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)]);
                    
                    //--en0 接口
                    //  en0       Ethernet II    protocal interface
                    //  et0       802.3             protocal interface
                    //  ent0      Hardware device interface
                    NSLog(@"接口名：%@",[NSString stringWithUTF8String:temp_addr->ifa_name]);
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    in_addr_t i = inet_addr([address cStringUsingEncoding:NSUTF8StringEncoding]);
    in_addr_t* x = &i;
    unsigned char *s = getdefaultgateway(x);
    NSString *ip=[NSString stringWithFormat:@"%d.%d.%d.%d",s[0],s[1],s[2],s[3]];
    free(s);
    
    NSString *newIp = @"";
    // 如果获取到的路由器 ip 跟本机地址 address不在同一网段，需要处理ip地址（解决从蜂窝网络，首次连接上wifi时获取到的ip有可能不对的问题）
    int index = 0;
    NSArray *addressArray = [address componentsSeparatedByString:@"."];
    NSArray *IPArray = [ip componentsSeparatedByString:@"."];
    if (addressArray.count == IPArray.count) {
        for (int i = 0; i < 4; i++) {
            if (i != 3) {
                if (addressArray[i] == IPArray[i]) {
                    newIp = [newIp stringByAppendingString:[NSString stringWithFormat:@"%@.", IPArray[i]]];
                } else {
                    newIp = [newIp stringByAppendingString:[NSString stringWithFormat:@"%@.", addressArray[i]]];
                }
            } else {
                newIp = [newIp stringByAppendingString:@"1"];
            }
        }
        return newIp;
    }
    
    return ip;
}

+ (NSString *)getCurreWiFiSsid {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    NSLog(@"Supported interfaces: %@", ifs);
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"%@ => %@", ifnam, info);
        if (info && [info count]) { break; }
    }
    return [(NSDictionary*)info objectForKey:@"SSID"];
}
@end
