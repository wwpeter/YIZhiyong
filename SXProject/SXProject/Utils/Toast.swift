//
//  Toast.swift
//  Sleep
//
//  Created by slan-ww on 2022/10/12.
//

import Foundation

//闭包
typealias BaseBlock = () -> Void

class Toast {
    
    @objc
    class func swiftload() {
        // do something
        print("swift initialize")
        SVProgressHUD.setDefaultAnimationType(.flat)
        SVProgressHUD.setDefaultMaskType(.black)
        //设置对话框样式
        SVProgressHUD.setInfoImage(UIImage.init(named: "") ?? UIImage())//AssetImages.home.image
        SVProgressHUD.setSuccessImage(UIImage.init(named: "") ?? UIImage())
        SVProgressHUD.setErrorImage(UIImage.init(named: "") ?? UIImage())
//        SVProgressHUD.setMinimumDismissTimeInterval(2)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setBorderColor(AssetColors.bccc.color)
//        SVProgressHUD.setForegroundColor(AssetColors.red.color)
        SVProgressHUD.setCornerRadius(4.0)
    }
    
    //展示菊花
    static func showWaiting() {
        SVProgressHUD.setMinimumSize(.zero)
        SVProgressHUD.show()
    }
    
    /// loading展示文字
    ///
    /// - Parameters:
    /// - message:展示文字提示
    ///
    static func showMessage(_ message: String) {
        SVProgressHUD.setMinimumSize(CGSize(width: kSizeScreenWidth / 3 * 2, height: 0))
        SVProgressHUD.show(withStatus: message)
        SVProgressHUD.dismiss(withDelay: 2.0)
    }
    
    /// loading展示文字
    ///
    ///   - Parameters:
    ///    - message:展示文字提示
    ///
    static func showInfoMessage(_ message: String) {
//        SVProgressHUD.setMinimumSize(CGSize(width: kSizeScreenWidth / 4 * 2, height: 0))
//        SVProgressHUD.showInfo(withStatus: message)
        SVProgressHUD.setDefaultMaskType(.none)
        SVProgressHUD.setImageViewSize(CGSize(width: 0, height: 0))
      
        SVProgressHUD.showError(withStatus: message)
        
        SVProgressHUD.dismiss(withDelay: 1.0)
    }
    
    //传入展示时间
    static func showProgress(_ progress: Float) {
        SVProgressHUD.setMinimumSize(CGSize(width: kSizeScreenWidth / 3 * 2, height: 0))
        SVProgressHUD.showProgress(progress)
    }
    
    /// loading展示成功状态
    ///
    ///   - Parameters:
    ///    - status:展示成功状态
    ///
    static func showSuccessWithStatus(_ status: String) {
        SVProgressHUD.setMinimumSize(CGSize(width: kSizeScreenWidth / 3 * 2, height: 0))
        SVProgressHUD.showSuccess(withStatus: status)
        SVProgressHUD.dismiss(withDelay: 2.0)
    }
    
    //展示错误提示
    static func showErrorWithStatus(_ status: String) {
        SVProgressHUD.setMinimumSize(CGSize(width: kSizeScreenWidth / 3 * 2, height: 0))
        SVProgressHUD.showError(withStatus: status)
        SVProgressHUD.dismiss(withDelay: 2.0)
    }
    
    //
    static func showLongMessage(_ message: String) {
        SVProgressHUD.setMinimumSize(CGSize(width: kSizeScreenWidth / 3 * 2, height: 0))
        SVProgressHUD.showProgress(-1, status: message)
    }
    
    //关闭菊花
    static func closeWaiting() {
        SVProgressHUD.dismiss()
    }
    
    /// loading消失带回调
    ///
    ///   - Parameters:
    ///    - completion:闭包回调
    ///
    static func dismissWithCompletion(_ completion:@escaping BaseBlock) {
        SVProgressHUD.dismiss {
           completion()
        }
    }
    
    /// loading消失带回调带时间
    ///
    ///   - Parameters:
    ///    - delay:时间
    ///    - completion:闭包回调
    static func dismissWithDelay(_ delay: TimeInterval, completion:@escaping BaseBlock) {
        SVProgressHUD.dismiss(withDelay: delay) {
            completion()
        }
    }
    
    //多少时间后消失
    static func dismissWithDelay(_ delay: TimeInterval) {
        SVProgressHUD.dismiss(withDelay: delay)
    }
    
    //
    static func isVisible() {
        SVProgressHUD.isVisible()
    }
}
