//
//  DHRouter.m
//  Pods
//
//  Created by Anson on 2017/5/18.
//
//

#import "DHRouter.h"

NSString *const DHRouterParameterURL = @"MGJRouterParameterURL";
NSString *const DHRouterParameterCompletion = @"MGJRouterParameterCompletion";
NSString *const DHRouterParameterUserInfo = @"MGJRouterParameterUserInfo";

static NSString * const MGJ_ROUTER_WILDCARD_CHARACTER = @"~";
static NSString *specialCharacters = @"/?&.";

NSString *const MGJRouterParameterURL = @"MGJRouterParameterURL";
NSString *const MGJRouterParameterCompletion = @"MGJRouterParameterCompletion";
NSString *const MGJRouterParameterUserInfo = @"MGJRouterParameterUserInfo";

/**
 *  routerParameters 里内置的几个参数会用到上面定义的 string
 */
typedef void (^MGJRouterHandler)(NSDictionary *routerParameters);

/**
 *  需要返回一个 object，配合 objectForURL: 使用
 */
typedef id (^MGJRouterObjectHandler)(NSDictionary *routerParameters);

@interface MGJRouter : NSObject

/**
 *  注册 URLPattern 对应的 Handler，在 handler 中可以初始化 VC，然后对 VC 做各种操作
 *
 *  @param URLPattern 带上 scheme，如 mgj://beauty/:id
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 */
+ (void)registerURLPattern:(NSString *)URLPattern toHandler:(MGJRouterHandler)handler;

/**
 *  注册 URLPattern 对应的 ObjectHandler，需要返回一个 object 给调用方
 *
 *  @param URLPattern 带上 scheme，如 mgj://beauty/:id
 *  @param handler    该 block 会传一个字典，包含了注册的 URL 中对应的变量。
 *                    假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
 *                    自带的 key 为 @"url" 和 @"completion" (如果有的话)
 */
+ (void)registerURLPattern:(NSString *)URLPattern toObjectHandler:(MGJRouterObjectHandler)handler;

/**
 *  取消注册某个 URL Pattern
 *
 *  @param URLPattern 已注册的路由url
 */
+ (void)deregisterURLPattern:(NSString *)URLPattern;

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
 *  @param userInfo 附加参数
 *  @param completion URL 处理完成后的 callback，完成的判定跟具体的业务相关
 */
+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion;

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
 *  @param userInfo 参数
 */
+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo;

/**
 *  是否可以打开URL
 *
 *  @param URL 路由url
 *
 *  @return YES or NO
 */
+ (BOOL)canOpenURL:(NSString *)URL;

/**
 *  调用此方法来拼接 urlpattern 和 parameters
 *
 *  #define MGJ_ROUTE_BEAUTY @"beauty/:id"
 *  [MGJRouter generateURLWithPattern:MGJ_ROUTE_BEAUTY, @[@13]];
 *
 *
 *  @param pattern    url pattern 比如 @"beauty/:id"
 *  @param parameters 一个数组，数量要跟 pattern 里的变量一致
 *
 *  @return Route url
 */
+ (NSString *)generateURLWithPattern:(NSString *)pattern parameters:(NSArray *)parameters;
@end

@interface MGJRouter ()
/**
 *  保存了所有已注册的 URL
 *  结构类似 @{@"beauty": @{@":id": {@"_", [block copy]}}}
 */
@property (nonatomic) NSMutableDictionary *routes;
@property (nonatomic, copy) NSString *scheme;
@end

@implementation MGJRouter

+ (instancetype)sharedInstance
{
    static MGJRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)registerURLPattern:(NSString *)URLPattern toHandler:(MGJRouterHandler)handler
{
    [[self sharedInstance] addURLPattern:URLPattern andHandler:handler];
}

+ (void)deregisterURLPattern:(NSString *)URLPattern
{
    [[self sharedInstance] removeURLPattern:URLPattern];
}

+ (void)openURL:(NSString *)URL
{
    [self openURL:URL completion:nil];
}

+ (void)openURL:(NSString *)URL completion:(void (^)(id result))completion
{
    [self openURL:URL withUserInfo:nil completion:completion];
}

