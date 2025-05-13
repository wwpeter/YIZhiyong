//
//  UICollectionExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/6.
//

import UIKit

extension Box where Base: UICollectionView {
    /// 带回调的刷新
    func reloadData(_ completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            base.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}
