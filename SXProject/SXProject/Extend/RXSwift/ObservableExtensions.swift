//
//  ObservableExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/3.
//

import Foundation

/// 自定义错误
///
/// - objectMapping: 表示JSON解析为对象失败
public enum IxueaError: Swift.Error {
    case objectMapping
}
/*
public extension Observable {
    
    /// 映射成模型对象
    func mapObject<T: Codable>(_ type: T.Type) -> Observable<T> {
        return self.map { data in
            
            printLog(data)
            if let tempData = data as? Data,
               let result = try? JSONDecoder().decode(T.self, from: tempData) {
                //解析成功
                //返回解析后的对象
                return result
            } else {
                // 解析错误
                printLog("")
                throw IxueaError.objectMapping
            }
            //将参数尝试转为字符串
//            guard let result = try? JSONDecoder().decode(BaseModel<Bool>.self, from: data as! Data) else {
//                //转为对象失败
//                throw IxueaError.objectMapping
//            }
//
            //解析成功
            //返回解析后的对象
//            return result
        }
    }
}*/

////http网络请求观察者
//public class HttpObserver<Element>: ObserverType {
//    
//    /// ObserverType协议中用到了泛型E
//    /// 所以说子类中就要指定E这个泛型
//    /// 不然就会报错
//    public typealias Ele = Element
//    
//    /// 请求成功回调
//    var onSuccess: ((Ele) -> Void)
//    
//    /// 请求失败回调
//    var onError: ((BaseResponse?, Error?) -> Bool)?
//    
//    /// 构造方法
//    ///
//    /// - Parameters:
//    ///   - onSuccess: 请求成功的回调
//    ///   - onError: 请求失败的回调
//    init(_ onSuccess: @escaping ((Ele) -> Void), _ onError: ((BaseResponse?, Error?) -> Bool)? ) {
//        self.onSuccess = onSuccess
//        self.onError = onError
//    }
//    
//    /// 当RxSwift框架里面发送了事件回调
//    ///
//    /// - Parameter event: event description
//    public func on(_ event: Event<Element>) {
//        switch event {
//        case .next(let value):
//            //next事件
//            print("HttpObserver next:\(value)")
//            
//            //将值尝试转为BaseResponse
//            let baseResponse = value as? BaseResponse
//            
//            if let _ = baseResponse?.code {
//                //有状态码
//                //表示请求出错了
//                requestErrorHandler(baseResponse:baseResponse)
//            } else {
//                //请求正常
//                onSuccess(value)
//            }
//        case .error(let error):
//            //请求失败
//            print("HttpObserver error:\(error)")
//            
//            //处理错误
//            requestErrorHandler(error:error)
//            
//        case .completed:
//            //请求完成
//            print("HttpObserver completed")
//        }
//    }
//    
//    /// 处理请求错误
//    ///
//    /// - Parameters:
//    ///   - baseResponse: 请求返回的对象
//    ///   - error: 错误信息
//    func requestErrorHandler(baseResponse:BaseResponse? = nil, error:Error? = nil) {
//        if onError != nil && onError!(baseResponse, error) {
//            //回调了请求失败方法
//            //并且该方法返回了true
//            
//            //返回true就表示外部手动处理错误
//            //那我们框架内部就不用做任何事情了
//        } else {
//            //要自动处理错误
//            HttpUtil.handlerRequest(baseResponse:baseResponse, error:error)
//        }
//    }
//}
// MARK: - 扩展ObservableType
//// 目的是添加两个自定义监听方法
//// 一个是只观察请求成功的方法
//// 一个既可以观察请求成功也可以观察请求失败
//extension ObservableType {
//    
//    /// 观察成功和失败事件
//    ///
//    /// - Parameters:
//    ///   - onSuccess: 请求成功的回调
//    ///   - onError: 请求失败的回调
//    /// - Returns: return value description
//    func subscribe( _ onSuccess: @escaping ((Element) -> Void), _ onError: @escaping ((BaseResponse?, Error?) -> Bool) ) -> Disposable {
//        
//        //创建一个Disposable
//        let disposable = Disposables.create()
//        
//        //创建一个HttpObserver
//        let observer = HttpObserver<Element>(onSuccess, onError)
//        
//        //创建并返回一个Disposables
//        return Disposables.create(self.asObservable().subscribe(observer), disposable)
//    }
//    
//    /// 观察成功的事件
//    ///
//    /// - Parameter onSuccess: onSuccess description
//    /// - Returns: return value description
//    func subscribeOnSuccess(_ onSuccess: @escaping ((Element) -> Void) ) -> Disposable {
//        let disposable = Disposables.create()
//        
//        let observer = HttpObserver<Element>(onSuccess, nil)
//        
//        return Disposables.create(self.asObservable().subscribe(observer), disposable)
//    }
//}
//
