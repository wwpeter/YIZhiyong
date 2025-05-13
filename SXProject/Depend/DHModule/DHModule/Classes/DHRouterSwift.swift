//
//  DHRouterSwift.swift
//  DHRouterSwift.swift
//
//  Created by iblue on 2020/7/16.
//  Copyright © 2020 iblue. All rights reserved.
//

import UIKit

private let DH_ROUTER_WILDCARD_CHARACTER = "~"
private let DH_ROUTER_SPECIAL_CHARACTER = "/?&."

///**
// *  result 执行完成的回调结果
// */
//public typealias DHRouterCompletionHandler = (_ result: Any?) -> Void
//
///**
// *  routerParameters 里内置的几个参数会用到上面定义的 string
// */
//public typealias DHRouterHandler = (_ routerParameters: [String: Any]?) -> Void
//
///**
// *  需要返回一个 object，配合 objectForURL: 使用
// */
//public typealias DHRouterObjectHandler = (_ routerParameters: [String: Any]?) -> Any?

@objc public class DHRouterSwift: NSObject {
    static let shared = DHRouterSwift()
    
    ///用于标识不同的项目
    var scheme: String? = nil

    /**
     *  保存了所有已注册的 URL
     *  结构类似 ["beauty": [":id": ["_", 闭包]]]

     */
    lazy var routes = NSMutableDictionary()
    
    /// 设置不同项目对应的scheme
    /// - Parameter scheme: 如果设置了该值，则在注册/使用的时候可以不用带scheme；如rn/notice，内部会自动拼接成 imou://rn/notice
    /// 如果没有设置该值，在注册/使用的时候都需要带上对应的scheme;
    @objc public class func setScheme(_ scheme: String) {
        shared.scheme = scheme
    }

    /// 注册 URLPattern 对应的 Handler，在 handler 中可以初始化 VC，然后对 VC 做各种操作
    ///
    /// - Parameters:
    ///   - urlPattern: 如果设置了scheme，则在注册/使用的时候可以不用带scheme；如rn/notice，内部会自动拼接成 imou://rn/notice
    ///   - handler: 该 闭包 会传一个字典，包含了注册的 URL 中对应的变量。假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
    @objc public class func registerHandler(urlPattern: String, handler: DHRouterHandler?) {
        shared.add(urlPattern, handler)
    }

    /// 注册 URLPattern 对应的 ObjectHandler，需要返回一个 object 给调用方
    ///
    /// - Parameters:
    ///   - urlPattern: 如果设置了scheme，则在注册/使用的时候可以不用带scheme；如rn/notice，内部会自动拼接成 imou://rn/notice
    ///   - handler: 该 block 会传一个字典，包含了注册的 URL 中对应的变量。
    ///                      假如注册的 URL 为 mgj://beauty/:id 那么，就会传一个 @{@"id": 4} 这样的字典过来
    ///                      自带的 key 为 @"url" 和 @"completion" (如果有的话)
    @objc public class func registerObjectHandler(urlPattern: String, handler: DHRouterObjectHandler?) {
        shared.add(urlPattern, handler)
    }

    /// 取消注册某个 URL Pattern
    ///
    /// - Parameter urlPattern: URLPattern
    @objc public class func deregister(urlPattern: String) {
        shared.remove(urlPattern)
    }

    /// 打开此 URL
    /// 会在已注册的 URL -> Handler 中寻找，如果找到，则执行 Handler
    ///
    /// - Parameter url: 带scheme时，直接打开；不带scheme时，内部进行拼接; 如rn/notice或imou://rn/notice
    @objc public class func open(url: String) {
        open(url: url, completion: nil)
    }

    /// 打开此 URL，同时当操作完成时，执行额外的代码
    ///
    /// - Parameters:
    ///   - url: 带scheme时，直接打开；不带scheme时，内部进行拼接; 如rn/notice或imou://rn/notice
    ///   - completion: URL 处理完成后的 callback，完成的判定跟具体的业务相关
    @objc public class func open(url: String, completion: DHRouterCompletionHandler?) {
        open(url: url, userInfo: nil, completion: completion)
    }

