//
//  GradationView.swift
//  SXProject
//
//  Created by 王威 on 2024/3/12.
//

import UIKit

class GradationView: UIView {

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
        
//        self.initViewLayouts()
       
    }
    
    func exchangeColor(can: Bool) {
       
        if can {
            gradientView.isHidden = false
            submitBut.isUserInteractionEnabled = true
            darkView.isHidden = true
        } else {
            submitBut.isUserInteractionEnabled = false
            darkView.isHidden = false
            gradientView.isHidden = true
        }
    }
    
    //MARK: - initialize
    private func gradient() {
         let gradientLayer = CAGradientLayer.init()
         gradientLayer.frame = gradientView.bounds
         gradientLayer.colors = [AssetColors.blogin1.color.cgColor, AssetColors.blogin2.color.cgColor]
         gradientLayer.startPoint = CGPoint(x: 0, y: 0)
         gradientLayer.endPoint = CGPoint(x: 0, y: 1)
         gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
         gradientView.layer.cornerRadius = sxDynamic(22.5)
         gradientView.layer.masksToBounds = true
     }
    func initViews() {
        addSubview(gradientView)
        addSubview(darkView)
        addSubview(submitBut)
        
        gradient()
    }
    
    func initViewLayouts() {
        
    }
   
    @objc private func submitClick() {
        printLog("点击事件！！！")
    }
    
    func exchangeTitle(title: String) {
        submitBut.setTitle(title, for: .normal)
    }
    
    func exchangeFrame() {
        gradientView.frame = CGRectMake(0, 0, kSizeScreenWidth - sxDynamic(254), sxDynamic(45))
        submitBut.frame = CGRectMake(0, 0, kSizeScreenWidth - sxDynamic(254), sxDynamic(42))
    }
    
    //MARK: - getter
    private lazy var gradientView: UIView = {
        let view = UIView()
        view.frame = CGRectMake(0, 0, kSizeScreenWidth - sxDynamic(60), sxDynamic(45))
        view.layer.cornerRadius = sxDynamic(22.5)
        view.layer.masksToBounds = true
       
        
        return view
    }()
    
    private lazy var darkView: UIView = {
        let view = UIView()
        view.frame = CGRectMake(0, 0, kSizeScreenWidth - sxDynamic(60), sxDynamic(45))
        view.layer.cornerRadius = sxDynamic(22.5)
        view.layer.masksToBounds = true
        view.backgroundColor = AssetColors.b9Bcbff.color
        view.isHidden = true
        
        return view
    }()
    lazy var submitBut: UIButton = {
        let but = UIButton.init(type: .custom)
        but.setTitle("iot_login_submit".sx_T, for: .normal)
        but.setTitleColor(kWhite, for: .normal)
        but.titleLabel?.font = UIFont.sx.font_t16
    
        but.frame = CGRectMake(0, 0, kSizeScreenWidth - sxDynamic(60), sxDynamic(45))
//        but.addTarget(self, action: #selector(submitClick), for: .touchUpInside)
        but.isUserInteractionEnabled = true
        
        
        return but
    }()
}
