import UIKit

class CreditLimitVC: UIViewController {
    
    // UI组件
    private let monthlyIncomeLabel = UILabel()
    private let monthlyIncomeTextField = UITextField()
    private let debtRatioLabel = UILabel()
    private let debtRatioTextField = UITextField()
    private let interestRateLabel = UILabel()
    private let interestRateTextField = UITextField()
    private let loanTermLabel = UILabel()
    private let loanTermTextField = UITextField()
    private let calculateButton = UIButton(type: .system)
    private let resultLabel = UILabel()
    
    // 输入容器
    private let inputStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "额度测算"
        
        // 配置标签和文本框
        configureLabel(monthlyIncomeLabel, text: "月收入 (元)")
        configureTextField(monthlyIncomeTextField, placeholder: "请输入月收入", keyboardType: .decimalPad)
        
        configureLabel(debtRatioLabel, text: "负债收入比 (%)")
        configureTextField(debtRatioTextField, placeholder: "请输入可接受的负债收入比", keyboardType: .decimalPad)
        
        configureLabel(interestRateLabel, text: "年利率 (%)")
        configureTextField(interestRateTextField, placeholder: "请输入年利率", keyboardType: .decimalPad)
        
        configureLabel(loanTermLabel, text: "贷款期限 (月)")
        configureTextField(loanTermTextField, placeholder: "请输入贷款期限", keyboardType: .numberPad)
        
        // 配置计算按钮
        calculateButton.setTitle("计算贷款额度", for: .normal)
        calculateButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        calculateButton.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.layer.cornerRadius = 10
        calculateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        calculateButton.addTarget(self, action: #selector(calculateCreditLimit), for: .touchUpInside)
        
        // 配置结果标签
        resultLabel.text = "贷款额度将显示在这里"
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        resultLabel.numberOfLines = 0
        
        // 配置输入堆栈视图
        inputStackView.axis = .vertical
        inputStackView.spacing = 15
        inputStackView.distribution = .fill
        inputStackView.alignment = .fill
        
        // 添加组件到堆栈视图
        inputStackView.addArrangedSubview(monthlyIncomeLabel)
        inputStackView.addArrangedSubview(monthlyIncomeTextField)
        inputStackView.addArrangedSubview(debtRatioLabel)
        inputStackView.addArrangedSubview(debtRatioTextField)
        inputStackView.addArrangedSubview(interestRateLabel)
        inputStackView.addArrangedSubview(interestRateTextField)
        inputStackView.addArrangedSubview(loanTermLabel)
        inputStackView.addArrangedSubview(loanTermTextField)
        inputStackView.addArrangedSubview(calculateButton)
        inputStackView.addArrangedSubview(resultLabel)
        
        // 添加堆栈视图到主视图
        view.addSubview(inputStackView)
        
        // 设置约束
        inputStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            inputStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            inputStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        // 添加点击背景隐藏键盘的手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 16)
    }
    
    private func configureTextField(_ textField: UITextField, placeholder: String, keyboardType: UIKeyboardType) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.keyboardType = keyboardType
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func calculateCreditLimit() {
        guard let monthlyIncomeText = monthlyIncomeTextField.text,
              let debtRatioText = debtRatioTextField.text,
              let interestRateText = interestRateTextField.text,
              let loanTermText = loanTermTextField.text,
              let monthlyIncome = Double(monthlyIncomeText),
              let debtRatio = Double(debtRatioText),
              let annualInterestRate = Double(interestRateText),
              let loanTerm = Int(loanTermText) else {
            resultLabel.text = "请输入有效的数值"
            return
        }
        
        // 计算每月可用于还款的金额
        let maxMonthlyPayment = monthlyIncome * (debtRatio / 100)
        
        // 计算月利率
        let monthlyInterestRate = annualInterestRate / 12 / 100
        
        // 使用等额本息还款公式反向计算贷款额度
        // 贷款额度 = 月供 / [月利率 * (1 + 月利率)^贷款期限 / ((1 + 月利率)^贷款期限 - 1)]
        let factor = monthlyInterestRate * pow(1 + monthlyInterestRate, Double(loanTerm)) / (pow(1 + monthlyInterestRate, Double(loanTerm)) - 1)
        let creditLimit = maxMonthlyPayment / factor
        
        // 显示结果，保留两位小数
        resultLabel.text = "最大贷款额度: \(String(format: "%.2f", creditLimit)) 元\n每月还款金额: \(String(format: "%.2f", maxMonthlyPayment)) 元"
    }
}