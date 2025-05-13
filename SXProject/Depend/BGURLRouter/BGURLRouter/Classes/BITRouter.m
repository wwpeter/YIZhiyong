//
//  BITRouter.m
//  Pods
//
//  Created by jiaguoshang on 18/9/30.
//
//

#import "BITRouter.h"
#import <objc/runtime.h>


static NSString * const BIT_ROUTER_WILDCARD_CHARACTER = @"~";

NSString *const BITRouterParameterURL = @"BITRouterParameterURL";
NSString *const BITRouterParameterCompletion = @"BITRouterParameterCompletion";
NSString *const BITRouterParameterUserInfo = @"BITRouterParameterUserInfo";

@interface BITRouter ()
/**
 *  保存了所有已注册的 URL
 *  结构类似 @{@"beauty": @{@":id": {@"_", [block copy]}}}
 */
@property (nonatomic) NSMutableDictionary *routes;

@property (nonatomic, weak) id<BITRouterDelegate> delegate;

@property NSMutableArray *replaceRuleList;

@end

@implementation BITRouter

static inline BOOL BIT_IS_EMPTY(id thing) {
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

+ (instancetype)sharedIsntance
{
    static BITRouter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)loadReplaceRuleList:(NSArray *)replaceList
{
    [[self sharedIsntance] setValue:[NSMutableArray arrayWithArray:replaceList] forKey:@"replaceRuleList"];
}

+ (void)setDelegate:(id<BITRouterDelegate>)delegate
{
    [[self sharedIsntance] setDelegate:delegate];
}

+ (void)registerURLPattern:(NSString *)URLPattern toHandler:(BITRouterHandler)handler
{
    [[self sharedIsntance] addURLPattern:URLPattern andHandler:handler];
}

+ (void)deregisterURLPattern:(NSString *)URLPattern
{
    [[self sharedIsntance] removeURLPattern:URLPattern];
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
    URL = [URL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    BITRouter *router = [BITRouter sharedIsntance];
    
    if (URL.length > 0) {
        NSMutableString *result = [NSMutableString stringWithString:URL];
        for (NSDictionary *rule in router.replaceRuleList) {
            NSError *error = nil;
            NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:rule[@"pattern"] options:0 error:&error];
            if (!error) {
                NSInteger matches = [reg replaceMatchesInString:result options:0 range:NSMakeRange(0, result.length) withTemplate:rule[@"replace"]];
                if (matches > 0) {
                    break;
                }
            }
        }
        URL = result;
    }
    
    if (!URL) {
        if ([router.delegate respondsToSelector:@selector(router:didFailOpenWithURL:withUserInfo:)]) {
            [router.delegate router:router didFailOpenWithURL:@"nil" withUserInfo:userInfo];
        }
        return;
    }
    
    if ([router.delegate respondsToSelector:@selector(router:shouldOpenURL:withUserInfo:completion:)]&& ![router.delegate router:router shouldOpenURL:URL withUserInfo:userInfo completion:completion]) {
        return;
    }
    
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [router extractParametersFromURL:URL];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, NSString *obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            parameters[key] = [obj stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }];
    
    BITRouterHandler handler = parameters[@"block"];
    if (handler) {
        
        if ([router.delegate respondsToSelector:@selector(router:willOpenURL:withUserInfo:)]) {
            [router.delegate router:router willOpenURL:URL withUserInfo:userInfo];
        }
        
        if (completion) {
            parameters[BITRouterParameterCompletion] = completion;
        }
        if (userInfo) {
            parameters[BITRouterParameterUserInfo] = userInfo;
        }
        
        [parameters removeObjectForKey:@"block"];
        
        // 让 handler 都在主线程中执行，避免出现各种诡异的问题
        if ([NSThread isMainThread]) {
            handler(parameters);
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                handler(parameters);
            });
        }
    }
    else {
        if ([router.delegate respondsToSelector:@selector(router:didFailOpenWithURL:withUserInfo:)]) {
            [router.delegate router:router didFailOpenWithURL:URL withUserInfo:userInfo];
        }
    }
}

#pragma mark - pop到指定的一个界面

+ (void)popToURL:(NSString *)URL
{
    [self popToURL:URL completion:nil];
}

+ (void)popToURL:(NSString *)URL completion:(void (^)(id))completion
{
    [self popToURL:URL withUserInfo:nil completion:completion];
}

