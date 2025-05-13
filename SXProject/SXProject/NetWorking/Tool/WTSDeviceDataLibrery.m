//
//  WTSDeviceDataLibrery.m
//  WaiLianWK
//
//  Created by WangYangyang on 2018/7/10.
//  Copyright © 2018年 com.91wailian. All rights reserved.
//

#import "WTSDeviceDataLibrery.h"
#import "sys/utsname.h"
#import "BITCommonMacro.h"


@implementation WTSDeviceDataLibrery

+ (const NSString *)getDeviceName {
    WTSDiviceType type = [WTSDeviceDataLibrery getDeviceType];
    return iDeviceNameContainer[type];
}
+ (const NSString *)getLatestFirmware {
    WTSDiviceType type = [WTSDeviceDataLibrery getDeviceType];
    return latestFirmwareContainer[type];
}

#pragma mark - Private Method
+ (WTSDiviceType)getDeviceType{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *machineString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    if ([machineString isEqualToString:@"iPhone1,1"])   return iPhone_1G;
    if ([machineString isEqualToString:@"iPhone1,2"])   return iPhone_3G;
    if ([machineString isEqualToString:@"iPhone2,1"])   return iPhone_3GS;
    if ([machineString isEqualToString:@"iPhone3,1"])   return iPhone_4;
    if ([machineString isEqualToString:@"iPhone3,3"])   return iPhone_4_Verizon;
    if ([machineString isEqualToString:@"wts_iPhone4,1"])   return iPhone_4S;
    if ([machineString isEqualToString:@"wts_iPhone5,1"])   return iPhone_5_GSM;
    if ([machineString isEqualToString:@"wts_iPhone5,2"])   return iPhone_5_CDMA;
    if ([machineString isEqualToString:@"wts_iPhone5,3"])   return iPhone_5C_GSM;
    if ([machineString isEqualToString:@"wts_iPhone5,4"])   return iPhone_5C_GSM_CDMA;
    if ([machineString isEqualToString:@"wts_iPhone6,1"])   return iPhone_5S_GSM;
    if ([machineString isEqualToString:@"wts_iPhone6,2"])   return iPhone_5S_GSM_CDMA;
    if ([machineString isEqualToString:@"iPhone7,2"])   return iPhone_6;
    if ([machineString isEqualToString:@"iPhone7,1"])   return iPhone_6_Plus;
    if ([machineString isEqualToString:@"iPhone8,1"])   return iPhone_6S;
    if ([machineString isEqualToString:@"iPhone8,2"])   return iPhone_6S_Plus;
    if ([machineString isEqualToString:@"iPhone8,4"])   return iPhone_SE;
    
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([machineString isEqualToString:@"iPhone9,1"])   return Chinese_iPhone_7;
    if ([machineString isEqualToString:@"iPhone9,2"])   return Chinese_iPhone_7_Plus;
    if ([machineString isEqualToString:@"iPhone9,3"])   return American_iPhone_7;
    if ([machineString isEqualToString:@"iPhone9,4"])   return American_iPhone_7_Plus;
    
    if ([machineString isEqualToString:@"iPhone10,1"])  return Chinese_iPhone_8;
    if ([machineString isEqualToString:@"iPhone10,2"])  return Chinese_iPhone_8_Plus;
    if ([machineString isEqualToString:@"iPhone10,3"])  return Chinese_iPhone_X;
    
    if ([machineString isEqualToString:@"iPhone10,4"])  return Global_iPhone_8;
    if ([machineString isEqualToString:@"iPhone10,5"])  return Global_iPhone_8_Plus;
    if ([machineString isEqualToString:@"iPhone10,6"])  return Global_iPhone_X;
    
    if ([machineString isEqualToString:@"iPhone11,2"])  return iPhone_XS;
    if ([machineString isEqualToString:@"iPhone11,4"])  return iPhone_XS_MAX;
    if ([machineString isEqualToString:@"iPhone11,6"])  return iPhone_XS_MAX;
    if ([machineString isEqualToString:@"iPhone11,8"])  return iPhone_XR;
    
    
    if ([machineString isEqualToString:@"iPhone12,1"])   return iPhone_11;
    if ([machineString isEqualToString:@"iPhone12,3"])   return iPhone_11_Pro;
    if ([machineString isEqualToString:@"iPhone12,5"])   return iPhone_11_Pro_Max;
    if ([machineString isEqualToString:@"iPhone12,8"]) return iPhone_SE_2;
    if ([machineString isEqualToString:@"iPhone13,1"]) return iPhone_12_mini;
    if ([machineString isEqualToString:@"iPhone13,2"]) return iPhone_12;
    if ([machineString isEqualToString:@"iPhone13,3"]) return iPhone_12_PRO;
    if ([machineString isEqualToString:@"iPhone13,4"]) return iPhone_12_PRO_MAX;
    if ([machineString isEqualToString:@"iPhone14,4"]) return iPhone_13_mini;
    if ([machineString isEqualToString:@"iPhone14,5"]) return iPhone_13;
    if ([machineString isEqualToString:@"iPhone14,2"]) return iPhone_13_PRO;
    if ([machineString isEqualToString:@"iPhone14,3"]) return iPhone_13_PRO_MAX;
    
    
    if ([machineString isEqualToString:@"iPod1,1"])     return iPod_Touch_1G;
    if ([machineString isEqualToString:@"iPod2,1"])     return iPod_Touch_2G;
    if ([machineString isEqualToString:@"iPod3,1"])     return iPod_Touch_3G;
    if ([machineString isEqualToString:@"iPod4,1"])     return iPod_Touch_4G;
    if ([machineString isEqualToString:@"iPod5,1"])     return iPod_Touch_5Gen;
    if ([machineString isEqualToString:@"iPod7,1"])     return iPod_Touch_6G;
    
    if ([machineString isEqualToString:@"iPad1,1"])     return iPad_1;
    if ([machineString isEqualToString:@"iPad1,2"])     return iPad_3G;
    if ([machineString isEqualToString:@"iPad2,1"])     return iPad_2_WiFi;
    if ([machineString isEqualToString:@"iPad2,2"])     return iPad_2_GSM;
    if ([machineString isEqualToString:@"iPad2,3"])     return iPad_2_CDMA;
    if ([machineString isEqualToString:@"iPad2,4"])     return iPad_2_CDMA;
    if ([machineString isEqualToString:@"iPad2,5"])     return iPad_Mini_WiFi;
    if ([machineString isEqualToString:@"iPad2,6"])     return iPad_Mini_GSM;
    if ([machineString isEqualToString:@"iPad2,7"])     return iPad_Mini_CDMA;
    if ([machineString isEqualToString:@"iPad3,1"])     return iPad_3_WiFi;
    if ([machineString isEqualToString:@"iPad3,2"])     return iPad_3_GSM;
    if ([machineString isEqualToString:@"iPad3,3"])     return iPad_3_CDMA;
    if ([machineString isEqualToString:@"iPad3,4"])     return iPad_4_WiFi;
    if ([machineString isEqualToString:@"iPad3,5"])     return iPad_4_GSM;
    if ([machineString isEqualToString:@"iPad3,6"])     return iPad_4_CDMA;
    if ([machineString isEqualToString:@"iPad4,1"])     return iPad_Air;
    if ([machineString isEqualToString:@"iPad4,2"])     return iPad_Air_Cellular;
    if ([machineString isEqualToString:@"iPad4,4"])     return iPad_Mini_2;
    if ([machineString isEqualToString:@"iPad4,5"])     return iPad_Mini_2_Cellular;
    if ([machineString isEqualToString:@"iPad4,7"])     return iPad_Mini_3_WiFi;
    if ([machineString isEqualToString:@"iPad4,8"])     return iPad_Mini_3_Cellular;
    if ([machineString isEqualToString:@"iPad4,9"])     return iPad_Mini_3_Cellular;
    if ([machineString isEqualToString:@"iPad5,1"])     return iPad_Mini_4_WiFi;
    if ([machineString isEqualToString:@"iPad5,2"])     return iPad_Mini_4_Cellular;
    
    if ([machineString isEqualToString:@"iPad5,3"])     return iPad_Air_2_WiFi;
    if ([machineString isEqualToString:@"iPad5,4"])     return iPad_Air_2_Cellular;
    if ([machineString isEqualToString:@"iPad6,3"])     return iPad_Pro_97inch_WiFi;
    if ([machineString isEqualToString:@"iPad6,4"])     return iPad_Pro_97inch_Cellular;
    if ([machineString isEqualToString:@"iPad6,7"])     return iPad_Pro_129inch_WiFi;
    if ([machineString isEqualToString:@"iPad6,8"])     return iPad_Pro_129inch_Cellular;
    
    if ([machineString isEqualToString:@"iPad6,11"])    return iPad_5_WiFi;
    if ([machineString isEqualToString:@"iPad6,12"])    return iPad_5_Cellular;
    if ([machineString isEqualToString:@"iPad7,1"])     return iPad_Pro_129inch_2nd_gen_WiFi;
    if ([machineString isEqualToString:@"iPad7,2"])     return iPad_Pro_129inch_2nd_gen_Cellular;
    if ([machineString isEqualToString:@"iPad7,3"])     return iPad_Pro_105inch_WiFi;
    if ([machineString isEqualToString:@"iPad7,4"])     return iPad_Pro_105inch_Cellular;
    
    if ([machineString isEqualToString:@"AppleTV2,1"])  return appleTV2;
    if ([machineString isEqualToString:@"AppleTV3,1"])  return appleTV3;
    if ([machineString isEqualToString:@"AppleTV3,2"])  return appleTV3;
    if ([machineString isEqualToString:@"AppleTV5,3"])  return appleTV4;
    
    if ([machineString isEqualToString:@"i386"])        return i386Simulator;
    if ([machineString isEqualToString:@"x86_64"])      return x86_64Simulator;
    return iUnknown;
//    return iUnknown;
}