+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id result))completion
{
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [[self sharedInstance] extractParametersFromURL:URL];
   
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, NSString *obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            parameters[key] = [obj stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }];
    
    if (parameters) {
        MGJRouterHandler handler = parameters[@"block"];
        if (completion) {
            parameters[MGJRouterParameterCompletion] = completion;
        }
        if (userInfo) {
            parameters[MGJRouterParameterUserInfo] = userInfo;
        }
        if (handler) {
            [parameters removeObjectForKey:@"block"];
            handler(parameters);
        }
    }
}

+ (BOOL)canOpenURL:(NSString *)URL
{
    return [[self sharedInstance] extractParametersFromURL:URL] ? YES : NO;
}

+ (NSString *)generateURLWithPattern:(NSString *)pattern parameters:(NSArray *)parameters
{
    NSInteger startIndexOfColon = 0;
    
    NSMutableArray *placeholders = [NSMutableArray array];
    
    for (int i = 0; i < pattern.length; i++) {
        NSString *character = [NSString stringWithFormat:@"%c", [pattern characterAtIndex:i]];
        if ([character isEqualToString:@":"]) {
            startIndexOfColon = i;
        }
        if ([specialCharacters rangeOfString:character].location != NSNotFound && i > (startIndexOfColon + 1) && startIndexOfColon) {
            NSRange range = NSMakeRange(startIndexOfColon, i - startIndexOfColon);
            NSString *placeholder = [pattern substringWithRange:range];
            if (![self checkIfContainsSpecialCharacter:placeholder]) {
                [placeholders addObject:placeholder];
                startIndexOfColon = 0;
            }
        }
        if (i == pattern.length - 1 && startIndexOfColon) {
            NSRange range = NSMakeRange(startIndexOfColon, i - startIndexOfColon + 1);
            NSString *placeholder = [pattern substringWithRange:range];
            if (![self checkIfContainsSpecialCharacter:placeholder]) {
                [placeholders addObject:placeholder];
            }
        }
    }
    
    __block NSString *parsedResult = pattern;
    
    [placeholders enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        idx = parameters.count > idx ? idx : parameters.count - 1;
        parsedResult = [parsedResult stringByReplacingOccurrencesOfString:obj withString:parameters[idx]];
    }];
    
    return parsedResult;
}

+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo
{
    MGJRouter *router = [MGJRouter sharedInstance];
    
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [router extractParametersFromURL:URL];
    MGJRouterObjectHandler handler = parameters[@"block"];
    
    if (handler) {
        if (userInfo) {
            parameters[MGJRouterParameterUserInfo] = userInfo;
        }
        [parameters removeObjectForKey:@"block"];
        return handler(parameters);
    }
    return nil;
}

+ (id)objectForURL:(NSString *)URL
{
    return [self objectForURL:URL withUserInfo:nil];
}

+ (void)registerURLPattern:(NSString *)URLPattern toObjectHandler:(MGJRouterObjectHandler)handler
{
    [[self sharedInstance] addURLPattern:URLPattern andObjectHandler:handler];
}

- (void)addURLPattern:(NSString *)URLPattern andHandler:(MGJRouterHandler)handler
{
    NSMutableDictionary *subRoutes = [self addURLPattern:URLPattern];
    if (handler && subRoutes) {
        subRoutes[@"_"] = [handler copy];
    }
}

- (void)addURLPattern:(NSString *)URLPattern andObjectHandler:(MGJRouterObjectHandler)handler
{
    NSMutableDictionary *subRoutes = [self addURLPattern:URLPattern];
    if (handler && subRoutes) {
        subRoutes[@"_"] = [handler copy];
    }
}

- (NSMutableDictionary *)addURLPattern:(NSString *)URLPattern
{
    //取出URL中所有路径
    NSArray *pathComponents = [self pathComponentsFromURL:URLPattern];
    
    NSInteger index = 0;
    NSMutableDictionary* subRoutes = self.routes;
    
    //遍历所有路径
    while (index < pathComponents.count)
    {
        NSString* pathComponent = pathComponents[index];
        if (![subRoutes objectForKey:pathComponent])
        {
            subRoutes[pathComponent] = [[NSMutableDictionary alloc] init];
        }
        subRoutes = subRoutes[pathComponent];
        index++;
    }
    return subRoutes;
}

