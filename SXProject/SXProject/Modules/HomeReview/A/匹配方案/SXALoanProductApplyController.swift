//
//  SXALoanProductApplyController.swift
//  SXProject
//
//  Created by Felix on 2025/5/16.
//

import UIKit
import BRPickerView
import ActiveLabel

class SXALoanProductApplyController: DDBaseViewController, JFCSTableViewControllerDelegate {
    
    var productModel = SXACompanyProductModel()
    var agree = false
    
    fileprivate lazy var mScollView:UIScrollView = {
        let tempView = UIScrollView()
        tempView.showsVerticalScrollIndicator = false
        tempView.backgroundColor = .clear
        return tempView
    }()
    
    fileprivate lazy var companyNameLabel:UILabel = {
        let label1 = UILabel()
        label1.font = DDSFont(13)
        label1.textColor = kT333
        return label1
    }()
    
    fileprivate lazy var companyPanl:UIView = {
        let tepView = UIView()
        
        let img = UIImageView()
        img.image = DDSImage("a_compang_icon")
        tepView.addSubview(img)
        

        tepView.addSubview(companyNameLabel)
        
        img.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.width.height.equalTo(20)
            make.top.equalTo(5)
        }
        companyNameLabel.snp.makeConstraints { make in
            make.left.equalTo(img.snp.right).offset(5)
            make.centerY.equalTo(img)
        }
        