    /// 打开此 URL，带上附加信息，同时当操作完成时，执行额外的代码
    ///
    /// - Parameters:
    ///   - url: 带scheme时，直接打开；不带scheme时，内部进行拼接; 如rn/notice或imou://rn/notice
    ///   - userInfo: 附加参数
    ///   - completion: URL 处理完成后的 callback，完成的判定跟具体的业务相关
    @objc public class func open(url: String, userInfo: [String: Any]?, completion: ((_ result: Any?) -> Void)?) {
        //如果能够打开带自动拼接的schemeUrl，则用schemeUrl
        var urlPattern = url
        let schemeUrl = self.schemeUrlPattern(urlPattern: url)
        if checkCanOpen(urlPattern: schemeUrl) {
            urlPattern = schemeUrl
        }
        
        guard let urlString = urlPattern.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let parameters = shared.extractParameters(urlString, false)
        else {
            return
        }

        for (key, value) in parameters {
            if Mirror(reflecting: value).subjectType is NSString.Type {
                parameters[key] = (value as! NSString).replacingPercentEscapes(using: String.Encoding.utf8.rawValue)
            }
        }

        if parameters.allKeys.count > 0 {
            if completion != nil {
                parameters[DHRouterParameterCompletion] = completion
            }

            if userInfo != nil {
                parameters[DHRouterParameterUserInfo] = userInfo
            }

            if parameters["block"] != nil {
                let handler = parameters["block"] as? DHRouterHandler
                if handler != nil {
                    parameters.removeObject(forKey: "block")
                    handler?(parameters as? [String: Any])
                } else {
                    let objectHandler = parameters["block"] as? DHRouterObjectHandler
                    parameters.removeObject(forKey: "block")
                    _ = objectHandler?(parameters as? [String: Any])
                }
            }
        }
    }

    /// 查找谁对某个 URL 感兴趣，如果有的话，返回一个值
    ///
    /// - Parameter url: 带scheme时，直接打开；不带scheme时，内部进行拼接; 如rn/notice或imou://rn/notice
    /// - Returns: 返回值
    @objc public class func object(url: String) -> Any? {
        return object(url: url, userInfo: nil)
    }

    /// 查找谁对某个 URL 感兴趣，如果有的话，返回一个值
    ///
    /// - Parameters:
    ///   - url: 带scheme时，直接打开；不带scheme时，内部进行拼接; 如rn/notice或imou://rn/notice
    ///   - userInfo: 附加参数
    /// - Returns: 返回值
    @objc public class func object(url: String, userInfo: [String: Any]?) -> Any? {
        //如果能够打开带自动拼接的schemeUrl，则用schemeUrl
        let schemeUrl = self.schemeUrlPattern(urlPattern: url)
        var urlPattern = url
        if self.canOpen(url: schemeUrl) {
            urlPattern = schemeUrl
        }
        
        guard let urlString = urlPattern.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let parameters = shared.extractParameters(urlString, false)
        else {
            return nil
        }

        let handler = parameters["block"] as? DHRouterObjectHandler
        if handler != nil {
            if userInfo != nil {
                parameters[DHRouterParameterUserInfo] = userInfo
            }
            parameters.removeObject(forKey: "block")
            return handler?(parameters as? [String: Any])
        }

        return nil
    }

    /// 是否可以打开URL
    ///
    /// - Parameter url: 带 Scheme，如 mgj://beauty/3
    /// - Returns: 返回 Bool 值
    @objc public class func canOpen(url: String) -> Bool {
        return canOpen(url: url, matchExactly: true)
    }

    @objc public class func canOpen(url: String, matchExactly: Bool) -> Bool {
        let schemeUrl = DHRouterSwift.schemeUrlPattern(urlPattern: url)
        if shared.extractParameters(schemeUrl, matchExactly) != nil {
            return true
        }
        
        //兼容注册前未设置shceme的情况
        return (shared.extractParameters(url, matchExactly) != nil)
    }

