//
//  StringExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/3.
//

import Foundation

extension String: BoxCompatible {}
public extension Box where Base == String {
    
    // String decoded from base64 (if applicable).
    ///
    ///        "SGVsbG8gV29ybGQh".base64Decoded = Optional("Hello World!")
    ///
    var base64Decoded: String? {
        if let data = Data(base64Encoded: base,
                           options: .ignoreUnknownCharacters) {
            return String(data: data, encoding: .utf8)
        }
        
        let remainder = base.count % 4

        var padding = ""
        if remainder > 0 {
            padding = String(repeating: "=", count: 4 - remainder)
        }

        guard let data = Data(base64Encoded: base + padding,
                              options: .ignoreUnknownCharacters) else { return nil }

        return String(data: data, encoding: .utf8)
    }

    /// String encoded in base64 (if applicable).
    ///
    ///        "Hello World!".base64Encoded -> Optional("SGVsbG8gV29ybGQh")
    ///
    var base64Encoded: String? {
        // https://github.com/Reza-Rg/Base64-Swift-Extension/blob/master/Base64.swift
        let plainData = base.data(using: .utf8)
        return plainData?.base64EncodedString()
    }
    
    /// Is a Email
    var isValidEmail: Bool {
        // http://emailregex.com/
        let regex =
            "^(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])$"
        return base.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    /// Check if string is a valid URL.
    ///
    ///        "https://google.com".isValidUrl -> true
    ///
    var isValidUrl: Bool {
        return URL(string: base) != nil
    }
    
    /// Readable string from a URL string.
    ///
    ///        "it's%20easy%20to%20decode%20strings".urlDecoded -> "it's easy to decode strings"
    ///
    var urlDecoded: String {
        return base.removingPercentEncoding ?? base
    }

    /// URL escaped string.
    ///
    ///        "it's easy to encode strings".urlEncoded -> "it's%20easy%20to%20encode%20strings"
    ///
    var urlEncoded: String {
        return base.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    /// mappingViewController
    var mappingViewController: UIViewController? {
        //1、获swift中的命名空间名
        var name = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as? String
        //2、如果包名中有'-'横线这样的字符，在拿到包名后，还需要把包名的'-'转换成'_'下横线
        name = name?.replacingOccurrences(of: "-", with: "_")
        //3、拼接命名空间和类名，”包名.类名“
        let fullClassName = name! + "." + base
        let classType = NSClassFromString(fullClassName) as? UIViewController.Type
        return classType?.init()
    }
    
    ///  随机字符串
    static func random(ofLength length: Int) -> String {
        guard length > 0 else { return "" }
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString = ""
        for _ in 1...length {
            randomString.append(base.randomElement()!)
        }
        return randomString
    }
    
    subscript(safe index: Int) -> Character? {
        guard index >= 0 && index < base.count else { return nil }
        return base[base.index(base.startIndex, offsetBy: index)]
    }
    
    func appendingPathComponent(_ str: String) -> String {
        return (base as NSString).appendingPathComponent(str)
    }
}
