//
//  BITCommonMacro.h
//  YXB
//
//  Created by huihui on 2021/9/24.
//

#ifndef BITCommonMacro_h
#define BITCommonMacro_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/** 适配方法一*/

#define bit_TopStatuHeight           [[UIApplication sharedApplication] statusBarFrame].size.height
//系统底部TabBar高度
#define bit_TabBarHeight          (BIT_TopStatuHeight>20?83:49)
//系统导航栏总高度
#define bit_NavHeight     (BIT_TopStatuHeight>20?88:64)
// 底部安全区域远离高度
#define bit_BottomSafeHeight      (BIT_TopStatuHeight>20?34:0)

/** 适配方法二*/
#define kMainTopHeight  ({ float space = 64.0; if (@available(iOS 11.0, *)) space = ([[UIApplication sharedApplication] delegate].window.safeAreaInsets.top+44); (space); })
#define kMainBottomHeight ({ float space = 49.0; if (@available(iOS 11.0, *)) space = ([[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom + 49); (space); })
#define kMainStatusBarHeight  ({ float space = 20.0; if (@available(iOS 11.0, *)) space = ([[UIApplication sharedApplication] delegate].window.safeAreaInsets.top); (space); })
#define kAuctionNavBarTop  ({ float space = 0.0; if (@available(iOS 11.0, *)) space = (([[UIApplication sharedApplication] delegate].window.safeAreaInsets.top - 20)); (space); })
#define kMainBottomHeightShift  ({ float space = 0.0; if (@available(iOS 11.0, *)) space = (([[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom)); (space); })

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//25D4D0
//#define BlackLevelOneColor   RGB(51, 51, 51)
//#define BlackLevelTwoColor   RGB(102, 102, 102)
//#define BlackLevelThreeColor RGB(153, 153, 153)

#define HHTBlackColor        RGB(6, 16, 43)
#define BlackLevelOneColor   RGB(39, 49, 74)
#define BlackLevelTwoColor   RGB(142, 148, 167)
#define BlackLevelThreeColor RGB(195, 199, 209)

#define BlackLevelFourColor  RGB(204, 204, 204)
#define PPWhiteCoLor         RGB(255, 255, 255)
#define PPBlackCoLor         RGB(0, 0, 0)
#define PPClearCoLor         [UIColor clearColor]


#define HHTBgCoLor           RGB(247, 247, 247)
#define HHTTabSelectColor    RGB(20, 123, 254)
#define HHTLineCoLor         RGB(239, 239, 239)


#define HHTTabUnSelectColor  RGB(156, 156, 156)
#define YXBDisEnabledColor   RGB(239, 240, 241)
#define YXBDisEnabledColorTwo   RGB(249, 251, 254)
#define YXBBlackLevelColor   RGB(6, 16, 43)



#define FFBgColorTwo         RGB(241, 241, 241)
#define FFRedColor           RGB(237, 91, 93)
#define PPPinkIconBgColor    RGB(245,245,245)
#define HighlightBackgroundColor     RGB(242, 242, 242)
#define PPTFColor            RGB(17, 17, 17)


#define FFBlueColor          RGB(0, 110, 255)
#define FFBlueColorTwo       RGB(20, 123, 254)

//#define LineColor            RGB(223, 223, 223)
#define LineColor            RGB(241, 243, 246)
//

//zueuzu
#define PPbgCoLor            RGB(248, 248, 248)
#define PPTabSelectColor     RGB(255, 36, 1)
#define PPTabUnSelectColor   RGB(206, 212, 226)


#define ThemColor            HHTTabSelectColor

#define wts_HEXCOLORA(hex,a)                    [UIColor colorWithHexString:hex alpha:a]
#define wts_HEXCOLOR(hex)                       wts_HEXCOLORA(hex,1)

//颜色
#define WLColor(r,g,b,a) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:a]

//由十六进制转换成是十进制
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