#pragma mark - Utils

- (NSMutableDictionary *)extractParametersFromURL:(NSString *)url
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    
    parameters[MGJRouterParameterURL] = url;
    
    NSMutableDictionary* subRoutes = self.routes;
    NSArray* pathComponents = [self pathComponentsFromURL:url];
    
    BOOL found = NO;
    // borrowed from HHRouter(https://github.com/Huohua/HHRouter)
    for (NSString* pathComponent in pathComponents) {
        
        // 对 key 进行排序，这样可以把 ~ 放到最后
        NSArray *subRoutesKeys =[subRoutes.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 compare:obj2];
        }];
        
        for (NSString* key in subRoutesKeys) {
            if ([key isEqualToString:pathComponent] || [key isEqualToString:MGJ_ROUTER_WILDCARD_CHARACTER]) {
                found = YES;
                subRoutes = subRoutes[key];
                break;
            } else if ([key hasPrefix:@":"]) {
                found = YES;
                subRoutes = subRoutes[key];
                NSString *newKey = [key substringFromIndex:1];
                NSString *newPathComponent = pathComponent;
                // 再做一下特殊处理，比如 :id.html -> :id
                if ([self.class checkIfContainsSpecialCharacter:key]) {
                    NSCharacterSet *specialCharacterSet = [NSCharacterSet characterSetWithCharactersInString:specialCharacters];
                    NSRange range = [key rangeOfCharacterFromSet:specialCharacterSet];
                    if (range.location != NSNotFound) {
                        // 把 pathComponent 后面的部分也去掉
                        newKey = [newKey substringToIndex:range.location - 1];
                        NSString *suffixToStrip = [key substringFromIndex:range.location];
                        newPathComponent = [newPathComponent stringByReplacingOccurrencesOfString:suffixToStrip withString:@""];
                    }
                }
                parameters[newKey] = newPathComponent;
                break;
            }
        }
        
        // 如果没有找到该 pathComponent 对应的 handler，则以上一层的 handler 作为 fallback
        if (!found && !subRoutes[@"_"]) {
            return nil;
        }
    }
    
    // Extract Params From Query.
    NSArray* pathInfo = [url componentsSeparatedByString:@"?"];
    if (pathInfo.count > 1) {
        NSString* parametersString = [pathInfo objectAtIndex:1];
        NSArray* paramStringArr = [parametersString componentsSeparatedByString:@"&"];
        for (NSString* paramString in paramStringArr) {
            
            NSRange range = [paramString rangeOfString:@"="];
            if (range.length > 0) {
                NSString *key = [paramString substringToIndex:range.location];
                NSString *value = [paramString substringFromIndex:range.location + 1];
                
                //http链接进行urlDecode
                if ([value hasPrefix:@"http:"] || [value hasPrefix:@"https:"]) {
                    value = [value stringByRemovingPercentEncoding];
                }
                
                parameters[key] = value;
            }
            
            //payInfo=Base64： 如payInfo=xxxxRH0=，会把最后一个=裁剪掉，导致解析错误
//            NSArray* paramArr = [paramString componentsSeparatedByString:@"="];
//            if (paramArr.count > 1) {
//                NSString* key = [paramArr objectAtIndex:0];
//                NSString* value = [paramArr objectAtIndex:1];
//                parameters[key] = value;
//            }
        }
    }
    
    if (subRoutes[@"_"]) {
        parameters[@"block"] = [subRoutes[@"_"] copy];
    }
    
    return parameters;
}

- (void)removeURLPattern:(NSString *)URLPattern
{
    NSMutableArray *pathComponents = [NSMutableArray arrayWithArray:[self pathComponentsFromURL:URLPattern]];
    
    // 只删除该 pattern 的最后一级
    if (pathComponents.count >= 1) {
        // 假如 URLPattern 为 a/b/c, components 就是 @"a.b.c" 正好可以作为 KVC 的 key
        NSString *components = [pathComponents componentsJoinedByString:@"."];
        NSMutableDictionary *route = [self.routes valueForKeyPath:components];
        
        if (route.count >= 1) {
            NSString *lastComponent = [pathComponents lastObject];
            [pathComponents removeLastObject];
            
            // 有可能是根 key，这样就是 self.routes 了
            route = self.routes;
            if (pathComponents.count) {
                NSString *componentsWithoutLast = [pathComponents componentsJoinedByString:@"."];
                route = [self.routes valueForKeyPath:componentsWithoutLast];
            }
            [route removeObjectForKey:lastComponent];
        }
    }
}

