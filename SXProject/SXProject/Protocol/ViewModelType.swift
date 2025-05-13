//
//  ViewModelType.swift
//  Sleep
//
//  Created by slan-ww on 2022/10/31.
//

import Foundation

/// viewmodel 必须遵守的协议
protocol ViewModelType {
    // 输入包括（网络、UI交互事件、数据库等）
    associatedtype Input
    // 输出响应式可绑定的对象（combine（推荐）、RxSwift）
    associatedtype Output
    // 服务
    associatedtype Dependency
    // 通过实现该方法将输入事件转化为可绑定的对象
    func transform(input: Input, dependency: Dependency) -> Output
}

class BaseViewModel {
    //let disposeBag = DisposeBag()
}
