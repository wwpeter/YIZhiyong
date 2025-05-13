//
//  UITextFiledExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/3.
//

import UIKit

public extension Box where Base: UITextView {
    /// Clear text.
    func clear() {
        base.text = ""
        base.attributedText = NSAttributedString(string: "")
    }

    /// Scroll to the bottom of text view.
    func scrollToBottom() {
        let range = NSRange(location: (base.text as NSString).length - 1, length: 1)
        base.scrollRangeToVisible(range)
    }

    /// Scroll to the top of text view.
    func scrollToTop() {
        let range = NSRange(location: 0, length: 1)
        base.scrollRangeToVisible(range)
    }

    /// Wrap to the content (Text / Attributed Text).
    func wrapToContent() {
        base.contentInset = .zero
        base.scrollIndicatorInsets = .zero
        base.contentOffset = .zero
        base.textContainerInset = .zero
        base.textContainer.lineFragmentPadding = 0
        base.sizeToFit()
    }
}
