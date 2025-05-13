//
//  AlertViewSystem.swift
//  SXProject
//
//  Created by 王威 on 2025/4/2.
//

import UIKit

class AlertViewSystem: UIView {
    
     /// 使用代码创建一个View会调用该构造方法
     ///
     /// - Parameter frame: <#frame description#>
     override init(frame: CGRect) {
         super.init(frame: frame)
         
         initViews()
     }
     
     @available(*, unavailable)
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func layoutSubviews() {
         super.layoutSubviews()
         
         self.initViewLayouts()
     }
     
     //MARK: - initialize
     func initViews() {
         self.backgroundColor = AssetColors.b00030.color
         addSubview(contentView)
         contentView.addSubview(groundImg)
         contentView.addSubview(closeBut)
         contentView.addSubview(titleLabel)
         contentView.addSubview(subLabel)
         contentView.addSubview(su2bLabel)
         contentView.addSubview(su3bLabel)
         
         contentView.addSubview(submitBut)
     }
     
     func initViewLayouts() {
         contentView.snp.makeConstraints { make in
             make.centerY.equalTo(self.snp.centerY).offset(sxDynamic(-60))
             make.height.equalTo(sxDynamic(270))
             make.leading.equalTo(self.snp.leading).offset(sxDynamic(30))
             make.right.equalTo(self.snp.right).offset(sxDynamic(-30))
         }
         groundImg.snp.makeConstraints { make in
             make.left.equalTo(contentView.snp.left)
             make.right.equalTo(contentView.snp.right)
             make.top.equalTo(contentView.snp.top).offset(sxDynamic(-40))
             make.height.equalTo(310)
         }
         
         closeBut.snp.makeConstraints { make in
             make.width.height.equalTo(sxDynamic(24))
             make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
             make.top.equalTo(contentView.snp.top).offset(sxDynamic(15))
         }
         
         titleLabel.snp.makeConstraints { make in
             make.centerX.equalTo(contentView.snp.centerX)
             make.top.equalTo(contentView.snp.top).offset(sxDynamic(80))
             make.height.equalTo(sxDynamic(25))
         }
         subLabel.snp.makeConstraints { make in
             make.centerX.equalTo(contentView.snp.centerX)
             make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(2))
             make.height.equalTo(sxDynamic(25))
         }
         
         su2bLabel.snp.makeConstraints { make in
             make.centerX.equalTo(contentView.snp.centerX)
             make.top.equalTo(subLabel.snp.bottom).offset(sxDynamic(2))
             make.height.equalTo(sxDynamic(25))
         }
         su3bLabel.snp.makeConstraints { make in
             make.centerX.equalTo(contentView.snp.centerX)
             make.top.equalTo(su2bLabel.snp.bottom).offset(sxDynamic(2))
             make.height.equalTo(sxDynamic(25))
         }
     
         
         submitBut.snp.makeConstraints { make in
             make.height.equalTo(sxDynamic(45))
             make.centerX.equalTo(contentView.snp.centerX)
             make.bottom.equalTo(contentView.snp.bottom).offset(sxDynamic(-30))
             make.width.equalTo(sxDynamic(200))
         }
     }
     
     //MARK: - getter
     func show() {
         //获取delegate
         let window = UIWindow.key
         self.frame = window?.bounds ?? CGRect.zero
         window?.addSubview(self)
         
         UIView.animate(withDuration: 0.35) {
             self.contentView.alpha = 1.0
         }
     }
     
     @objc func dismiss() {
         UIView.animate(withDuration: 0.4) {
 //            self.contentView.transform = CGAffineTransformMakeScale
             self.contentView.alpha = 0.0
         } completion: { finished in
             self.removeFromSuperview()
         }
     }
     
     @objc func submitClick() {
         callPhoneNumber("0571-22930325")
     }
    func callPhoneNumber(_ number: String) {
        // 清理号码中的非法字符（如空格、括号）
        let cleanedNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // 构造拨号 URL
        guard let url = URL(string: "telprompt://\(cleanedNumber)") else {
            print("无效的电话号码")
            return
        }
        
        // 检查设备是否支持拨号
        guard UIApplication.shared.canOpenURL(url) else {
            print("设备不支持拨号功能")
            return
        }
        
        // 跳转到拨号界面
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
     //MARK: - getter
     private lazy var closeBut: UIButton = {
         let but = CreateBaseView.makeBut("alert_close")
         but.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
         
         return but
     }()
     
     private lazy var groundImg: UIImageView = {
         let img = CreateBaseView.makeIMG("system_icon", .scaleAspectFit)
         img.contentMode = .scaleAspectFit
         
         return img
     }()
     
     private lazy var titleLabel: UILabel = {
         let label = CreateBaseView.makeLabel("系统检测", UIFont.sx.font_t20Blod, kT333, .center, 1)
         
         return label
     }()
     
    private lazy var subLabel: UILabel = {
        let label = CreateBaseView.makeLabel("当前身份信息存在风险无法进行下一步", UIFont.sx.font_t13, kT333, .center, 1)
        
        return label
    }()
    private lazy var su2bLabel: UILabel = {
        let label = CreateBaseView.makeLabel("如有疑问请拨打客服联系电话备份", UIFont.sx.font_t13, kT333, .center, 1)
        
        return label
    }()
    private lazy var su3bLabel: UILabel = {
        let label = CreateBaseView.makeLabel("0571-22930325", UIFont.sx.font_t13, kT333, .center, 1)
        
        return label
    }()
    
     private lazy var submitBut: UIButton = {
         let but = CreateBaseView.makeBut("立即拨打", kTBlue, kWhite,  UIFont.sx.font_t16Blod)
         but.layer.cornerRadius = sxDynamic(25)
         but.addTarget(self, action: #selector(submitClick), for: .touchUpInside)
         
         return but
     }()
     
     private lazy var contentView: UIView = {
         let contentView = UIView()
         contentView.layer.cornerRadius = sxDynamic(16)
//         contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
         contentView.backgroundColor = .white
//         contentView.clipsToBounds = true
//         contentView.layer.masksToBounds = true
         
         return contentView
     }()
}