+ (void)popToURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo completion:(void (^)(id))completion
{
    URL = [URL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    BITRouter *router = [BITRouter sharedIsntance];
    
    if (URL.length > 0) {
        NSMutableString *result = [NSMutableString stringWithString:URL];
        for (NSDictionary *rule in router.replaceRuleList) {
            NSError *error = nil;
            NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:rule[@"pattern"] options:0 error:&error];
            if (!error) {
                NSInteger matches = [reg replaceMatchesInString:result options:0 range:NSMakeRange(0, result.length) withTemplate:rule[@"replace"]];
                if (matches > 0) {
                    break;
                }
            }
        }
        URL = result;
    }
    
    if (!URL) {
        if ([router.delegate respondsToSelector:@selector(router:didFailOpenWithURL:withUserInfo:)]) {
            [router.delegate router:router didFailOpenWithURL:@"nil" withUserInfo:userInfo];
        }
        return;
    }
    
    if ([router.delegate respondsToSelector:@selector(router:shouldOpenURL:withUserInfo:completion:)]&& ![router.delegate router:router shouldOpenURL:URL withUserInfo:userInfo completion:completion]) {
        return;
    }
    
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [router extractParametersFromURL:URL];
    
    [parameters enumerateKeysAndObjectsUsingBlock:^(id key, NSString *obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            parameters[key] = [obj stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
    }];
    
    BITRouterHandler handler = parameters[@"block"];
    if (handler) {
        
        if ([router.delegate respondsToSelector:@selector(router:willOpenURL:withUserInfo:)]) {
            [router.delegate router:router willOpenURL:URL withUserInfo:userInfo];
        }
        
        if (completion) {
            parameters[BITRouterParameterCompletion] = completion;
        }
        if (userInfo) {
            parameters[BITRouterParameterUserInfo] = userInfo;
        }
        
        [parameters removeObjectForKey:@"block"];
        
        //标示此种形式下是pop方式,参数字典中加key值"isPop"
        [parameters setObject:@(YES) forKey:@"isPop"];
        
        // 让 handler 都在主线程中执行，避免出现各种诡异的问题
        if ([NSThread isMainThread]) {
            handler(parameters);
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                handler(parameters);
            });
        }
    }
    else {
        if ([router.delegate respondsToSelector:@selector(router:didFailOpenWithURL:withUserInfo:)]) {
            [router.delegate router:router didFailOpenWithURL:URL withUserInfo:userInfo];
        }
    }
}



+ (BOOL)canOpenURL:(NSString *)URL
{
    return [[self sharedIsntance] extractParametersFromURL:URL] ? YES : NO;
}

+ (NSString *)generateURLWithPattern:(NSString *)pattern parameters:(NSArray *)parameters
{
    NSInteger startIndexOfColon = 0;
    NSMutableArray *items = [[NSMutableArray alloc] init];
    NSInteger parameterIndex = 0;
    
    for (int i = 0; i < pattern.length; i++) {
        NSString *character = [NSString stringWithFormat:@"%c", [pattern characterAtIndex:i]];
        if ([character isEqualToString:@":"]) {
            startIndexOfColon = i;
        }
        if (([@[@"/", @"?", @"&"] containsObject:character] || (i == pattern.length - 1 && startIndexOfColon) ) && startIndexOfColon) {
            if (i > (startIndexOfColon + 1)) {
                [items addObject:[NSString stringWithFormat:@"%@%@", [pattern substringWithRange:NSMakeRange(0, startIndexOfColon)], parameters[parameterIndex++]]];
                pattern = [pattern substringFromIndex:i];
                i = 0;
            }
            startIndexOfColon = 0;
        }
    }
    
    return [items componentsJoinedByString:@""];
}

+ (NSString *)rewriteURLIfNeeded:(NSString *)url
{
    BITRouter *router = [BITRouter sharedIsntance];
    
    if (url.length > 0) {
        NSMutableString *result = [NSMutableString stringWithString:url];
        for (NSDictionary *rule in router.replaceRuleList) {
            NSError *error = nil;
            NSRegularExpression *reg = [[NSRegularExpression alloc] initWithPattern:rule[@"pattern"] options:0 error:&error];
            if (!error) {
                NSInteger matches = [reg replaceMatchesInString:result options:0 range:NSMakeRange(0, result.length) withTemplate:rule[@"replace"]];
                if (matches > 0) {
                    break;
                }
            }
        }
        url = result;
    }
    return url;
}