        return tepView
    }()
    
    fileprivate lazy var topPanl:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .white
        let label = UILabel()
        label.text = "信息补充"
        label.font = DDSFont_M(16)
        label.textColor = kT333
        tempView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(20)
            make.height.equalTo(50)
        }
        
        return tempView
    }()
    
    fileprivate lazy var invoicePanl:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .white
        let label = UILabel()
        label.text = "税务发票信息"
        label.font = DDSFont_M(16)
        label.textColor = kT333
        tempView.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(20)
            make.height.equalTo(50)
        }
        return tempView
    }()
    
    fileprivate lazy var nameBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: true, name: "您的名称", placeholder:"请输入名称", keyboardType: .default, rightText: "")
        return tempview
    }()
    
    fileprivate lazy var loadMoneyBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: true, name: "金额", placeholder:"借款上限500万", keyboardType:.numberPad, rightText: "万")
        return tempview
    }()
    
    fileprivate lazy var ageBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: true, name: "申请人年龄", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "")
        return tempview
    }()
    
    fileprivate lazy var locationBaseView:SXAProductApplySelectView = {
        let tempview = SXAProductApplySelectView()
        tempview.setupDefaultView(showRed: true, name: "企业所在地", placeholder:"请选择", keyboardType:.default)
        weak var weakSelf = self
        tempview.selectBlock = {
            weakSelf?.showCompangyLocaitonPop()
            
        }
        return tempview
    }()
    
    fileprivate lazy var peopleTypeBaseView:SXAProductApplySelectView = {
        let tempview = SXAProductApplySelectView()
        tempview.setupDefaultView(showRed: true, name: "申请人身份", placeholder:"请选择", keyboardType:.default)
        weak var weakSelf = self
        tempview.selectBlock = {
            weakSelf?.showPeopleTypeLocaitonPop()
        }
        return tempview
    }()
    
    fileprivate lazy var guBiLiBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: false, name: "占股比例", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "%")
        return tempview
    }()
    
    fileprivate lazy var companyMonthBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: false, name: "企业成立时长", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "月")
        return tempview
    }()
    
    fileprivate lazy var sheBaoBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: false, name: "企业缴纳社保人数", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "人")
        return tempview
    }()
    
    fileprivate lazy var shiJiaoBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: false, name: "企业注册资金实缴", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "万")
        return tempview
    }()
    
    fileprivate lazy var monthSaleBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: false, name: "月流水", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "人")
        return tempview
    }()
    
    fileprivate lazy var faRenChangeBaseView:SXAProductApplySelectView = {
        let tempview = SXAProductApplySelectView()
        tempview.setupDefaultView(showRed: false, name: "法人变更发生时长", placeholder:"请输入数字", keyboardType:.numberPad)
        weak var weakSelf = self
        tempview.selectBlock = {
            weakSelf?.showFarenBianGengLocaitonPop()
        }
        return tempview
    }()
    
    //========================
    fileprivate lazy var taxesLongTimeBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: false, name: "企业连续纳税时长", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "月")
        return tempview
    }()
    
    fileprivate lazy var taxtQainStatusBaseView:SXAProductApplySelectView = {
        let tempview = SXAProductApplySelectView()
        tempview.setupDefaultView(showRed: false, name: "企业纳税欠缴情况", placeholder:"请选择", keyboardType:.default)
        weak var weakSelf = self
        tempview.selectBlock = {
            weakSelf?.showQianShuiStausLocaitonPop()
        }
        return tempview
    }()
    
    fileprivate lazy var taxdAddYearBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: false, name: "企业近一年增值税纳税额", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "万")
        return tempview
    }()
    
    fileprivate lazy var comngYearSalesBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: false, name: "企业近一年应税销售额", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "万")
        return tempview
    }()
    fileprivate lazy var companyPiJiLevelBaseView:SXAProductApplySelectView = {
        let tempview = SXAProductApplySelectView()
        tempview.setupDefaultView(showRed: false, name: "企业纳税评级", placeholder:"请选择", keyboardType:.default)
        weak var weakSelf = self
        tempview.selectBlock = {
            weakSelf?.showTaxaiLevelLocaitonPop()
        }
        return tempview
    }()
    
    fileprivate lazy var kaiPiaoTimeBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: false, name: "企业连续开票时长", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "月")
        return tempview
    }()
    
    fileprivate lazy var kaiPiaoMonthBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: false, name: "近一年有效开票月份", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "月")
        return tempview
    }()
    
    fileprivate lazy var kaiPiaoEduBaseView:SXAProductApplyTextFieldView = {
        let tempview = SXAProductApplyTextFieldView()
        tempview.setupDefaultView(showRed: false, name: "企业近一年开票额度", placeholder:"请输入数字", keyboardType:.numberPad, rightText: "万")
        return tempview
    }()
    
    //===================
    
    
    fileprivate lazy var bottomView:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .white
        tempView.addSubview(selectedBut)
        tempView.addSubview(subLabel)
        tempView.addSubview(sureButton)
        
        let label_2 = UILabel()
        label_2.text = "信息越完善，方案越精准哦！"
        label_2.textColor = kTaaa
        label_2.textAlignment = .center
        label_2.font = DDSFont(12)
        tempView.addSubview(label_2)
        
        selectedBut.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(15)
            make.width.height.equalTo(12)
        }
        subLabel.snp.makeConstraints { make in
            make.left.equalTo(selectedBut.snp.right).offset(5)
            make.top.equalTo(selectedBut)
            make.right.equalTo(-20)
        }
        sureButton.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(50)
            make.top.equalTo(subLabel.snp.bottom).offset(10)
        }
        label_2.snp.makeConstraints { make in
            make.top.equalTo(sureButton.snp.bottom).offset(10)
            make.centerX.equalTo(sureButton)
            make.bottom.equalTo(-10-kBottomSafeBarHeight)
        }
        return tempView
    }()
    
    //查看额度
    fileprivate lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("立即提交", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor =  kTBlue
        button.setCorner(radius: 25)
        button.addTarget(self, action:#selector(doErDuLookAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var selectedBut: UIButton = {
        let but = UIButton.init(type: .custom)
        but.setImage(UIImage(named: "iot_login_check") , for: .normal)
        but.setImage(UIImage(named: "login_selected") , for: .selected)
        but.addTarget(self, action: #selector(agreeClick(button:)), for: .touchUpInside)
        return but
    }()
    
//    private lazy var subLabel: UILabel = {
//        let label = CreateBaseView.makeLabel("我已阅读并同意《风险提示告知书》《个人信息授权收集使用说明》", UIFont.sx.font_t13, kT777, .center, 1)
//        label.numberOfLines = 0
//        return label
//    }()
//    
    private lazy var subLabel: ActiveLabel = {
        let protocolLab = ActiveLabel()
        
        protocolLab.isUserInteractionEnabled = true
   
        let serviceAgreement = ActiveType.custom(pattern: "《风险提示告知书》")
        let privacyPolicy = ActiveType.custom(pattern: "《个人信息授权收集使用说明》".sx_T)

        protocolLab.enabledTypes.append(serviceAgreement)
        protocolLab.enabledTypes.append(privacyPolicy)
        
        protocolLab.enabledTypes = [.mention, .hashtag, .url, privacyPolicy, serviceAgreement]
//        protocolLab.enabledTypes = [serviceAgreement, privacyPolicy]
        protocolLab.text = String.init(format: "我已阅读并同意《风险提示告知书》和《个人信息授权收集使用说明》")
        protocolLab.textColor = kT333
        protocolLab.numberOfLines = 0
        protocolLab.lineSpacing = 4
        protocolLab.font = UIFont.sx.font_t13
//        protocolLab.enabledTypes = [.url] // 设置需要激活的文本类型.mention, .hashtag,

        protocolLab.customColor[serviceAgreement] = kTBlue
        protocolLab.customColor[privacyPolicy] = kTBlue

        protocolLab.handleCustomTap(for: serviceAgreement) { _ in
            //fixme
            printLog("风险提示告知书")
            let alertView = SXAProductLoanAgreementView()
            alertView.loadWebView(privacy: false)
            alertView.agreeBlock = { [weak self] agree in
                self?.agree = agree
                self?.selectedBut.isSelected = self!.agree
            }
            
            alertView.show()
    
        }
        protocolLab.handleCustomTap(for: privacyPolicy) { _ in
            print("个人信息授权收集使用说明====")
            let alertView = SXAProductLoanAgreementView()
            alertView.loadWebView(privacy: true)
            alertView.agreeBlock = { [weak self] agree in
                self?.agree = agree
                self?.selectedBut.isSelected = self!.agree
            }
            
            alertView.show()
        }
        
        return protocolLab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "提交申请"
        setupViews()
        self.companyNameLabel.text = productModel.productName
    }
    
    @objc
    func agreeClick(button: UIButton) {
        button.isSelected = !button.isSelected
        self.agree = button.isSelected
        
    }
    
    @objc func doErDuLookAction() {
        print("提交======")
        if !agree {
            Toast.showInfoMessage("请同意相关协议")
            return
        }
        
        //1
        let nameString = nameBaseView.textFiled.text ?? ""//您的名称
        let loadMoneyString = loadMoneyBaseView.textFiled.text ?? ""//金额
        let ageString = ageBaseView.textFiled.text ?? ""//申请人年龄
        let locitonCityString = locationBaseView.textFiled.text ?? ""//企业所在地
        let peopleTypeString = peopleTypeBaseView.textFiled.text ?? ""//申请人身份
        let ratioString = guBiLiBaseView.textFiled.text ?? ""//占股比例
        let durationString = companyMonthBaseView.textFiled.text ?? ""//企业成立时长
        let peopleCount = sheBaoBaseView.textFiled.text ?? ""//企业缴纳社保人数
        let fundString = shiJiaoBaseView.textFiled.text ?? ""//企业注册资金实缴
        let monthFlowString = monthSaleBaseView.textFiled.text ?? ""//月流水
        let legalChange = faRenChangeBaseView.textFiled.text ?? ""//法人变更发生时长
        //2
        let taxesTime = taxesLongTimeBaseView.textFiled.text ?? ""//企业连续纳税时长
        let qTaxes = taxtQainStatusBaseView.textFiled.text ?? ""//企业纳税欠缴情况
        let zTaxes = taxdAddYearBaseView.textFiled.text ?? ""//企业近一年增值税纳税额
        let yTaxes = comngYearSalesBaseView.textFiled.text ?? ""//企业近一年应税销售额
        let pTaxes = companyPiJiLevelBaseView.textFiled.text ?? ""//企业纳税评级
        let invoicing = kaiPiaoTimeBaseView.textFiled.text ?? ""//企业连续开票时长
        let yInvoicing = kaiPiaoMonthBaseView.textFiled.text ?? ""//近一年有效开票月份
        let taxes = kaiPiaoEduBaseView.textFiled.text ?? ""//企业近一年开票额度
        
        
        if nameString == "" {
            Toast.showInfoMessage("请输入您的名称")
            return
        }
        if loadMoneyString == "" {
            Toast.showInfoMessage("请输入您的借款金额")
            return
        }
        if ageString == "" {
            Toast.showInfoMessage("请输入您的年龄")
            return
        }
        if locitonCityString == "" {
            Toast.showInfoMessage("请选择企业所在地")
            return
        }
        if peopleTypeString == "" {
            Toast.showInfoMessage("请选择申请人身份")
            return
        }
                
        var param = [String:Any]()
        param["productId"] = productModel.productId
        param["name"] = nameString
        param["loan"] = loadMoneyString
        param["age"] = ageString
        param["address"] = locitonCityString
        param["profession"] = peopleTypeString
        param["ratio"] = ratioString
        param["duration"] = durationString
        param["people"] = peopleCount
        param["fund"] = fundString
        param["flow"] = monthFlowString
        param["legalChange"] = legalChange
        
        param["taxesTime"] = taxesTime
        param["qTaxes"] = qTaxes
        param["zTaxes"] = zTaxes
        param["yTaxes"] = yTaxes
        param["pTaxes"] = pTaxes
        param["invoicing"] = invoicing
        param["yInvoicing"] = yInvoicing
        param["taxes"] = taxes
        
        Toast.showWaiting()
        NetworkRequestManager.sharedInstance().requestPath(kDoLoanProduct, withParam: param) { [weak self] result in
            let dic = JSONHelper.exchangeDic(jsonStr: result)
            Toast.closeWaiting()
            print("查询========\(dic)")
            //            if let code = dic["code"] as? Int {
            //                if code == 1 {
            //                } else {
            ////                    Toast.showInfoMessage("该产品已下架")
            //                }
            //            }
            
            self?.pushToResultController()
            
        } failure: { error in
            Toast.closeWaiting()
        }
        
    }
    
    fileprivate func pushToResultController() {
        let vc = SXALoanProductApplyResultController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func showCompangyLocaitonPop() {
        print("选择所在地====")
        self.view.endEditing(true)
        let configCity = JFCSConfiguration()
        let vc = JFCSTableViewController.init(configuration: configCity, delegate: self)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func viewController(_ viewController: JFCSTableViewController, didSelectCity model: JFCSBaseInfoModel) {
        let city = String.init(format: "%@", model.name)//[NSString stringWithFormat:@"%@",[model yy_modelDescription]];
        self.locationBaseView.textFiled.text = city
    }
    
    fileprivate func showPeopleTypeLocaitonPop() {
        print("申请人身份====")
        self.view.endEditing(true)
        let array = ["企业法人","个体工商户","公司股东"]
        let pop = RPSheetMorePop(dataArray: array)
        weak var weakSelf = self
        pop.finishBlock = { (aIndex) in
            weakSelf?.peopleTypeBaseView.textFiled.text = array[aIndex]
        }
        pop.show()
    }
    
    fileprivate func showFarenBianGengLocaitonPop() {
        print("法人变更发生时长===")
        self.view.endEditing(true)
        let array = ["无变更","1月内发生变更","6月内发生变更","9月内发生变更","12月内发生变更","24月内发生变更"]
        let pop = RPSheetMorePop(dataArray: array)
        weak var weakSelf = self
        pop.finishBlock = { (aIndex) in
            weakSelf?.faRenChangeBaseView.textFiled.text = array[aIndex]
        }
        pop.show()
    }
    
    fileprivate func showQianShuiStausLocaitonPop() {
        print("企业纳税欠缴情况===")
        self.view.endEditing(true)
        let array = ["无欠缴记录","3次以内欠缴记录","3~5次欠缴记录","5次以上欠缴记录"]
        let pop = RPSheetMorePop(dataArray: array)
        weak var weakSelf = self
        pop.finishBlock = { (aIndex) in
            weakSelf?.taxtQainStatusBaseView.textFiled.text = array[aIndex]
        }
        pop.show()
    }
    
    fileprivate func showTaxaiLevelLocaitonPop() {
        print("企业纳税评级===")
        self.view.endEditing(true)
        let array = ["A","B","C","D","M"]
        let pop = RPSheetMorePop(dataArray: array)
        weak var weakSelf = self
        pop.finishBlock = { (aIndex) in
            weakSelf?.companyPiJiLevelBaseView.textFiled.text = array[aIndex]
        }
        pop.show()
    }
    
    fileprivate func setupViews() {
        self.view.addSubview(mScollView)
        self.view.addSubview(bottomView)
        self.bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
        }
        mScollView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(kTopBarHeight)
            make.bottom.equalTo(self.bottomView.snp.top)
        }
        
        mScollView.addSubview(companyPanl)
        mScollView.addSubview(topPanl)
        mScollView.addSubview(invoicePanl)
        
        companyPanl.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
            make.height.equalTo(40)
        }
        
        topPanl.snp.makeConstraints { make in
            make.top.equalTo(companyPanl.snp.bottom).offset(0)
            make.left.right.equalTo(0)
            make.width.equalTo(kSizeScreenWidth)
        }
        
        invoicePanl.snp.makeConstraints { make in
            make.top.equalTo(topPanl.snp.bottom).offset(10)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-30)
        }
        //第一部分
        topPanl.addSubview(nameBaseView)
        topPanl.addSubview(loadMoneyBaseView)
        topPanl.addSubview(ageBaseView)
        topPanl.addSubview(locationBaseView)
        topPanl.addSubview(peopleTypeBaseView)
        topPanl.addSubview(guBiLiBaseView)
        topPanl.addSubview(companyMonthBaseView)
        topPanl.addSubview(sheBaoBaseView)
        topPanl.addSubview(shiJiaoBaseView)
        topPanl.addSubview(monthSaleBaseView)
        topPanl.addSubview(faRenChangeBaseView)
        
        nameBaseView.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.left.right.equalTo(0)
        }
        loadMoneyBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(nameBaseView.snp.bottom)
        }
        ageBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(loadMoneyBaseView.snp.bottom)
        }
        locationBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(ageBaseView.snp.bottom)
        }
        peopleTypeBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(locationBaseView.snp.bottom)
        }
        guBiLiBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(peopleTypeBaseView.snp.bottom)
        }
        companyMonthBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(guBiLiBaseView.snp.bottom)
        }
        sheBaoBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(companyMonthBaseView.snp.bottom)
        }
        shiJiaoBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(sheBaoBaseView.snp.bottom)
        }
        monthSaleBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(shiJiaoBaseView.snp.bottom)
        }
        faRenChangeBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(monthSaleBaseView.snp.bottom)
            make.bottom.equalTo(0)
        }
        
        //第二部分
        invoicePanl.addSubview(taxesLongTimeBaseView)
        invoicePanl.addSubview(taxtQainStatusBaseView)
        invoicePanl.addSubview(taxdAddYearBaseView)
        invoicePanl.addSubview(comngYearSalesBaseView)
        invoicePanl.addSubview(companyPiJiLevelBaseView)
        invoicePanl.addSubview(kaiPiaoTimeBaseView)
        invoicePanl.addSubview(kaiPiaoMonthBaseView)
        invoicePanl.addSubview(kaiPiaoEduBaseView)
        
        taxesLongTimeBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(50)
        }
        taxtQainStatusBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(taxesLongTimeBaseView.snp.bottom)
        }
        taxdAddYearBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(taxtQainStatusBaseView.snp.bottom)
        }
        comngYearSalesBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(taxdAddYearBaseView.snp.bottom)
        }
        companyPiJiLevelBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(comngYearSalesBaseView.snp.bottom)
        }
        kaiPiaoTimeBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(companyPiJiLevelBaseView.snp.bottom)
        }
        kaiPiaoMonthBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(kaiPiaoTimeBaseView.snp.bottom)
        }
        kaiPiaoEduBaseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(kaiPiaoMonthBaseView.snp.bottom)
            make.bottom.equalTo(0)
        }
    }
    
}
