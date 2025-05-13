//
//  UINavigationItemExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/6.
//

import UIKit

extension Box where Base: UINavigationItem {
    /// Replace title label with an image in navigation item.
    ///
    /// - Parameter image: UIImage to replace title with.
    func replaceTitle(with image: UIImage) {
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.image = image
        base.titleView = logoImageView
    }
}