/** 字体*/
#define NFont(x) [UIFont systemFontOfSize:x]
#define MFont(x) ([UIFont fontWithName:@"PingFangSC-Medium" size:x])
#define BFont(x) [UIFont boldSystemFontOfSize:x]

//自适应高度字体
#define BaseSize(x)   (SCREEN_WIDTH*(x)/375.0)
#define SystemFontOfSize(x) [UIFont systemFontOfSize:BaseSize(x)]
#define SystemMediumFontOfSize(x) ([UIFont fontWithName:@"PingFangSC-Medium" size:BaseSize(x)])
#define SystemNFont(x) [UIFont systemFontOfSize:BaseSize(x)]
#define SystemBFont(x) [UIFont boldSystemFontOfSize:BaseSize(x)]


#define FImg(IMGSTR)    [UIImage imageNamed:IMGSTR]
#define FFImg(IMGSTR)   [UIImage imageNamed:@"IMGSTR"]

#define FUrl(URL)    [NSURL URLWithString:[URL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]

#define FUrlStr(URLStr)[URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]

#ifdef DEBUG

#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(format, ...)
#define debugMethod()
#endif
#define WeakSelf __weak typeof(self) weakSelf = self;
#define __FUNC__  NSLog(@"%s",__func__);

#define ScaleSafeX750(x) (x)*SAFEAREA_WIDTH/(375-40)
#define SX750(x) (x)*SCREEN_WIDTH/375.0
#define CommonLeftMargin SX750(23)
#define SAFEAREA_WIDTH (SCREEN_WIDTH-2*CommonLeftMargin)
#define DefaultTableViewHeaderFooterHeight 0.01f
//1像素
#define YXB_1PX (1.0f / [UIScreen mainScreen].scale)


#define PAGESIZE 10

// PROPERTY
#define wts_STRONG(__class__, __property__)\
@property (nonatomic, strong ,nullable)__class__  * __property__;

#define wts_READONLY(__class__, __property__)\
@property(nonatomic, readonly)__class__   __property__;

#define wts_ASSIGN(__class__, __property__)\
@property (nonatomic,assign)__class__  __property__;

#define wts_COPY(__class__, __property__)\
@property (nonatomic, copy, nullable)__class__  *__property__;

#define wts_COPY_BLOCK(__class__, __property__)\
@property (nonatomic, copy ,nullable)__class__  __property__;

#define wts_WEAK(__class__, __property__)\
@property (nonatomic, weak,nullable)__class__  *__property__;



/*
 *手机屏幕判断
 */
#pragma mark - 手机屏幕判断
#define wts_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define wts_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define wts_iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define wts_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define wts_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define wts_iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define wts_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define wts_iPhoneXS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define wts_iPhoneXr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size): NO)

#define wts_iPhoneXMax ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

#define wts_iPhoneXALL (wts_iPhoneX || wts_iPhoneXS || wts_iPhoneXr || wts_iPhoneXMax)


#define wts_bottomMargin(s) (wts_iPhoneXALL?-34+s:s)

#define wts_safeDistance (wts_iPhoneXALL?34:0)


// 适配相关
#define wts_iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1080, 1920), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)


//适配iPhone X
#define wts_currentH(s) (ceilf(s * SCREEN_HEIGHT / 812.0))
#define wts_currentW(s) (ceilf(s * SCREEN_WIDTH / 375.0))

#define wts_iOSLater(s) ([UIDevice currentDevice].systemVersion.floatValue >= s)

/*
 *屏幕高度尺寸计算
 */
#pragma mark - 屏幕高度尺寸计算
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width

#define wts_StatusBar_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

#define wts_StatusBar_HEIGHT_Hidden (wts_iPhoneXALL?44.0f:20.0f)


#define wts_NavBarView_HEIGHT  44.0f
#define wts_NavBar_HEIGHT (wts_StatusBar_HEIGHT_Hidden + wts_NavBarView_HEIGHT)

#define wts_Bottom_Safe_Distance ((wts_StatusBar_HEIGHT_Hidden == 44.0f)?34.0f:0.0f)