    /// 调用此方法来拼接 urlpattern 和 parameters
    /// - Parameters:
    ///   - pattern: url pattern 比如 @"rn/notice"
    ///   - parameters: 一个数组，数量要跟 pattern 里的变量一致
    /// - Returns: 返回生成的URL String
    @objc public class func generateURL(pattern: String, parameters: [String]) -> String? {
        let pattern = DHRouterSwift.schemeUrlPattern(urlPattern: pattern)
        var startIndexOfColon = 0

        var placeholders = [String]()

        for i in 0 ..< pattern.count {
            let character = "\((pattern as NSString).character(at: i))"
            if character == ":" {
                startIndexOfColon = i
            }

            if DH_ROUTER_SPECIAL_CHARACTER.range(of: character) != nil && i > (startIndexOfColon + 1) && startIndexOfColon > 0 {
                let range = NSRange(location: startIndexOfColon, length: i - startIndexOfColon)
                let placeholder = (pattern as NSString).substring(with: range)

                if !shared.checkIfContains(placeholder) {
                    placeholders.append(placeholder)
                    startIndexOfColon = 0
                }
            }

            if i == pattern.count - 1 && startIndexOfColon > 0 {
                let range = NSRange(location: startIndexOfColon, length: i - startIndexOfColon + 1)
                let placeholder = (pattern as NSString).substring(with: range)

                if !shared.checkIfContains(placeholder) {
                    placeholders.append(placeholder)
                }
            }
        }

        var parsedResult = pattern
        for i in 0 ..< placeholders.count {
            let index = (parameters.count > i ? i : parameters.count - 1)
            parsedResult = parsedResult.replacingOccurrences(of: placeholders[i], with: parameters[index])
        }

        return parsedResult
    }
    
    /// 生成路由统一的返回Json串
    /// - Parameters:
    ///   - customParams: 自定义值
    ///   - isSucceed: 是否调用成功
    ///   - code: 默认100-成功
    @objc public static func generateJsonResult(customParams: [String : Any], isSucceed: Bool = true, code: Int = 100) -> String {
        var dicResult: [String: Any] = [String : Any]()
        dicResult["result"] = customParams
        dicResult["success"] = isSucceed
        dicResult["code"] = code
        return self.dicToString(dict: dicResult)
    }
    
    /// 将URL中的参数，全部转换成JSON结构
    /// - Parameter urlString: url
    /// - Returns: json结构
    @objc public static func jsonParameters(fromURL urlString: String) -> [String : Any]? {
        //如果url是标准的结构，直接使用；
        //如果是非标准结构，则需要手动转换，将 key=value取出来
        if let url = URL(string: urlString) {
            return url.jsonParameters()
        }
        
        guard let pathInfo = urlString.components(separatedBy: "?") as? [String], pathInfo.count > 1 else {
            return nil
        }
        
        var parameters = [String : Any]()
        guard let paramStringArr = (pathInfo[1] as? NSString)?.components(separatedBy: "&") else {
            return nil
        }
        
        paramStringArr.forEach { paramString in
            if let index = paramString.firstIndex(of: "=") {
                let key = String(paramString.prefix(upTo: index))
                var value = String(paramString.suffix(from: index))
                value = value.replacingCharacters(in: ...value.startIndex, with: "")
                parameters[key] = value
                if let jsonObject = value.jsonObject() {
                    parameters[key] = jsonObject
                }
            }
        }
        
        return parameters
    }
}

extension DHRouterSwift {
    
    /// 内部使用，不自动拼装scheme
    class func checkCanOpen(urlPattern: String) -> Bool {
        return (DHRouterSwift.shared.extractParameters(urlPattern, true) != nil)
    }
    
    func add(_ urlPattern: String, _ objectHandler: DHRouterObjectHandler?) {
        let subRoutes = add(urlPattern)
        if objectHandler != nil {
            subRoutes?["_"] = objectHandler
        }
    }

