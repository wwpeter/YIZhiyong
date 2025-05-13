//
//  WW.swift
//  DigitalSleep
//
//  Created by ww on 2021/11/18.
//
//  自定义扩展依赖的基础协议
//  用途：可以统一扩展的调用入口

import Foundation

public struct Box<Base> {
    /// Base object to extend.
    public var base: Base

    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Base) {
        self.base = base
    }
}

/// A type that has Box extensions.
public protocol BoxCompatible {
    /// Extended type
    associatedtype BoxBase

    /// Box extensions.
    static var sx: Box<BoxBase>.Type { get set }

    /// Box extensions.
    var sx: Box<BoxBase> { get set }
}

public extension BoxCompatible {
    /// Box extensions.
    static var sx: Box<Self>.Type {
        get { Box<Self>.self }
        // this enables using Box to "mutate" base type
        // swiftlint:disable:next unused_setter_value
        set { }
    }

    /// Box extensions.
    var sx: Box<Self> {
        get { Box(self) }
        // this enables using Box to "mutate" base object
        // swiftlint:disable:next unused_setter_value
        set { }
    }
}

extension NSObject: BoxCompatible {}
