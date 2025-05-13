//
//  UISearchBarExtensions.swift
//  DigitalSleep
//
//  Created by sx on 2021/12/6.
//

import UIKit

extension Box where Base: UISearchBar {
    /// Text field inside search bar (if applicable).
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return base.searchTextField
        }
        let subViews = base.subviews.flatMap(\.subviews)
        guard let textField = subViews.first(where: { $0 is UITextField }) as? UITextField else {
            return nil
        }
        return textField
    }
}