- (NSArray*)pathComponentsFromURL:(NSString*)URL
{
    NSMutableArray *pathComponents = [NSMutableArray array];
    //NSRange range = [URL rangeOfString:@"://"];
    if (URL != nil && [URL rangeOfString:@"://"].location != NSNotFound) {
        NSArray *pathSegments = [URL componentsSeparatedByString:@"://"];
        // 如果 URL 包含协议，那么把协议作为第一个元素放进去
        [pathComponents addObject:pathSegments[0]];
        
        // 如果只有协议，那么放一个占位符
        if ((pathSegments.count == 2 && ((NSString *)pathSegments[1]).length) || pathSegments.count < 2) {
            [pathComponents addObject:MGJ_ROUTER_WILDCARD_CHARACTER];
        }
        
        URL = [URL substringFromIndex:[URL rangeOfString:@"://"].location + 3];
    }
    
    for (NSString *pathComponent in [[NSURL URLWithString:URL] pathComponents]) {
        if ([pathComponent isEqualToString:@"/"]) continue;
        if ([[pathComponent substringToIndex:1] isEqualToString:@"?"]) break;
        [pathComponents addObject:pathComponent];
    }
    return [pathComponents copy];
}

- (NSMutableDictionary *)routes
{
    if (!_routes) {
        _routes = [[NSMutableDictionary alloc] init];
    }
    return _routes;
}

#pragma mark - Utils

+ (BOOL)checkIfContainsSpecialCharacter:(NSString *)checkedString {
    NSCharacterSet *specialCharactersSet = [NSCharacterSet characterSetWithCharactersInString:specialCharacters];
    return [checkedString rangeOfCharacterFromSet:specialCharactersSet].location != NSNotFound;
}

@end



@implementation DHRouter
+ (void)setScheme:(NSString *)scheme
{
    [MGJRouter sharedInstance].scheme = scheme;
}

+ (void)registerURLPattern:(NSString *)URLPattern toHandler:(DHRouterHandler)handler
{
    URLPattern = [self schemeURLPattern:URLPattern];
    [MGJRouter registerURLPattern:URLPattern toHandler:handler];
}

+ (void)registerURLPattern:(NSString *)URLPattern toObjectHandler:(DHRouterObjectHandler)handler
{
    URLPattern = [self schemeURLPattern:URLPattern];
    [MGJRouter registerURLPattern:URLPattern toObjectHandler:handler];
}

+ (void)deregisterURLPattern:(NSString *)URLPattern
{
    URLPattern = [self schemeURLPattern:URLPattern];
    [MGJRouter deregisterURLPattern:URLPattern];
}


+ (void)openURL:(NSString *)URL
{
    NSString *schemeUrl = [self schemeURLPattern:URL];
    if ([MGJRouter canOpenURL:schemeUrl]) {
        [MGJRouter openURL:schemeUrl];
    } else {
        //兼容注册前未设置shceme的情况
        [MGJRouter openURL:URL];
    }
}

+ (void)openURL:(NSString *)URL completion:(DHRouterCompletionHandler)completion
{
    NSString *schemeUrl = [self schemeURLPattern:URL];
    if ([MGJRouter canOpenURL:schemeUrl]) {
        [MGJRouter openURL:schemeUrl completion:completion];
    } else {
        //兼容注册前未设置shceme的情况
        [MGJRouter openURL:URL completion:completion];
    }
}

+ (void)openURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(DHRouterCompletionHandler)completion
{
    NSString *schemeUrl = [self schemeURLPattern:URL];
    if ([MGJRouter canOpenURL:schemeUrl]) {
        [MGJRouter openURL:schemeUrl withUserInfo:userInfo completion:completion];
    } else {
        //兼容注册前未设置shceme的情况
        [MGJRouter openURL:URL withUserInfo:userInfo completion:completion];
    }
}

