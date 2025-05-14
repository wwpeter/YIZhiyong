//
//  SXALoanCalculatorController.swift
//  SXProject
//
//  Created by Felix on 2025/5/14.
//

import UIKit

class SXALoanCalculatorController: DDBaseViewController {
    
    // UI组件
    private let loanAmountTextField = UITextField()//金额
    private let loanTermTextField = UITextField() //期限
    private let yearPaymentTextField = UITextField() //年华
    private let returnTypeTextField = UITextField() //还款
    
    fileprivate lazy var topView :UIView = {
        let tempView = UIView()
        let label1 = UILabel()
        label1.text = "贷款计算器"
        label1.font = DDSFont_M(24)
        label1.textColor = kT333
        tempView.addSubview(label1)
        
        let labe2 = UILabel()
        labe2.text = "正规金融服务平台"
        labe2.font = DDSFont(13)
        labe2.textColor = kT777
        tempView.addSubview(labe2)
        
        let img = UIImageView()
        img.image = DDSImage("a_loan_icon_1")
        tempView.addSubview(img)
        
        label1.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.top.equalTo(5)
        }
        
        labe2.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.top.equalTo(label1.snp.bottom).offset(5)
        }
        
        img.snp.makeConstraints { make in
            make.right.equalTo(-sxDynamic(20))
            make.top.equalTo(5)
            make.width.equalTo(100)
            make.height.equalTo(100)
            make.bottom.equalTo(0)
        }
        
        return tempView
    }()
    
    private lazy var baseView:UIView = {
        let tempView = UIView()
        tempView.layer.cornerRadius = 8
        tempView.clipsToBounds = true
        tempView.backgroundColor = .white
        return tempView
    }()
    
    //贷款金额
    fileprivate lazy var loanAmountView:UIView = {
        let tempView = UIView()
        
        let label1 = UILabel()
        label1.text = "贷款金额"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        tempView.addSubview(label1)
        
        let masKView = UIView()
        masKView.backgroundColor = kBF8
        masKView.layer.cornerRadius = 8
        masKView.clipsToBounds = true
        tempView.addSubview(masKView)
        
        masKView.addSubview(loanAmountTextField)
        let label2 = UILabel()
        label2.text = "万元"
        label2.font = DDSFont(13)
        label2.textColor = kT777
        masKView.addSubview(label2)
        
        label1.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(0)
            make.height.equalTo(44)
        }
        masKView.snp.makeConstraints { make in
            make.left.equalTo(85)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        loanAmountTextField.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.bottom.equalTo(0)
            make.right.equalTo(-45)
        }
        
        label2.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.bottom.equalTo(0)
        }
        return tempView
    }()
    
    //贷款期限
    fileprivate lazy var loanMonthView:UIView = {
        let tempView = UIView()
        
        let label1 = UILabel()
        label1.text = "贷款期限"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        tempView.addSubview(label1)
        
        let masKView = UIView()
        masKView.backgroundColor = kBF8
        masKView.layer.cornerRadius = 8
        masKView.clipsToBounds = true
        tempView.addSubview(masKView)
        
        masKView.addSubview(loanTermTextField)
        let label2 = UILabel()
        label2.text = "月"
        label2.font = DDSFont(13)
        label2.textColor = kT777
        masKView.addSubview(label2)
        
        label1.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(0)
            make.height.equalTo(44)
        }
        masKView.snp.makeConstraints { make in
            make.left.equalTo(85)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        loanTermTextField.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.bottom.equalTo(0)
            make.right.equalTo(-45)
        }
        
        label2.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.bottom.equalTo(0)
        }
        return tempView
    }()
    
    //年化利率
    fileprivate lazy var yearView:UIView = {
        let tempView = UIView()
        
        let label1 = UILabel()
        label1.text = "年化利率"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        tempView.addSubview(label1)
        
        let masKView = UIView()
        masKView.backgroundColor = kBF8
        masKView.layer.cornerRadius = 8
        masKView.clipsToBounds = true
        tempView.addSubview(masKView)
        
        masKView.addSubview(yearPaymentTextField)
        let label2 = UILabel()
        label2.text = "%"
        label2.font = DDSFont(13)
        label2.textColor = kT777
        masKView.addSubview(label2)
        
        label1.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(0)
            make.height.equalTo(44)
        }
        masKView.snp.makeConstraints { make in
            make.left.equalTo(85)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        yearPaymentTextField.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.bottom.equalTo(0)
            make.right.equalTo(-45)
        }
        
        label2.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.bottom.equalTo(0)
        }
        return tempView
    }()
    
    //还款方式
    fileprivate lazy var returnTypeView:UIView = {
        let tempView = UIView()
        
        let label1 = UILabel()
        label1.text = "还款方式"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        tempView.addSubview(label1)
        
        let masKView = UIView()
        masKView.backgroundColor = kBF8
        masKView.layer.cornerRadius = 8
        masKView.clipsToBounds = true
        tempView.addSubview(masKView)
        
        masKView.addSubview(returnTypeTextField)
        let label2 = UILabel()
        label2.text = ">"
        label2.font = DDSFont(13)
        label2.textColor = kT777
        masKView.addSubview(label2)
        
        label1.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(0)
            make.height.equalTo(44)
        }
        masKView.snp.makeConstraints { make in
            make.left.equalTo(85)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        returnTypeTextField.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.bottom.equalTo(0)
            make.right.equalTo(-45)
        }
        
        label2.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.top.bottom.equalTo(0)
        }
        let button = UIButton()
        button.backgroundColor = .clear
        tempView.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.equalTo(85)
            make.top.bottom.right.equalTo(0)
        }
        button.addTarget(self, action: #selector(selectTheRetrnTypeAction), for: .touchUpInside)
        return tempView
    }()
    
    private lazy var calculateButton:UIButton = {
        let calculateButton = UIButton(type: .system)
        calculateButton.setTitle("开始计算", for: .normal)
        calculateButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        calculateButton.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.layer.cornerRadius = 10
        calculateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        calculateButton.addTarget(self, action: #selector(calculateInterestRate), for: .touchUpInside)
        return calculateButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = "贷款计算"
        
        let bgImg = UIImageView()
        bgImg.image = DDSImage("a_home_icon_1")
        self.view.addSubview(bgImg)
        bgImg.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
            make.height.equalTo(kSizeScreenWidth)
        }
        self.view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(kTopBarHeight)
        }
        
        self.view.addSubview(baseView)
        baseView.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.top.equalTo(topView.snp.bottom).offset(-26)
        }
        
        configureTextField(loanAmountTextField, placeholder: "请输入金额", keyboardType: .decimalPad)
        self.baseView.addSubview(loanAmountView)
        loanAmountView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(18)
        }
        
        configureTextField(loanTermTextField, placeholder: "请输入数字", keyboardType: .numberPad)
        self.baseView.addSubview(loanMonthView)
        loanMonthView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(loanAmountView.snp.bottom).offset(10)
        }
        configureTextField(yearPaymentTextField, placeholder: "请输入数字", keyboardType: .decimalPad)
        self.baseView.addSubview(yearView)
        yearView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(loanMonthView.snp.bottom).offset(10)
        }
        
        configureTextField(returnTypeTextField, placeholder: "请选择", keyboardType: .decimalPad)
        
        self.baseView.addSubview(returnTypeView)
        returnTypeView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(yearView.snp.bottom).offset(10)
        }
        
        self.baseView.addSubview(calculateButton)
        calculateButton.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(42)
            make.top.equalTo(returnTypeView.snp.bottom).offset(40)
            make.bottom.equalTo(-30)
        }
        
        //        // 添加点击背景隐藏键盘的手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureTextField(_ textField: UITextField, placeholder: String, keyboardType: UIKeyboardType) {
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.backgroundColor = .clear
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func calculateInterestRate() {
        let loanAmount = Double(loanAmountTextField.text ?? "0") ?? 0
        let termInt = Int(loanTermTextField.text ?? "0") ?? 0
        let yaerAmount = Double(yearPaymentTextField.text ?? "0") ?? 0
        let typeTyext = returnTypeTextField.text ?? ""
        
//        if loanAmount == 0 {
//            Toast.showInfoMessage("请输入贷款金额")
//            return
//        }
//        if termInt == 0 {
//            Toast.showInfoMessage("请输入贷款期限")
//            return
//        }
//        if yaerAmount == 0{
//            Toast.showInfoMessage("请输入年化利率")
//            return
//        }
//        
//        if typeTyext == "" {
//            Toast.showInfoMessage("请选择还款方式")
//            return
//        }
        
        //fixme
        print("去详情=====")
        let detelVC = SXALoanCalculatorDetailController()
        self.navigationController?.pushViewController(detelVC, animated: true)
    }
    
    @objc func selectTheRetrnTypeAction() {
        print("选择还款方式=====")
        let array = ["等额本息","等额本金","等本等息","先息后本"]
        let pop = RPSheetMorePop(dataArray: array)
        weak var weakSelf = self
        
        pop.finishBlock = { (aIndex) in
            weakSelf?.returnTypeTextField.text = array[aIndex]
        }
        pop.show()
    }
}
