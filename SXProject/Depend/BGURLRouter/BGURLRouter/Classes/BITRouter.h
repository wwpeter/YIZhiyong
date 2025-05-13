//
//  BITRouter.h
//  Pods
//
//  Created by jiaguoshang on 18/9/30.
//
//

#import <Foundation/Foundation.h>

extern NSString *const BITRouterParameterURL;
extern NSString *const BITRouterParameterCompletion;
extern NSString *const BITRouterParameterUserInfo;

@protocol BITRouterDelegate;

/**
 *  routerParameters 里内置的几个参数会用到上面定义的 string
 */
typedef void (^BITRouterHandler)(NSDictionary *routerParameters);

/**
 *  需要返回一个 object，配合 objectForURL: 使用
 */
typedef id (^BITRouterObjectHandler)(NSDictionary *routerParameters);


/**
 *  这个类的目的是注册 / 获取 URL ，仅此而已
 *  push VC 这样的活都在 handler 中处理，这样就不需要依赖 NavigationController ，在 Handler 中可以用各种姿势呈现 VC
 */
@interface BITRouter : NSObject

/**
 *  设置 Delegate
 *
 *  @param delegate delegate
 */
+ (void)setDelegate:(id<BITRouterDelegate>)delegate;

/**
 @brief 加载 URL replace 规则表
 @param replaceList 规则表，每个元素都是一个NSDictionary，{"pattern":"","replace":""}
 */
+ (void)loadReplaceRuleList:(NSArray *)replaceList;

/**
 *  注册 URLPattern 对应的 Handler，在 handler 中可以初始化 VC，然后对 VC 做各种操作
 *
 *  @param URLPattern 带上 scheme，如 mgj://beauty/:id
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 *                    自带的 key 为 @"url" 和 @"completion" (如果有的话)
 */
+ (void)registerURLPattern:(NSString *)URLPattern toHandler:(BITRouterHandler)handler;

/**
 *  注册 URLPattern 对应的 ObjectHandler，需要返回一个 object 给调用方
 *
 *  @param URLPattern 带上 scheme，如 mgj://beauty/:id
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 *                    自带的 key 为 @"url" 和 @"completion" (如果有的话)
 */
+ (void)registerURLPattern:(NSString *)URLPattern toObjectHandler:(BITRouterObjectHandler)handler;

/**
 * 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL
 */
+ (id)objectForURL:(NSString *)URL;

/**
 * 查找谁对某个 URL 感兴趣，如果有的话，返回一个 object
 *
 *  @param URL
 *  @param userInfo
 */
+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo;

/**
 *  取消注册某个 URL Pattern
 *
 *  @param URLPattern
 */
+ (void)deregisterURLPattern:(NSString *)URLPattern;
//***********************************push推出一个VC********************************************
/**
 *  打开此 URL
 *  会在已注册的 URL -> Handler 中寻找，如果找到，则执行 Handler
 *
 *  @param URL 带 Scheme，如 mgj://beauty/3
 */
+ (void)openURL:(NSString *)URL;

/**
 *  打开此 URL，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带 Scheme 的 URL，如 mgj://beauty/4
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)openURL:(NSString *)URL completion:(void (^)(id result))completion;

/**
 *  打开此 URL，带上附加信息，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带 Scheme 的 URL，如 mgj://beauty/4
 *  @param parameters 附加参数
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion;
//***************************************pop到某一个固定的VC**************************************
/**
 *  打开此 URL
 *  会在已注册的 URL -> Handler 中寻找，如果找到，则执行 Handler
 *
 *  @param URL 带 Scheme，如 mgj://beauty/3
 */
+ (void)popToURL:(NSString *)URL;

/**
 *  打开此 URL，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带 Scheme 的 URL，如 mgj://beauty/4
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)popToURL:(NSString *)URL completion:(void (^)(id result))completion;

/**
 *  打开此 URL，带上附加信息，同时当操作完成时，执行额外的代码
 *
 *  @param URL        带 Scheme 的 URL，如 mgj://beauty/4
 *  @param parameters 附加参数
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)popToURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion;




/**
 *  是否可以打开URL
 *
 *  @param URL
 *
 *  @return
 */
+ (BOOL)canOpenURL:(NSString *)URL;





/*!
 @brief 根据配置的 url 转换表来转换 url。如果没有对应的配置，则原样返回。
 */
+ (NSString *)rewriteURLIfNeeded:(NSString *)url;


/**
 *  调用此方法来拼接 urlpattern 和 parameters
 *
 *  #define BIT_ROUTE_BEAUTY @"beauty/:id"
 *  [BITRouter generateURLWithPattern:BIT_ROUTE_BEAUTY, @[@13]];
 *
 *
 *  @param pattern    url pattern 比如 @"beauty/:id"
 *  @param parameters 一个数组，数量要跟 pattern 里的变量一致
 *
 *  @return
 */
+ (NSString *)generateURLWithPattern:(NSString *)pattern parameters:(NSArray *)parameters;
@end


@protocol BITRouterDelegate <NSObject>

@optional

- (BOOL)router:(BITRouter *)router shouldOpenURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion;

/**
 *  BITRouter 即将处理 URL 前调用此方法
 *
 *  @param router   BITRouter 实例
 *  @param URL      URL
 *  @param userInfo 附加参数
 */
- (void)router:(BITRouter *)router willOpenURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo;

/**
 *  BITRouter 无法处理传入的 URL 时调用此方法
 *
 *  @param router   BITRouter 实例
 *  @param URL      URL
 *  @param userInfo 附加参数
 */
- (void)router:(BITRouter *)router didFailOpenWithURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo;

@end
