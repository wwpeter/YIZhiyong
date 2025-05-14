//
//  SXAHomeController.swift
//  SXProject
//
//  Created by Felix on 2025/5/14.
//

import UIKit

class SXAHomeController: DDBaseViewController {
    
    fileprivate lazy var mScollView:UIScrollView = {
        let tempView = UIScrollView()
        tempView.showsVerticalScrollIndicator = false
        tempView.backgroundColor = .clear
        return tempView
    }()
    
    fileprivate lazy var topView:UIView = {
        let tempView = UIView()
        let img = UIImageView()
        img.image = DDSImage("a_home_icon_2")
        tempView.addSubview(img)
        
        let label = UILabel()
        label.text = "正规金融服务平台"
        label.font = DDSFont(13)
        label.textColor = kT333
        tempView.addSubview(label)
        img.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(sxDynamic(30))
            make.width.equalTo(85)
            make.height.equalTo(24)
        }
        label.snp.makeConstraints { make in
            make.left.equalTo(img.snp.right).offset(5)
            make.bottom.equalTo(img)
        }
        
        return tempView
    }()
    
    //额度
    fileprivate lazy var quotaBaseView:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .white
        tempView.layer.cornerRadius = 16
        tempView.clipsToBounds = true
        let bulueBG = UIView()
        bulueBG.backgroundColor = kTBlue
        tempView.addSubview(bulueBG)
        
        let label = UILabel()
        label.text = "您的预估额度（元）"
        label.textAlignment = .center
        label.textColor = .white
        label.font = DDSFont(13)
        tempView.addSubview(label)
        
        let iconImg = UIImageView()
        iconImg.image = DDSImage("a_home_icon_3")
        tempView.addSubview(iconImg)
        
        tempView.addSubview(companyTextFiled)
        tempView.addSubview(personTextFiled)
        tempView.addSubview(quotaLookButton)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.centerX.equalTo(tempView)
        }
        
        iconImg.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(10)
            make.width.equalTo(260)
            make.height.equalTo(60)
            make.centerX.equalTo(tempView)
        }
        
        bulueBG.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
            make.bottom.equalTo(iconImg.snp.bottom).offset(15)
        }
        
        companyTextFiled.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.height.equalTo(44)
            make.top.equalTo(iconImg.snp.bottom).offset(30)
        }
        
        personTextFiled.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.height.equalTo(44)
            make.top.equalTo(companyTextFiled.snp.bottom).offset(10)
        }
        
        quotaLookButton.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.height.equalTo(42)
            make.top.equalTo(personTextFiled.snp.bottom).offset(20)
            make.bottom.equalTo(-20)
        }
        
        
        return tempView
    }()
    
    //企业
    fileprivate lazy var companyTextFiled:UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入企业名称"
        textField.font = DDSFont(13)
        textField.borderStyle = .roundedRect
        textField.textColor = kT333
        textField.backgroundColor = kBF8
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    //企业
    fileprivate lazy var personTextFiled:UITextField = {
        let textField = UITextField()
        textField.placeholder = "法人"
        textField.borderStyle = .roundedRect
        textField.font = DDSFont(13)
        textField.textColor = kT333
        textField.backgroundColor = kBF8
        return textField
    }()
    
    //查看额度
    fileprivate lazy var quotaLookButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("查看我的额度", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor =  kTBlue
        button.layer.cornerRadius = 21
//        button.clipsToBounds = true
        button.addTarget(self, action:#selector(doErDuLookAction), for: .touchUpInside)
        button.layer.shadowColor = UIColor(red: 0.35, green: 0.66, blue: 1, alpha: 0.5).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 10
        return button
    }()
    
    fileprivate lazy var counterButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("借款计算器", for: .normal)
        button.setTitleColor(kT333, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor =  .white
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action:#selector(doCounterLookAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var fraidButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("防诈指南", for: .normal)
        button.setTitleColor(kT333, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.backgroundColor =  .white
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action:#selector(doFraudLookAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var hotProductsView:SXAHotProduceBannerView = {
        let tempView = SXAHotProduceBannerView()
        tempView.updateCellWithArray(["add_top_icon","add_top_icon"]) //fixme
        return tempView
    }()
    
    fileprivate lazy var teachingView:SXATeachTalkBannerView = {
        let tempView = SXATeachTalkBannerView()
        tempView.updateCellWithArray(["update_progress","add_top_icon","detail_icon"])//fixme
        return tempView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefatulViews()
    }
    
    @objc func doErDuLookAction() {
        print("查看额度=======")
        self.navigationController?.pushViewController(MonthlyPaymentVC(), animated: true)
    }
    
    @objc func doCounterLookAction() {
        print("借款计算器======")
        self.navigationController?.pushViewController(SXASXALoanCalculatorController(), animated: true)
    }
    
    @objc func doFraudLookAction() {
        print("防诈指南======")
        self.navigationController?.pushViewController(InterestRateVC(), animated: true)
    }
}

extension SXAHomeController {
    
    fileprivate func setupDefatulViews() {
//        navigationController?.navigationBar.isHidden = true
        self.hideNavgationBar(isHide: true)
        let bgImg = UIImageView()
        bgImg.image = DDSImage("a_home_icon_1")
        self.view.addSubview(bgImg)
        self.view.addSubview(topView)
        self.view.addSubview(mScollView)
        mScollView.addSubview(quotaBaseView)
        
        mScollView.addSubview(counterButton)
        mScollView.addSubview(fraidButton)
        
        mScollView.addSubview(hotProductsView)
        mScollView.addSubview(teachingView)

        bgImg.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
            make.height.equalTo(kSizeScreenWidth)
        }
        
        topView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.height.equalTo(44)
            make.top.equalTo(kStatusBarHeight)
        }
        
        mScollView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.bottom.equalTo(0)
        }
        
        quotaBaseView.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.width.equalTo(kSizeScreenWidth - sxDynamic(40))
            make.top.equalTo(10)
        }
        
        counterButton.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.height.equalTo(60)
            make.top.equalTo(quotaBaseView.snp.bottom).offset(15)
        }
        
        fraidButton.snp.makeConstraints { make in
            make.left.equalTo(counterButton.snp.right).offset(10)
            make.right.equalTo(-sxDynamic(20))
            make.height.equalTo(60)
            make.top.equalTo(counterButton.snp.top)
            make.width.equalTo(counterButton.snp.width)
        }
        
        hotProductsView.snp.makeConstraints { make in
            make.top.equalTo(counterButton.snp.bottom).offset(15)
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
        }
        
        teachingView.snp.makeConstraints { make in
            make.top.equalTo(hotProductsView.snp.bottom).offset(15)
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.bottom.equalTo(-50)
        }
    }
}
