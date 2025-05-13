import UIKit

class InterestRateVC: UIViewController {
    
    // UI组件
    private let loanAmountLabel = UILabel()
    private let loanAmountTextField = UITextField()
    private let monthlyPaymentLabel = UILabel()
    private let monthlyPaymentTextField = UITextField()
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
        title = "利率计算"
        
        // 配置标签和文本框
        configureLabel(loanAmountLabel, text: "贷款金额 (元)")
        configureTextField(loanAmountTextField, placeholder: "请输入贷款金额", keyboardType: .decimalPad)
        
        configureLabel(monthlyPaymentLabel, text: "月供金额 (元)")
        configureTextField(monthlyPaymentTextField, placeholder: "请输入月供金额", keyboardType: .decimalPad)
        
        configureLabel(loanTermLabel, text: "贷款期限 (月)")
        configureTextField(loanTermTextField, placeholder: "请输入贷款期限", keyboardType: .numberPad)
        
        // 配置计算按钮
        calculateButton.setTitle("计算年利率", for: .normal)
        calculateButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        calculateButton.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.layer.cornerRadius = 10
        calculateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        calculateButton.addTarget(self, action: #selector(calculateInterestRate), for: .touchUpInside)
        
        // 配置结果标签
        resultLabel.text = "年利率将显示在这里"
        resultLabel.textAlignment = .center
        resultLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        resultLabel.numberOfLines = 0
        
        // 配置输入堆栈视图
        inputStackView.axis = .vertical
        inputStackView.spacing = 15
        inputStackView.distribution = .fill
        inputStackView.alignment = .fill
        
        // 添加组件到堆栈视图
        inputStackView.addArrangedSubview(loanAmountLabel)
        inputStackView.addArrangedSubview(loanAmountTextField)
        inputStackView.addArrangedSubview(monthlyPaymentLabel)
        inputStackView.addArrangedSubview(monthlyPaymentTextField)
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
    
    @objc private func calculateInterestRate() {
        guard let loanAmountText = loanAmountTextField.text,
              let monthlyPaymentText = monthlyPaymentTextField.text,
              let loanTermText = loanTermTextField.text,
              let loanAmount = Double(loanAmountText),
              let monthlyPayment = Double(monthlyPaymentText),
              let loanTerm = Int(loanTermText) else {
            resultLabel.text = "请输入有效的数值"
            return
        }
        
        // 利率计算需要使用二分法或牛顿迭代法求解
        // 这里使用二分法近似计算
        var lowRate = 0.0001 // 0.01%
        var highRate = 0.05 // 5%
        let precision = 0.0001
        var calculatedMonthlyPayment: Double
        
        while highRate - lowRate > precision {
            let midRate = (lowRate + highRate) / 2
            let monthlyRate = midRate / 12
            
            calculatedMonthlyPayment = loanAmount * monthlyRate * pow(1 + monthlyRate, Double(loanTerm)) / (pow(1 + monthlyRate, Double(loanTerm)) - 1)
            
            if calculatedMonthlyPayment < monthlyPayment {
                lowRate = midRate
            } else {
                highRate = midRate
            }
        }
        
        // 取中间值作为结果
        let annualInterestRate = (lowRate + highRate) / 2 * 100
        
        // 显示结果，保留两位小数
        resultLabel.text = "年利率: \(String(format: "%.2f", annualInterestRate)) %"
    }
}