#pragma Containers
static const NSString *iDeviceNameContainer[] = {
    [iPhone_1G]                 = @"iPhone 1G",
    [iPhone_3G]                 = @"iPhone 3G",
    [iPhone_3GS]                = @"iPhone 3GS",
    [iPhone_4]                  = @"iPhone 4",
    [iPhone_4_Verizon]          = @"Verizon iPhone 4",
    [iPhone_4S]                 = @"iPhone 4S",
    [iPhone_5_GSM]              = @"iPhone 5 (GSM)",
    [iPhone_5_CDMA]             = @"iPhone 5 (CDMA)",
    [iPhone_5C_GSM]             = @"iPhone 5C (GSM)",
    [iPhone_5C_GSM_CDMA]        = @"iPhone 5C (GSM+CDMA)",
    [iPhone_5S_GSM]             = @"iPhone 5S (GSM)",
    [iPhone_5S_GSM_CDMA]        = @"iPhone 5S (GSM+CDMA)",
    [iPhone_6]                  = @"iPhone 6",
    [iPhone_6_Plus]             = @"iPhone 6 Plus",
    [iPhone_6S]                 = @"iPhone 6S",
    [iPhone_6S_Plus]            = @"iPhone 6S Plus",
    [iPhone_SE]                 = @"iPhone SE",
    [Chinese_iPhone_7]          = @"国行/日版/港行 iPhone 7",
    [Chinese_iPhone_7_Plus]     = @"港行/国行 iPhone 7 Plus",
    [American_iPhone_7]         = @"美版/台版 iPhone 7",
    [American_iPhone_7_Plus]    = @"美版/台版 iPhone 7 Plus",
    [Chinese_iPhone_8]          = @"国行/日版 iPhone 8",
    [Chinese_iPhone_8_Plus]     = @"国行/日版 iPhone 8 Plus",
    [Chinese_iPhone_X]          = @"国行/日版 iPhone X",
    [Global_iPhone_8]           = @"美版(Global) iPhone 8",
    [Global_iPhone_8_Plus]      = @"美版(Global) iPhone 8 Plus",
    [Global_iPhone_X]           = @"美版(Global) iPhone X",
    [iPhone_XS]                 = @"iPhone XS",
    [iPhone_XR]                 = @"iPhone XR",
    [iPhone_XS_MAX]             = @"iPhone XS MAX",
    [iPhone_11]                 = @"iPhone 11",
    [iPhone_11_Pro]             = @"iPhone 11 Pro",
    [iPhone_11_Pro_Max]         = @"iPhone 11 Pro Max",
    [iPhone_SE_2]               = @"iPhone_SE_2",
    [iPhone_12_mini]            = @"iPhone_12_mini",
    [iPhone_12]                 = @"iPhone 12",
    [iPhone_12_PRO]             = @"iPhone 12 Pro",
    [iPhone_12_PRO_MAX]         = @"iPhone 12 Pro Max",
    [iPhone_13_mini]            = @"iPhone_13_mini",
    [iPhone_13]                 = @"iPhone 13",
    [iPhone_13_PRO]             = @"iPhone 13 Pro",
    [iPhone_13_PRO_MAX]         = @"iPhone 13 Pro Max",

    
    [iPod_Touch_1G]             = @"iPod Touch 1G",
    [iPod_Touch_2G]             = @"iPod Touch 2G",
    [iPod_Touch_3G]             = @"iPod Touch 3G",
    [iPod_Touch_4G]             = @"iPod Touch 4G",
    [iPod_Touch_5Gen]           = @"iPod Touch 5(Gen)",
    [iPod_Touch_6G]             = @"iPod Touch 6G",
    [iPad_1]                    = @"iPad 1",
    [iPad_3G]                   = @"iPad 3G",
    [iPad_2_CDMA]               = @"iPad 2 (GSM)",
    [iPad_2_GSM]                = @"iPad 2 (CDMA)",
    [iPad_2_WiFi]               = @"iPad 2 (WiFi)",
    [iPad_3_WiFi]               = @"iPad 3 (WiFi)",
    [iPad_3_GSM]                = @"iPad 3 (GSM)",
    [iPad_3_CDMA]               = @"iPad 3 (CDMA)",
    [iPad_3_GSM_CDMA]           = @"iPad 3 (GSM+CDMA)",
    [iPad_4_WiFi]               = @"iPad 4 (WiFi)",
    [iPad_4_GSM]                = @"iPad 4 (GSM)",
    [iPad_4_CDMA]               = @"iPad 4 (CDMA)",
    [iPad_4_GSM_CDMA]           = @"iPad 4 (GSM+CDMA)",
    [iPad_Air]                  = @"iPad Air",
    [iPad_Air_Cellular]         = @"iPad Air (Cellular)",
    [iPad_Air_2_WiFi]           = @"iPad Air 2 (WiFi)",
    [iPad_Air_2_Cellular]       = @"iPad Air 2 (Cellular)",
    [iPad_Mini_WiFi]            = @"iPad Mini (WiFi)",
    [iPad_Mini_GSM]             = @"iPad Mini (GSM)",
    [iPad_Mini_CDMA]            = @"iPad Mini (CDMA)",
    [iPad_Mini_2]               = @"iPad Mini 2",
    [iPad_Mini_2_Cellular]      = @"iPad Mini 2 (Cellular)",
    [iPad_Mini_3_WiFi]          = @"iPad Mini 3 (WiFi)",
    [iPad_Mini_3_Cellular]      = @"iPad Mini 3 (Cellular)",
    [iPad_Mini_4_WiFi]          = @"iPad Mini 4 (WiFi)",
    [iPad_Mini_4_Cellular]      = @"iPad Mini 4 (Cellular)",
    
    [iPad_Pro_97inch_WiFi]      = @"iPad Pro 9.7 inch(WiFi)",
    [iPad_Pro_97inch_Cellular]  = @"iPad Pro 9.7 inch(Cellular)",
    [iPad_Pro_129inch_WiFi]     = @"iPad Pro 12.9 inch(WiFi)",
    [iPad_Pro_129inch_Cellular] = @"iPad Pro 12.9 inch(Cellular)",
    [iPad_5_WiFi]               = @"iPad 5(WiFi)",
    [iPad_5_Cellular]           = @"iPad 5(Cellular)",
    [iPad_Pro_129inch_2nd_gen_WiFi]     = @"iPad Pro 12.9 inch(2nd generation)(WiFi)",
    [iPad_Pro_129inch_2nd_gen_Cellular] = @"iPad Pro 12.9 inch(2nd generation)(Cellular)",
    [iPad_Pro_105inch_WiFi]             = @"iPad Pro 10.5 inch(WiFi)",
    [iPad_Pro_105inch_Cellular]         = @"iPad Pro 10.5 inch(Cellular)",
    
    [appleTV2]                  = @"appleTV2",
    [appleTV3]                  = @"appleTV3",
    [appleTV4]                  = @"appleTV4",
    
    [i386Simulator]             = @"i386Simulator",
    [x86_64Simulator]           = @"x86_64Simulator",
    
    [iUnknown]                  = @"Unknown"
};

