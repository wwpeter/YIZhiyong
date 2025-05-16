//
//  SXAProductApplyTextFieldCell.swift
//  SXProject
//
//  Created by Felix on 2025/5/16.
//

import UIKit

class SXAProductApplyTextFieldView: UIView {
    
    func setupDefaultView(showRed:Bool,name:String, placeholder: String, keyboardType: UIKeyboardType,rightText:String) {
        if showRed {
            self.redDotLabel.isHidden = false
        } else {
            self.redDotLabel.isHidden = true
            self.redDotLabel.snp.updateConstraints { make in
                make.width.height.equalTo(0)
            }
        }
        self.titleLabel.text = name
        
        textFiled.placeholder = placeholder
        textFiled.keyboardType = keyboardType
        
        self.rightLabel.text = rightText
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var baseView:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .white
        return tempView
    }()
    
    fileprivate lazy var redDotLabel:UIImageView = {
        let label1 = UIImageView()
        label1.image = DDSImage("a_red_dout")
        return label1
    }()
    
    fileprivate lazy var titleLabel:UILabel = {
        let label1 = UILabel()
        label1.font = DDSFont(13)
        label1.textColor = kT333
        return label1
    }()
    
    fileprivate lazy var rightLabel:UILabel = {
        let label1 = UILabel()
        label1.text = ""
        label1.font = DDSFont(13)
        label1.textColor = kT333
        return label1
    }()
    
    fileprivate lazy var textFiled:UITextField = {
        let label1 = UITextField()
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .right
        return label1
    }()
    
    fileprivate lazy var line:UIView = {
        let label1 = UIView()
        label1.backgroundColor = kBF2
        return label1
    }()
    
    fileprivate func setupViews() {
        self.addSubview(baseView)
        baseView.addSubview(redDotLabel)
        baseView.addSubview(titleLabel)
        baseView.addSubview(textFiled)
        baseView.addSubview(rightLabel)
        baseView.addSubview(line)
        
        baseView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(0)
            make.height.equalTo(44)
        }
        
        redDotLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.width.height.equalTo(8)
            make.centerY.equalTo(baseView)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(redDotLabel.snp.right)
            make.top.bottom.equalTo(0)
        }
        rightLabel.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.top.bottom.equalTo(0)
        }
        
        textFiled.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.right.equalTo(rightLabel.snp.left)
            make.left.greaterThanOrEqualTo(self.titleLabel.snp.right).offset(10)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(0)
            make.height.equalTo(0.5)
        }
    }
}
