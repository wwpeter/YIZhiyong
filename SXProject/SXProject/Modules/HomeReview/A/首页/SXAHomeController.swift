//
//  SXAHomeController.swift
//  SXProject 15968359275
//
//  Created by Felix on 2025/5/14.
//

import UIKit

class SXAHomeController: DDBaseViewController,UITextFieldDelegate {
    
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
        
        tempView.addSubview(companyBaseView)
        tempView.addSubview(personBaseView)
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
        
        companyBaseView.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.height.equalTo(44)
            make.top.equalTo(iconImg.snp.bottom).offset(30)
        }
        
        personBaseView.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.height.equalTo(44)
            make.top.equalTo(companyBaseView.snp.bottom).offset(10)
        }
        
        quotaLookButton.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.height.equalTo(42)
            make.top.equalTo(personBaseView.snp.bottom).offset(20)
            make.bottom.equalTo(-20)
        }
        
        
        return tempView
    }()
    
    fileprivate lazy var companyBaseView:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = kBF8
        tempView.setCorner(8)
        tempView.addSubview(companyTextFiled)
        companyTextFiled.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.bottom.equalTo(0)
        }
        
        return tempView
    }()
    //企业
    fileprivate lazy var companyTextFiled:UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入企业名称"
        textField.font = DDSFont(13)
        textField.textColor = kT333
        textField.backgroundColor = kBF8
        textField.delegate = self
        textField.returnKeyType = .done
        return textField
    }()
    
    //公司选择
    fileprivate lazy var companyListView:SXAHomeCompanyListView = {
        let tempView = SXAHomeCompanyListView()
        tempView.layer.shadowColor = UIColor.init(white: 0, alpha: 0.3).cgColor
        tempView.layer.shadowOffset = CGSize(width: 0, height: 0)
        tempView.layer.shadowOpacity = 1
        tempView.layer.shadowRadius = 5
        return tempView
    }()
    
    fileprivate lazy var personBaseView:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = kBF8
        tempView.setCorner(8)
        tempView.addSubview(personTextFiled)
        personTextFiled.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.bottom.equalTo(0)
        }
        
        let nextIcon = UIImageView()
        nextIcon.image = DDSImage("iot_regist_right")
        tempView.addSubview(nextIcon)
        
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(choolseThePersonTypePop), for: .touchUpInside)
        tempView.addSubview(button)
        nextIcon.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.centerY.equalTo(tempView)
            make.width.equalTo(6)
            make.height.equalTo(10)
        }
        button.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(0)
        }
        
        return tempView
    }()
    //企业
    fileprivate lazy var personTextFiled:UITextField = {
        let textField = UITextField()
        textField.placeholder = "法人"
        textField.font = DDSFont(13)
        textField.textColor = kT333
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
        tempView.updateCellWithArray(["a_banner_img_1","a_banner_img_2","a_banner_img_3"]) //fixme
        return tempView
    }()
    
    fileprivate lazy var teachingView:SXATeachTalkBannerView = {
        let tempView = SXATeachTalkBannerView()
        tempView.updateCellWithArray(["a_banner_img_4"])
        weak var weakSelf = self
        tempView.jumpBlock = { text in
            if text == "a_banner_img_4" {
                weakSelf?.navigationController?.pushViewController(SXADisabuseQuestionController(), animated: true)
            }
            
        }
        return tempView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDefatulViews()
    }
    
    @objc func doErDuLookAction() {
        print("查看额度=======")
        let companyName = self.companyTextFiled.text ?? ""
        let personType = self.personTextFiled.text ?? ""
        
        if companyName == "" {
            Toast.showInfoMessage("请输入企业名称")
            return
        }
        
        if personType == "" {
            Toast.showInfoMessage("请选择申请人身份")
            return
        }
        
        let vc = SXAMatchingProductsListController()
        vc.companyName = self.companyTextFiled.text ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func doCounterLookAction() {
        print("借款计算器======")
        self.navigationController?.pushViewController(SXASXALoanCalculatorController(), animated: true)
    }
    
    @objc func doFraudLookAction() {
        print("防诈指南======")
        self.navigationController?.pushViewController(InterestRateVC(), animated: true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        matchTheCompanyList(textField.text ?? "")
        return true
    }
    
    fileprivate func matchTheCompanyList(_ name:String) {
        let param = ["name": name]
        NetworkRequestManager.sharedInstance().requestPath(kMatchCompanyName, withParam: param) { [weak self] result in
            printLog(result)
            
            if let arr = JSONHelper.jsonArrayToModel(result, SXACompanyModel.self) as? [SXACompanyModel]{
                print(arr)
                self?.showCompanyListView(arr)
            }
        } failure: { error in
        }
        
    }
    
    //选择公司
    fileprivate func showCompanyListView(_ array:[SXACompanyModel]) {
        self.view.endEditing(true)
        self.view.addSubview(companyListView)
        companyListView.snp.makeConstraints { make in
            make.left.equalTo(companyBaseView)
            make.right.equalTo(companyBaseView)
            make.top.equalTo(companyBaseView.snp.bottom).offset(5)
            make.height.equalTo(300)
        }
        companyListView.reloadViewWithArray(array)
        weak var weakSelf = self
        companyListView.selectBlock = { model in
            weakSelf?.companyListView.removeFromSuperview()
            weakSelf?.companyTextFiled.text = model.name
        }
    }
    
    @objc func choolseThePersonTypePop() {
        let array = ["企业法人","个体工商户","公司股东"]
        let pop = RPSheetMorePop(dataArray: array)
        weak var weakSelf = self
        pop.finishBlock = { (aIndex) in
            weakSelf?.personTextFiled.text = array[aIndex]
        }
        pop.show()
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