static const NSString *latestFirmwareContainer[] = {
    [iPhone_1G]                 = @"3.1.3",
    [iPhone_3G]                 = @"4.2.1",
    [iPhone_3GS]                = @"6.1.6",
    [iPhone_4]                  = @"7.1.2",
    [iPhone_4_Verizon]          = @"7.1.2",
    [iPhone_4S]                 = @"9.3.5",
    [iPhone_5_GSM]              = @"10.3.3",
    [iPhone_5_CDMA]             = @"10.3.3",
    [iPhone_5C_GSM]             = @"10.3.3",
    [iPhone_5C_GSM_CDMA]        = @"10.3.3",
    [iPhone_5S_GSM]             = @"11.2.5 beta3(尚未到顶)",
    [iPhone_5S_GSM_CDMA]        = @"11.2.5 beta3(尚未到顶)",
    [iPhone_6]                  = @"11.2.5 beta3(尚未到顶)",
    [iPhone_6_Plus]             = @"11.2.5 beta3(尚未到顶)",
    [iPhone_6S]                 = @"11.2.5 beta3(尚未到顶)",
    [iPhone_6S_Plus]            = @"11.2.5 beta3(尚未到顶)",
    [iPhone_SE]                 = @"11.2.5 beta3(尚未到顶)",
    [Chinese_iPhone_7]          = @"11.2.5 beta3(尚未到顶)",
    [American_iPhone_7]         = @"11.2.5 beta3(尚未到顶)",
    [American_iPhone_7_Plus]    = @"11.2.5 beta3(尚未到顶)",
    [Chinese_iPhone_7_Plus]     = @"11.2.5 beta3(尚未到顶)",
    [Chinese_iPhone_8]          = @"11.2.5 beta3(尚未到顶)",
    [Chinese_iPhone_8_Plus]     = @"11.2.5 beta3(尚未到顶)",
    [Chinese_iPhone_X]          = @"11.2.5 beta3(尚未到顶)",
    [Global_iPhone_8]           = @"11.2.5 beta3(尚未到顶)",
    [Global_iPhone_8_Plus]      = @"11.2.5 beta3(尚未到顶)",
    [Global_iPhone_X]           = @"11.2.5 beta3(尚未到顶)",
    
    [iPod_Touch_1G]             = @"3.1.3",
    [iPod_Touch_2G]             = @"4.2.1",
    [iPod_Touch_3G]             = @"5.1.1",
    [iPod_Touch_4G]             = @"6.1.6",
    [iPod_Touch_5Gen]           = @"9.3.5",
    [iPod_Touch_6G]             = @"11.2.5 beta3(尚未到顶)",
    [iPad_1]                    = @"5.1.1",
    [iPad_2_CDMA]               = @"9.3.5",
    [iPad_2_GSM]                = @"9.3.5",
    [iPad_2_WiFi]               = @"9.3.5",
    [iPad_3_WiFi]               = @"9.3.5",
    [iPad_3_GSM]                = @"9.3.5",
    [iPad_3_CDMA]               = @"9.3.5",
    [iPad_4_WiFi]               = @"10.3.3",
    [iPad_4_GSM]                = @"10.3.3",
    [iPad_4_CDMA]               = @"10.3.3",
    [iPad_Air]                  = @"11.2.5 beta3(尚未到顶)",
    [iPad_Air_Cellular]         = @"11.2.5 beta3(尚未到顶)",
    [iPad_Air_2_WiFi]           = @"11.2.5 beta3(尚未到顶)",
    [iPad_Air_2_Cellular]       = @"11.2.5 beta3(尚未到顶)",
    [iPad_Mini_WiFi]            = @"9.3.5",
    [iPad_Mini_GSM]             = @"9.3.5",
    [iPad_Mini_CDMA]            = @"9.3.5",
    [iPad_Mini_2]               = @"11.2.5 beta3(尚未到顶)",
    [iPad_Mini_2_Cellular]      = @"11.2.5 beta3(尚未到顶)",
    [iPad_Mini_3_WiFi]          = @"11.2.5 beta3(尚未到顶)",
    [iPad_Mini_3_Cellular]      = @"11.2.5 beta3(尚未到顶)",
    [iPad_Mini_4_WiFi]          = @"11.2.5 beta3(尚未到顶)",
    [iPad_Mini_4_Cellular]      = @"11.2.5 beta3(尚未到顶)",
    
    [iPad_Pro_97inch_WiFi]      = @"11.2.5 beta3(尚未到顶)",
    [iPad_Pro_97inch_Cellular]  = @"11.2.5 beta3(尚未到顶)",
    [iPad_Pro_129inch_WiFi]     = @"11.2.5 beta3(尚未到顶)",
    [iPad_Pro_129inch_Cellular] = @"11.2.5 beta3(尚未到顶)",
    [iPad_Pro_129inch_2nd_gen_WiFi]     = @"11.2.5 beta3(尚未到顶)",
    [iPad_Pro_129inch_2nd_gen_Cellular] = @"11.2.5 beta3(尚未到顶)",
    [iPad_Pro_105inch_WiFi]             = @"11.2.5 beta3(尚未到顶)",
    [iPad_Pro_105inch_Cellular]         = @"11.2.5 beta3(尚未到顶)",
    
    [iUnknown]                          = @"Unknown"
};

/**
 判断网络是否有蜂窝权限
 */
+ (void)judgeNetWork:(JudgeNetWorkResult)result
{
    if (wts_iOSLater(9.0))
    {
        CTCellularData *cellularData = [[CTCellularData alloc] init];
        // 状态发生变化时调用
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState restrictedState) {
            switch (restrictedState) {
                case kCTCellularDataRestrictedStateUnknown:
                    break;
                case kCTCellularDataRestricted:
                    break;
                case kCTCellularDataNotRestricted:
                    break;
                default:
                    break;
            }
            result(restrictedState);
        };

    }

}

@end