    func add(_ urlPattern: String, _ handler: DHRouterHandler?) {
        let subRoutes = add(urlPattern)
        if handler != nil {
            subRoutes?["_"] = handler
        }
    }

    func add(_ urlPattern: String) -> NSMutableDictionary? {
        let schemeUrlPattern = DHRouterSwift.schemeUrlPattern(urlPattern: urlPattern)
        guard let pathComponentsArr = pathComponents(schemeUrlPattern) else {
            return nil
        }

        var subRoutes = routes

        for component in pathComponentsArr {
            if subRoutes[component] == nil {
                subRoutes[component] = NSMutableDictionary()
            }

            if let subRoute = subRoutes[component] as? NSMutableDictionary {
                subRoutes = subRoute
            }
        }
        return subRoutes
    }

    func pathComponents(_ fromURL: String) -> [String]? {
        var url = fromURL as NSString
        var pathComponents = [String]()

        if url.range(of: "://").location != NSNotFound {
            let pathSegments = url.components(separatedBy: "://")
            // 如果 URL 包含协议，那么把协议作为第一个元素放进去
            pathComponents.append(pathSegments.first ?? "")

            // 如果只有协议，那么放一个占位符
            url = pathSegments.last as NSString? ?? ""
            if url.length == 0 {
                pathComponents.append(DH_ROUTER_WILDCARD_CHARACTER)
            }
        }

        //防止包含中文，进行urlEncode
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? url as String
        guard let pathComponentsArr = URL(string: urlString)?.pathComponents else {
            return pathComponents
        }

        for pathComponent in pathComponentsArr {
            if pathComponent == "/" {
                continue
            }

            if (pathComponent as NSString).substring(to: 1) == "?" {
                break
            }
            pathComponents.append(pathComponent)
        }

        return pathComponents
    }

    func extractParameters(_ fromURL: String, _ matchExactly: Bool) -> NSMutableDictionary? {
        let parameters = NSMutableDictionary()

        parameters[DHRouterParameterURL] = fromURL

        var subRoutes = routes
        guard let pathComponentsArr = pathComponents(fromURL) else {
            return nil
        }

        var found = false

        for pathComponent in pathComponentsArr {
            // 对 key 进行排序，这样可以把 ~ 放到最后
            let subRoutesKeys = subRoutes.allKeys.sorted { (key1, key2) -> Bool in
                switch (key1 as! String).compare(key2 as! String).rawValue {
                case 1:
                    return true
                case 0, -1:
                    return false
                default:
                    return false
                }
            }

            for key in subRoutesKeys as! [String] {
                if key == pathComponent || key == DH_ROUTER_WILDCARD_CHARACTER {
                    found = true
                    subRoutes = subRoutes[key] as! NSMutableDictionary
                    break
                } else if key.hasPrefix(":") {
                    found = true
                    subRoutes = subRoutes[key] as! NSMutableDictionary
                    var newKey = (key as NSString).substring(from: 1)
                    var newPathComponent = pathComponent

                    // 再做一下特殊处理，比如 :id.html -> :id
                    if checkIfContains(key) {
                        let DH_ROUTER_SPECIAL_CHARACTERet = CharacterSet(charactersIn: DH_ROUTER_SPECIAL_CHARACTER)
                        guard let initRange = key.rangeOfCharacter(from: DH_ROUTER_SPECIAL_CHARACTERet) else {
                            return nil
                        }
                        let range = nsRange(initRange, key)
                        if range.location != NSNotFound {
                            // 把 pathComponent 后面的部分也去掉
                            newKey = (newKey as NSString).substring(to: range.location - 1)
                            let suffixToStrip = (key as NSString).substring(from: range.location)
                            newPathComponent = (newPathComponent as NSString).replacingOccurrences(of: suffixToStrip, with: "")
                        }
                    }
                    parameters[newKey] = newPathComponent
                    break
                } else if matchExactly {
                    found = false
                }
            }

            if !found && (subRoutes["_"] == nil) {
                return nil
            }
        }

        // Extract Params From Query.
        guard let url = URL(string: fromURL), let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems else {
            if subRoutes["_"] != nil {
                parameters["block"] = subRoutes["_"]
            }

            return parameters
        }

        for item in queryItems {
            parameters[item.name] = item.value
        }

        if subRoutes["_"] != nil {
            parameters["block"] = subRoutes["_"]
        }

        return parameters
    }

