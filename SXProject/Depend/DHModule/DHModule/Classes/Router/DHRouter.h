//
//  DHRouter.h 在MGHRouter外面加一层 方便以后置换
//  Pods
//
//  Created by Anson on 2017/5/18.
//
//

#import <Foundation/Foundation.h>
#import <DHModule/DHRouterDefine.h>

@interface DHRouter : NSObject

/**
 *  设置不同项目对应的scheme
 *
 *  @param scheme   如果设置了该值，则在注册/使用的时候可以不用带scheme；如rn/notice，内部会自动拼接成 imou://rn/notice
 *                  如果没有设置该值，在注册/使用的时候都需要带上对应的scheme;
 *
 */
+ (void)setScheme:(NSString *)scheme;

/**
 *  注册 URLPattern 对应的 Handler，在 handler 中可以初始化 VC，然后对 VC 做各种操作
 *
 *  @param URLPattern 如果没有设置shceme，则带上 scheme，如 imou://rn/notice
 *                    如果设置了shceme，则不需要带scheme，如 rn/notice
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 */
+ (void)registerURLPattern:(NSString *)URLPattern toHandler:(DHRouterHandler)handler;

/**
 *  注册 URLPattern 对应的 ObjectHandler，需要返回一个 object 给调用方
 *
 *  @param URLPattern 如果没有设置shceme，则带上 scheme，如 imou://rn/notice
 *                    如果设置了shceme，则不需要带scheme，如 rn/notice
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 imou://rn/notice?id=4 那么，就会传一个 @{@"id": 4} 这样的字典过来
 *                    自带的 key 为 @"url" 和 @"completion" (如果有的话)
 */
+ (void)registerURLPattern:(NSString *)URLPattern toObjectHandler:(DHRouterObjectHandler)handler;

/**
 *  取消注册某个 URL Pattern
 *
 *  @param URLPattern 已注册的url
 */
+ (void)deregisterURLPattern:(NSString *)URLPattern;

/**
 *  打开此 URL
 *  会在已注册的 URL -> Handler 中寻找，如果找到，则执行 Handler
 *
 *  @param URL 带scheme时，直接打开；不带scheme时，内部进行拼接
 */
+ (void)openURL:(NSString *)URL;

/**
 *  打开此 URL，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带scheme时，直接打开；不带scheme时，内部进行拼接
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)openURL:(NSString *)URL completion:(DHRouterCompletionHandler)completion;

/**
 *  打开此 URL，带上附加信息，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带scheme时，直接打开；不带scheme时，内部进行拼接
 *  @param userInfo   附加参数
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(DHRouterCompletionHandler)completion;

/**
 * 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL 已注册的路由url
 */
+ (id)objectForURL:(NSString *)URL;

/**
 * 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL 已注册的路由url
 *  @param userInfo 用户参数
 */
+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo;

/**
 *  是否可以打开URL
 *
 *  @param URL 已注册的路由url
 *
 *  @return YES or NO
 */
+ (BOOL)canOpenURL:(NSString *)URL;

/**
 *  调用此方法来拼接 urlpattern 和 parameters
 *
 *  @param pattern    如果没有设置shceme，则带上 scheme，如 imou://rn/notice
 *                    如果设置了shceme，则不需要带scheme，如 rn/notice
 *  @param parameters 一个数组，数量要跟 pattern 里的变量一致
 *
 *  @return Route url
 */
+ (NSString *)generateURLWithPattern:(NSString *)pattern parameters:(NSArray *)parameters;

/// 生成路由统一的返回Json串
/// @param customParams 自定义值
/// @param isSucceed 是否调用成功
/// @param code 默认100-成功
+ (NSString *)generateJsonResult:(NSDictionary *)customParams isSucceed:(BOOL)isSucceed code:(NSInteger)code;

/// 解析URL中的参数(包括JSON格式的值），返回JSON对象
/// @param url URL
+ (NSMutableDictionary *)jsonParametersFromURL:(NSString *)url;

@end