+ (void)registerURLPattern:(NSString *)URLPattern toObjectHandler:(BITRouterObjectHandler)handler
{
    [[self sharedIsntance] addURLPattern:URLPattern andObjectHandler:handler];
}

+ (id)objectForURL:(NSString *)URL withUserInfo:(NSDictionary *)userInfo
{
    BITRouter *router = [BITRouter sharedIsntance];
    
    URL = [URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *parameters = [router extractParametersFromURL:URL isForObject:YES];
    BITRouterObjectHandler handler = parameters[@"block"];
    
    if (handler) {
        if (userInfo) {
            parameters[BITRouterParameterUserInfo] = userInfo;
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

#pragma mark - Utils

- (NSMutableDictionary *)extractParametersFromURL:(NSString *)url isForObject:(BOOL)is
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    
    parameters[BITRouterParameterURL] = url;
    
    NSMutableDictionary* subRoutes = self.routes;
    NSArray* pathComponents = [self pathComponentsFromURL:url];
    
    for (NSString* pathComponent in pathComponents) {
        BOOL found = NO;
        
        // 对 key 进行排序，这样可以把 ~ 放到最后
        NSArray *subRoutesKeys =[subRoutes.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            return [obj1 compare:obj2];
        }];
        
        for (NSString* key in subRoutesKeys) {
            if ([key isEqualToString:pathComponent] || [key isEqualToString:BIT_ROUTER_WILDCARD_CHARACTER]) {
                found = YES;
                subRoutes = subRoutes[key];
                break;
            } else if ([key hasPrefix:@":"]) {
                found = YES;
                subRoutes = subRoutes[key];
                parameters[[key substringFromIndex:1]] = pathComponent;
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
            NSArray* paramArr = [paramString componentsSeparatedByString:@"="];
            if (paramArr.count > 1) {
                NSString* key = [[paramArr objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString* value = [[paramArr objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                parameters[key] = value;
            }
        }
    }
    
    if (is) {
        if (subRoutes[@"_object_"]) {
            parameters[@"block"] = [subRoutes[@"_object_"] copy];
        }
    } else {
        if (subRoutes[@"_"]) {
            parameters[@"block"] = [subRoutes[@"_"] copy];
        }
    }
    
    return parameters;
}

- (NSMutableDictionary *)extractParametersFromURL:(NSString *)url
{
    return [self extractParametersFromURL:url isForObject:NO];
}

- (NSMutableDictionary *)addURLPattern:(NSString *)URLPattern
{
    NSArray *pathComponents = [self pathComponentsFromURL:URLPattern];
    
    NSInteger index = 0;
    NSMutableDictionary* subRoutes = self.routes;
    
    while (index < pathComponents.count) {
        NSString* pathComponent = pathComponents[index];
        if (![subRoutes objectForKey:pathComponent]) {
            subRoutes[pathComponent] = [[NSMutableDictionary alloc] init];
        }
        subRoutes = subRoutes[pathComponent];
        index++;
    }
    return subRoutes;
}

- (void)addURLPattern:(NSString *)URLPattern andHandler:(BITRouterHandler)handler
{
    NSMutableDictionary *subRoutes = [self addURLPattern:URLPattern];
    if (handler && subRoutes) {
        subRoutes[@"_"] = [handler copy];
    }
}

- (void)addURLPattern:(NSString *)URLPattern andObjectHandler:(BITRouterObjectHandler)handler
{
    NSMutableDictionary *subRoutes = [self addURLPattern:URLPattern];
    if (handler && subRoutes) {
        subRoutes[@"_object_"] = [handler copy];
    }
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
    if ([URL rangeOfString:@"://"].location != NSNotFound) {
        NSArray *pathSegments = [URL componentsSeparatedByString:@"://"];
        // 如果 URL 包含协议，那么把协议作为第一个元素放进去
        [pathComponents addObject:pathSegments[0]];
        
        // 如果只有协议，那么放一个占位符
        if ((pathSegments.count == 2 && BIT_IS_EMPTY(pathSegments[1])) || pathSegments.count < 2) {
            [pathComponents addObject:BIT_ROUTER_WILDCARD_CHARACTER];
        }
        
        URL = [URL substringFromIndex:[URL rangeOfString:@"://"].location + 3];
        
        // 修复特定的 URL，比如 Pinterest 会返回 pinxxx://?success=0
        if (URL.length && [[URL substringToIndex:1] isEqualToString:@"?"]) {
            URL = [URL substringFromIndex:1];
        }
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


@end