    func remove(_ urlPattern: String) {
        let schemeUrlPattern = DHRouterSwift.schemeUrlPattern(urlPattern: urlPattern)
        guard var pathComponentsArr = pathComponents(schemeUrlPattern) else {
            return
        }

        // 只删除该 pattern 的最后一级
        if pathComponentsArr.count >= 1 {
            // 假如 URLPattern 为 a/b/c, components 就是 @"a.b.c" 正好可以作为 KVC 的 key
            let components = pathComponentsArr.joined(separator: ".")
            guard var route = routes.value(forKeyPath: components) as? NSMutableDictionary else {
                return
            }

            if route.count >= 1 {
                let lastComponent = pathComponentsArr.last ?? ""
                pathComponentsArr.removeLast()

                // 有可能是根 key，这样就是 self.routes 了
                route = routes
                if pathComponentsArr.count > 0 {
                    let componentsWithoutLast = pathComponentsArr.joined(separator: ".")
                    route = routes.value(forKeyPath: componentsWithoutLast) as! NSMutableDictionary
                }
                route.removeObject(forKey: lastComponent)
            }
        }
    }

    func checkIfContains(_ specialCharacter: String) -> Bool {
        let DH_ROUTER_SPECIAL_CHARACTERSet = CharacterSet(charactersIn: DH_ROUTER_SPECIAL_CHARACTER)

        guard let range = specialCharacter.rangeOfCharacter(from: DH_ROUTER_SPECIAL_CHARACTERSet) else {
            return false
        }
        return nsRange(range, specialCharacter).location != NSNotFound
    }

    func nsRange(_ fromRange: Range<String.Index>, _ specialCharacter: String) -> NSRange {
        return NSRange(fromRange, in: specialCharacter)
    }
    
    static func dicToString(dict:[String:Any]) -> String {
        var result: String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.init(rawValue: 0))
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                result = JSONString
            }
        } catch {
            result = ""
        }
        return result
    }
    
    static func schemeUrlPattern(urlPattern: String) -> String {
        //*未设置scheme的情况下，直接返回原始URLPattern
        guard shared.scheme != nil else {
            return urlPattern
        }
        
        //*URLPattern包含了自定义的scheme情况下，直接返回原始URLPattern
        if urlPattern.contains("://") {
            return urlPattern
        }
        
        //*URLPatter不包含scheme，则进行拼接处理;同时去除 /rn/notice及//rn/notice这种异常格式
        var schemeUrl = urlPattern
        if urlPattern.hasPrefix("//") {
            let index = schemeUrl.index(after: schemeUrl.startIndex)
            schemeUrl = schemeUrl.replacingCharacters(in: ...index, with: "")
        } else if urlPattern.hasPrefix("/") {
            schemeUrl = schemeUrl.replacingCharacters(in: ...schemeUrl.startIndex, with: "")
        }
        
        schemeUrl = shared.scheme! + "://" + schemeUrl
        return schemeUrl
    }
}


//MARK: - URL Parameters
extension URL {
    func jsonParameters() -> [String : Any]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
        let queryItems = components.queryItems else {
            return nil
        }
        
        return queryItems.reduce(into: [String: Any]()) { (result, item) in
            result[item.name] = item.value
            //对value做进一步转化
            if let jsonObject = item.value?.jsonObject() {
                result[item.name] = jsonObject
            }
        }
    }
}


extension String {
    
    /// 转换成json格式 数组或字典
    /// - Returns: 转换成功返回对应的object
    func jsonObject() -> Any? {
        guard self.contains(":") || self.contains("[") else {
            return nil
        }
        
        if let data = self.data(using: .utf8), let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
            return json
        }
        
        return nil
    }
}
