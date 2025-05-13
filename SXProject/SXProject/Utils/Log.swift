//
//  Log.swift
//  DigitalSleep
//
//  Created by ww on 2021/11/18.
//
//  通用Log文件

import Foundation

func printLog<T>(_ message: T...,
                 file: String = #file,
                 line: Int = #line,
                 column: Int = #column,
                 function: String = #function) {
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(function): \(message)")
    #endif
}
