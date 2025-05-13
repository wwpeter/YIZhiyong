//
//  HttpUtil.swift
//  Sleep
//
//  Created by slan-ww on 2022/10/17.
//

import Foundation

//class HttpUtil {
//    
//    /// 处理网络请求错误
//    ///
//    /// - Parameters:
//    ///   - baseResponse: <#baseResponse description#>
//    ///   - error: <#error description#>
//    static func handlerRequest(baseResponse:BaseResponse? = nil, error:Error? = nil) {
//        print("HttpUtil handlerRequest:\(String(describing: baseResponse)),\(String(describing: error))")
//        
//        if let error = error as? MoyaError {
//            //有错误
//            //error类似就是Moya.MoayError
//            switch error {
//            case .imageMapping(let response):
//                print("HttpUtil handlerRequest imageMapping:\(response)")
//                
//            case .stringMapping(let response):
//                Toast.showErrorWithStatus("响应转为字符串错误:\(response)，请稍后再试！")
//
//            case .statusCode(let response):
//                //响应码
//                let code = response.statusCode
//                
//                switch code {
//                case 401:
//                    printLog("")
//                case 403:
//                    printLog("")
//                case 404:
//                    printLog("")
//                case 500...599:
//                    printLog("")
//                    
//                default:
//                    HttpUtil.showUnknowError()
//                }
//                
//            case .underlying(let nsError as NSError, _):
//                switch nsError.code {
//                case NSURLErrorNotConnectedToInternet:
//                    Toast.showErrorWithStatus("网络好像不太好，请求稍后再试！")
//                case NSURLErrorTimedOut:
//                    Toast.showErrorWithStatus("网络好像不太好，请求稍后再试！")
//                default:
////                    ToastUtil.short("未知错误，请稍后再试！")
//                    HttpUtil.showUnknowError()
//                }
//                
//            case .requestMapping:
//                Toast.showErrorWithStatus("请求映射错误，请稍后再试！")
//            case .objectMapping:
//                Toast.showErrorWithStatus("对象映射错误，请稍后再试！")
//            case .parameterEncoding:
//                Toast.showErrorWithStatus("参数格式错误，请稍后再试！")
//            default:
//                print("HttpUtil handlerRequest other error")
//            }
//        } else {
//            //业务错误
//            if let baseResponse = baseResponse {
//                if let message = baseResponse.msg {
//                    //有错误提示
//                    Toast.showErrorWithStatus(message)
//                } else {
//                    //没有错误提示
//                    HttpUtil.showUnknowError()
//                }
//            } else {
//                HttpUtil.showUnknowError()
//            }
//        }
//    }
//    
//    /// 显示未知错误
//    static func showUnknowError() {
//        Toast.showErrorWithStatus("未知错误，请稍后再试！")
//    }
//    
//    /// 返回JSON编码的参数
//    ///
//    /// - Parameter parameters: 要编码的参数
//    /// - Returns: 编码后的Task
//    static func jsonRequestParamters(_ parameters:[String:Any]) -> Task {
//        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
//    }
//    
//    /// 返回URL编码的参数
//    ///
//    /// - Parameter parameters: <#parameters description#>
//    /// - Returns: <#return value description#>
//    static func urlRequestParamters(_ parameters:[String:Any]) -> Task {
//        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
//    }
//}