+ (id)objectForURL:(NSString *)URL
{
    NSString *schemeUrl = [self schemeURLPattern:URL];
    if ([MGJRouter canOpenURL:schemeUrl]) {
        return [MGJRouter objectForURL:schemeUrl];
    }
    
    //兼容注册前未设置shceme的情况
    return [MGJRouter objectForURL:URL];
}


+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo
{
    NSString *schemeUrl = [self schemeURLPattern:URL];
    if ([MGJRouter canOpenURL:schemeUrl]) {
        return [MGJRouter objectForURL:schemeUrl withUserInfo:userInfo];
    }
    
    //兼容注册前未设置shceme的情况
    return [MGJRouter objectForURL:URL withUserInfo:userInfo];
}

+ (BOOL)canOpenURL:(NSString *)URL
{
    NSString *schemeUrl = [self schemeURLPattern:URL];
    if ([MGJRouter canOpenURL:schemeUrl]) {
        return YES;
    }
    
    //兼容注册前未设置shceme的情况
    return [MGJRouter canOpenURL:URL];
}

+ (NSString *)generateURLWithPattern:(NSString *)pattern parameters:(NSArray *)parameters
{
    pattern = [self schemeURLPattern:pattern];
    return [MGJRouter generateURLWithPattern:pattern parameters:parameters];
}

+ (NSString *)generateJsonResult:(NSDictionary *)customParams isSucceed:(BOOL)isSucceed code:(NSInteger)code
{
    NSMutableDictionary *dicResult = [NSMutableDictionary dictionary];
    dicResult[@"result"] = customParams;
    dicResult[@"success"] = @(isSucceed);
    dicResult[@"code"] = @(code);
    
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dicResult options:0 error:&error];
    NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonData;
}

+ (NSMutableDictionary *)jsonParametersFromURL:(NSString *)url
{
    // Extract Params From Query.
    NSArray *pathInfo = [url componentsSeparatedByString:@"?"];
    if (pathInfo.count <= 1) {
        return nil;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSString *parametersString = [pathInfo objectAtIndex:1];
    NSArray *paramStringArr = [parametersString componentsSeparatedByString:@"&"];
    for (NSString* paramString in paramStringArr) {
        
        NSRange range = [paramString rangeOfString:@"="];
        if (range.length > 0) {
            NSString *key = [paramString substringToIndex:range.location];
            NSString *value = [paramString substringFromIndex:range.location + 1];
            
            //http链接进行urlDecode
            if ([value hasPrefix:@"http:"] || [value hasPrefix:@"https:"]) {
                value = [value stringByRemovingPercentEncoding];
            }
            
            //value转json格式，使用":"、"["判断是否可能是字典或数组格式
            id jsonValue = nil;
            if ([value containsString:@":"] || [value containsString:@"["]) {
                NSData *data = [value dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error;
                jsonValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            }
           
            if (jsonValue) {
                parameters[key] = jsonValue;
            } else {
                parameters[key] = value;
            }
        }
    }
        
    return parameters;
}

//MARK: - Private
/// 用于拼接预置的scheme
/// @param URLPattern 原始串
+ (NSString *)schemeURLPattern:(NSString *)URLPattern {
    //*未设置scheme的情况下，直接返回原始URLPattern
    if ([MGJRouter sharedInstance].scheme == nil) {
        return URLPattern;
    }
    
    //*URLPattern包含了自定义的scheme情况下，直接返回原始URLPattern
    if ([URLPattern rangeOfString:@"://"].location != NSNotFound) {
        return URLPattern;
    }
    
    //*URLPatter不包含scheme，则进行拼接处理;同时去除 /rn/notice及//rn/notice这种异常格式
    NSString *schemeUrl = URLPattern;
    if ([schemeUrl hasPrefix:@"//"]) {
        schemeUrl = [schemeUrl stringByReplacingCharactersInRange:NSMakeRange(0, 2) withString:@""];
    } else if ([URLPattern hasPrefix:@"/"]) {
        schemeUrl = [schemeUrl stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
    }
    
    NSString *scheme = [MGJRouter sharedInstance].scheme;
    schemeUrl = [NSString stringWithFormat:@"%@://%@", scheme, schemeUrl];
    
    return schemeUrl;
}

@end