#define wts_TabBar_HEIGHT ((wts_StatusBar_HEIGHT_Hidden == 44.0f)?83.0f:49.0f)

#define _LWTSE_HEIGHT_1_PPI         (1/[UIScreen mainScreen].scale)

#define wts_CommanImageCornerRadius    2.0f
#define  PPMargin   15 //横向
#define  PHMargin   15 //竖向
#define  FSXMargin  SX750(15) //横向
//#define wts_KEY_WINDOW UIApplication sharedApplication].keyWindow
#define wts_KEY_WINDOW [[UIApplication sharedApplication].delegate window]
//#define wts_KEY_WINDOW_ROOTCT [UIApplication sharedApplication].keyWindow.rootViewController
#define wts_KEY_WINDOW_ROOTCT [[UIApplication sharedApplication].delegate window].rootViewController


#define wts_KEY_WINDOW_ROOTCT_VIEW [UIApplication sharedApplication].keyWindow.rootViewController.view

/*
 *G－C－D 多线程
 */
#pragma mark - G－C－D 多线程
#define wts_BACK_QUEUE(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAWTS_QUEUE(block) dispatch_async(dispatch_get_main_queue(),block)


/*
 *颜色
 */
#pragma mark - 颜色
#define wts_RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define wts_RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define wts_GrayColor(rgb)  [UIColor colorWithRed:rgb/255.0 green:rgb/255.0 blue:rgb/255.0 alpha:1.0]

#define wts_NormalColor wts_HEXCOLOR(@"ffff04")

/*
 * __weak
 */
#define wts_WEAKSELF typeof(self) __weak weakSelf = self;
#define wts_STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

/*
 * UIImage
 */
//#define WTSImage(name) [UIImage imageNamed:name]

#define WTSImage(name) [[WTSServiceConfig shareManager] image:name]





#define WTSPlaceImage    [UIImage imageWithColor:wts_HEXCOLOR(@"f8f8f8")]
#define WTSPlaceImageUser    [UIImage imageNamed:@"p_face_logo"]


/*
 * safe
 */

#define wts_IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]) || ([(_ref) isEqual:@"<null>"])|| ([(_ref) isEqual:@"(null)"]))

#pragma mark - 提示框
#define wts_Tips(mess)  [[TPTips sharedInstance] normalPopShow:mess andFont:15 andWidth:SCREEN_WIDTH/2.0 andTime:2.0]

#define wts_Tips_Font(mess, font)  [[TPTips sharedInstance] normalPopShow:mess andFont:font andWidth:SCREEN_WIDTH/2.0 andTime:2.0]

#define wts_Tips_Font_width(mess, font, width)  [[TPTips sharedInstance] normalPopShow:mess andFont:font andWidth:width andTime:2.0]

#define wts_Tips_Font_Width_Time(mess, font, width, time)  [[TPTips sharedInstance] normalPopShow:mess andFont:font andWidth:width andTime:time]


#define wts_TipsCenter(mess)  [[TPTips sharedInstance] centerPopShow:mess andFont:15 andWidth:SCREEN_WIDTH/2.0 andTime:2.0]

#define wts_TipsCenter_Font(mess, font)  [[TPTips sharedInstance] centerPopShow:mess andFont:font andWidth:SCREEN_WIDTH/2.0 andTime:2.0]

#define wts_TipsCenter_Font_width(mess, font, width)  [[TPTips sharedInstance] centerPopShow:mess andFont:font andWidth:width andTime:2.0]

#define wts_TipsCenter_Font_width_Time(mess, font, width, time)  [[TPTips sharedInstance] centerPopShow:mess andFont:font andWidth:width andTime:time]


/*
 * NSString
 */
#define wts_NETWORK_ERROR @"网络异常"

#pragma mark-----消除警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

//从userDefault中获取值
#ifndef wts_getObjectFromUserDefault
#define wts_getObjectFromUserDefault(__key__) \
[[NSUserDefaults standardUserDefaults] objectForKey:__key__];
#endif

#endif /* BITCommonMacro_h */
