//
//  DHRouterDefine.h
//  Pods
//
//  Created by iblue on 2020/7/17.
//

#ifndef DHRouterDefine_h
#define DHRouterDefine_h

extern NSString *const DHRouterParameterURL;
extern NSString *const DHRouterParameterCompletion;
extern NSString *const DHRouterParameterUserInfo;

/**
 *  result 完成的执行结果
 */
typedef void (^DHRouterCompletionHandler)(id result);

/**
 *  routerParameters 里内置的几个参数会用到上面定义的 string
 */
typedef void (^DHRouterHandler)(NSDictionary<NSString *, id> *routerParameters);

/**
 *  需要返回一个 object，配合 objectForURL: 使用
 */
typedef id (^DHRouterObjectHandler)(NSDictionary<NSString *, id> *routerParameters);


#endif /* DHRouterDefine_h */
