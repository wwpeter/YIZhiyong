//
//  DataMacor.h
//  assistant
//
//  Created by admin on 17/3/25.
//  Copyright © 2017年 com.91wailian. All rights reserved.
//

#ifndef DataMacro_h
#define DataMacro_h


#pragma mark - Safe
#define wts_NoNilString(macro_string)   ([macro_string isKindOfClass:[NSString class]] ? macro_string : @"")
#define wts_NoNilNumber(macro_number)   ([macro_number isKindOfClass:[NSNumber class]] ? macro_number : @0)

// 萍方中黑
#define wts_FONT_Bold(s) [UIFont fontWithName:@"PingFangSC-Medium" size:s]?[UIFont fontWithName:@"PingFangSC-Medium" size:s]:[UIFont fontWithName:@"Helvetica-Bold" size:s]

// 方正兰亭细黑
#define wts_FONT_Normal(s)   [UIFont fontWithName:@"FZLTXHKM" size:s]?[UIFont fontWithName:@"FZLTXHKM" size:s]:[UIFont systemFontOfSize:s]

/*
 * NSUserDefaults
 */
//setuserDefault值
#ifndef wts_setObjectToUserDefault
#define wts_setObjectToUserDefault(__key__, __val__) \
[[NSUserDefaults standardUserDefaults] setObject:__val__ forKey:__key__];\
[[NSUserDefaults standardUserDefaults] synchronize];
#endif

//从userDeufalt中移除值
#ifndef wts_removeObjectFromUserDefault
#define wts_removeObjectFromUserDefault(__key__) \
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__key__];\
[[NSUserDefaults standardUserDefaults] synchronize];
#endif

//从userDefault中获取值
#ifndef wts_getObjectFromUserDefault
#define wts_getObjectFromUserDefault(__key__) \
[[NSUserDefaults standardUserDefaults] objectForKey:__key__];
#endif

//设备 唯一 udid
#define wts_KEY_Iphone_UUID  @"KeyIphoneUUID"

// 极光推送
#define wts_JPUSHKEY @"ea76b88328b2bd0415b14d89"

// 跳转登录通知
#define wts_UnAuthorization @"wts_UnAuthorization"

#define wts_TokenFailure @"wts_TokenFailure"




//支付结果通知
#define wts_PayResultNotification @"wts_PayResultNotification"


// 英雄皮肤存储
#define wts_SearchKey           @"wts_SearchKey"

#define wts_SearchNetBarKey     @"wts_SearchNetBarKey"

#define wts_BlurSearchKey       @"wts_BlurSearchKey"

#define wts_IM_ACCTOUNT  [WTSServiceConfig shareManager].configModle.user.im_account
#define wts_CURRENT_UID  [WTSServiceConfig shareManager].configModle.user.uid


// 登录成功回调
#define wts_IM_login_success @"wts_IM_login_success"

// 刷新红点
#define wts_IM_Refresh_UnreadNum @"wts_IM_Refresh_UnreadNum"

// 刷新红点
#define wts_IM_Receive_Group_passthrough_notify @"wts_IM_Receive_Group_passthrough_notify"

// 刷新好友
#define wts_IM_Receive_refresh_friend_notify @"wts_IM_Receive_refresh_friend_notify"

#pragma mark - 常用颜色集合
// 选中颜色
#define wts_SELECTED_COLOR   [UIColor blackColor]
//分割线的颜色
#define wts_SEPARATOR_COLOR  wts_HEXCOLOR(@"E7E7E9")

#define wts_Controller_BackGroundColor wts_HEXCOLOR(@"F8F8F8")


#define wts_IS_REVIEW [WTSServiceConfig shareManager].configModle.isReview

#define wts_IS_LOGWTS !wts_IsStrEmpty([WTSServiceConfig shareManager].configModle.user.code)




#endif /* DataMacor_h */
