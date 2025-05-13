//
//  AddCardCell.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

typealias AddCardCellBlock = (_ text: String) -> Void

class AddCardCell: UITableViewCell, UITextFieldDelegate {

    var textblock: AddCardCellBlock?
    class func cellID() -> String {
        return "AddCardCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(AddCardCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(60)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        self.selectionStyle = .none
        initViews()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegate 键盘
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        // 获取输入框的最新文本
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        let textLength = text.count + string.count - range.length
        
        guard let blockT = textblock else { return true}
        blockT(updatedText)
        
        return true
        
    
    }
    
    //MARK: - action
    func setTitle(title: String, placeholder: String) {
        leftLabel.text = title
        rightTextField.placeholder = placeholder
    }
    
    func exchangeField() {
        rightTextField.keyboardType = .numberPad
    }

    func initViews() {
        contentView.addSubview(groundView)
        groundView.addSubview(leftIcon)
        groundView.addSubview(leftLabel)
        groundView.addSubview(rightTextField)
     
    }
    
    override func layoutSubviews() {
        groundView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(20))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(10))
            make.height.equalTo(sxDynamic(50))
        }
        leftIcon.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(6))
            make.centerY.equalTo(groundView.snp.centerY)
            make.left.equalTo(groundView.snp.left).offset(sxDynamic(15))
        }
        leftLabel.snp.makeConstraints { make in
            make.left.equalTo(leftIcon.snp.right).offset(sxDynamic(4))
            make.height.equalTo(sxDynamic(20))
            make.width.equalTo(sxDynamic(70))
            make.centerY.equalTo(groundView.snp.centerY)
        }
        rightTextField.snp.makeConstraints { make in
            make.left.equalTo(leftLabel.snp.right).offset(sxDynamic(5))
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(-20))
            make.centerY.equalTo(groundView.snp.centerY)
        }
    }
    
    //MARK: - getter
    private lazy var leftIcon: UIImageView = {
        let icon = CreateBaseView.makeIMG("request_icon", .scaleAspectFit)
        
        return icon
    }()
    private lazy var groundView: UIView = {
        let view = UIView()
        view.backgroundColor = kBF8
        view.layer.cornerRadius = sxDynamic(8)
        
        return view
    }()
    private lazy var leftLabel: UILabel = {
        let label = CreateBaseView.makeLabel("姓名:", UIFont.sx.font_t13, kT333, .left, 1)
        
        return label
    }()
    
    private lazy var rightTextField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .always
        textField.placeholder = "请输入姓名"
        textField.keyboardType = .default
       
        textField.delegate = self
//        textField.isSecureTextEntry = true
        
        return textField
    }()
}
