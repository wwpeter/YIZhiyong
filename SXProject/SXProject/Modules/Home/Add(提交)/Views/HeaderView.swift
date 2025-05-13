//
//  HeaderView.swift
//  SXProject
//
//  Created by 王威 on 2025/3/29.
//

import UIKit


typealias HeaderViewBlock = () -> Void
class HeaderView: UIView, UITextFieldDelegate {

    var headerBlock: HeaderViewBlock?
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
    
    func setCity(city: String) {
        cityLeft.text = city
    }
    
    func getName() -> String {
        return nameTextField.text ?? ""
    }
    
    func getCard() -> String {
        return cardTextField.text  ?? ""
    }
    
    func setDataSource(model: AddModel) {
        nameTextField.text = model.name
        cardTextField.text = model.idCardNo
    }
    
    //MARK: - initialize
    func initViews() {
        backgroundColor = .white
        addSubview(nameLabel)
        addSubview(nameView)
        addSubview(nameTextField)
      
        addSubview(cardLabel)
        addSubview(cardView)
        addSubview(cardTextField)
        
        addSubview(cityLabel)
        addSubview(cityView)
        addSubview(cityLeft)
        addSubview(iconRight)
        
        addSubview(subCityLabel)
        
        addSubview(cityCtr)
    }
    
    func initViewLayouts() {
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(sxDynamic(20))
            make.top.equalTo(self.snp.top).offset(sxDynamic(20))
            make.height.equalTo(sxDynamic(25))
        }
        nameView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).offset(sxDynamic(15))
            make.height.equalTo(sxDynamic(45))
            make.right.equalTo(self.snp.right).offset(sxDynamic(-20))
        }
        nameTextField.snp.makeConstraints { make in
            make.left.equalTo(nameView.snp.left).offset(sxDynamic(15))
            make.centerY.equalTo(nameView.snp.centerY)
            make.right.equalTo(nameView.snp.right).offset(sxDynamic(-15))
        }
      
        cardLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameView.snp.bottom).offset(sxDynamic(15))
            make.height.equalTo(sxDynamic(25))
        }
        cardView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(cardLabel.snp.bottom).offset(sxDynamic(15))
            make.height.equalTo(sxDynamic(45))
            make.right.equalTo(self.snp.right).offset(sxDynamic(-20))
        }
        cardTextField.snp.makeConstraints { make in
            make.left.equalTo(cardView.snp.left).offset(sxDynamic(15))
            make.centerY.equalTo(cardView.snp.centerY)
            make.right.equalTo(cardView.snp.right).offset(sxDynamic(-15))
        }
        
        cityLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(cardView.snp.bottom).offset(sxDynamic(15))
            make.height.equalTo(sxDynamic(25))
        }
        cityView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(cityLabel.snp.bottom).offset(sxDynamic(15))
            make.height.equalTo(sxDynamic(45))
            make.right.equalTo(self.snp.right).offset(sxDynamic(-20))
        }
        cityLeft.snp.makeConstraints { make in
           
            make.centerY.equalTo(cityView.snp.centerY)
            make.left.equalTo(cityView.snp.left).offset(sxDynamic(15))
            make.height.equalTo(sxDynamic(20))
        }
        iconRight.snp.makeConstraints { make in
            make.right.equalTo(cityView.snp.right).offset(sxDynamic(-15))
            make.width.height.equalTo(sxDynamic(8))
            make.centerY.equalTo(cityView.snp.centerY)
        }
      
        subCityLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(cityView.snp.bottom).offset(sxDynamic(5))
        }
      
        cityCtr.snp.makeConstraints { make in
            make.centerY.equalTo(cityView.snp.centerY)
            make.left.equalTo(cityView.snp.left).offset(sxDynamic(15))
            make.right.equalTo(cityView.snp.right).offset(sxDynamic(-5))
            make.height.equalTo(sxDynamic(30))
        }
    }
    
   
    //MARK: - getter
    private lazy var nameLabel: UILabel = {
        let label = CreateBaseView.makeLabel("您的姓名", UIFont.sx.font_t16Blod, kT333, .left, 1)
        
        return label
    }()
    
    private lazy var nameView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = sxDynamic(10)
        view.backgroundColor = kBF8
        
        return view
    }()
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .always
        textField.placeholder = "请输入真实姓名"
        textField.keyboardType = .default
//        textField.borderStyle = .roundedRect
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var cardLabel: UILabel = {
        let label = CreateBaseView.makeLabel("您的身份证号码", UIFont.sx.font_t16Blod, kT333, .left, 1)
        
        return label
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = sxDynamic(10)
        view.backgroundColor = kBF8
        
        return view
    }()
    
    private lazy var cardTextField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .always
        textField.placeholder = "请输入真实身份证号"
        textField.keyboardType = .default
//        textField.borderStyle = .roundedRect
        textField.delegate = self
        
        return textField
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = CreateBaseView.makeLabel("所在城市", UIFont.sx.font_t16Blod, kT333, .left, 1)
        
        return label
    }()
    
    private lazy var cityView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = sxDynamic(10)
        view.backgroundColor = kBF8
        
        return view
    }()
    
    private lazy var cityLeft: UILabel = {
        let label = CreateBaseView.makeLabel("--", UIFont.sx.font_t14Blod, kT333, .left, 1)
        
        return label
    }()
    
    private lazy var iconRight: UIImageView = {
        let img = CreateBaseView.makeIMG("diqu_icon", .scaleAspectFit)
        
        return img
    }()
    
    private lazy var subCityLabel: UILabel = {
        let label = CreateBaseView.makeLabel("* 请选择长期居住的城市", UIFont.sx.font_t12, kTBlue, .left, 1)
        
        return label
    }()
    
    private lazy var cityCtr: UIControl = {
        let ctr = UIControl()
        ctr.addTarget(self, action: #selector(cityClick), for: .touchUpInside)
        
        return ctr
    }()
    
    @objc func cityClick() {
        guard let block = headerBlock else {return}
        block()
        
    }
    
}
