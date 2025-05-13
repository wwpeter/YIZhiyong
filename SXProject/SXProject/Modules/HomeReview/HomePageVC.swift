import UIKit

class HomePageVC: ViewController {
    
    // 三个主按钮
    private let monthlyPaymentButton = UIButton(type: .system)
    private let interestRateButton = UIButton(type: .system)
    private let creditLimitButton = UIButton(type: .system)
    
    // 按钮容器视图
    private let buttonsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        SX_navTitle = "易支用"
        
        view.addSubview(headIconImg)
        headIconImg.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(sxDynamic(0))
            make.left.right.equalTo(0)
            make.height.equalTo(sxDynamic(200))
        }
        
        // 配置按钮
        configureButton(monthlyPaymentButton, title: "月供计算", action: #selector(monthlyPaymentTapped))
        configureButton(interestRateButton, title: "利率计算", action: #selector(interestRateTapped))
        configureButton(creditLimitButton, title: "额度测算", action: #selector(creditLimitTapped))
        
        // 配置堆栈视图
        buttonsStackView.axis = .vertical
        buttonsStackView.spacing = 20
        buttonsStackView.distribution = .fillEqually
        buttonsStackView.alignment = .fill
        
        // 添加按钮到堆栈视图
        buttonsStackView.addArrangedSubview(monthlyPaymentButton)
        buttonsStackView.addArrangedSubview(interestRateButton)
        buttonsStackView.addArrangedSubview(creditLimitButton)
        
        // 添加堆栈视图到主视图
        view.addSubview(buttonsStackView)
        
        // 设置约束
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
      
    }
    
    private func configureButton(_ button: UIButton, title: String, action: Selector) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 1.0, alpha: 1.0)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.addTarget(self, action: action, for: .touchUpInside)
    }
    
    private lazy var headIconImg: UIImageView = {
        let img = CreateBaseView.makeIMG("home_top_1", .scaleAspectFill)
        img.layer.cornerRadius = sxDynamic(8)
        img.clipsToBounds = true
        
        return img
    }()
    
    // MARK: - 按钮点击事件
    
    @objc private func monthlyPaymentTapped() {
        let monthlyPaymentVC = MonthlyPaymentVC()
        navigationController?.pushViewController(monthlyPaymentVC, animated: true)
    }
    
    @objc private func interestRateTapped() {
        let interestRateVC = InterestRateVC()
        navigationController?.pushViewController(interestRateVC, animated: true)
    }
    
    @objc private func creditLimitTapped() {
        let creditLimitVC = CreditLimitVC()
        navigationController?.pushViewController(creditLimitVC, animated: true)
    }
}
