//
//  LHNavBar.swift
//  LangHuaStage
//
//  Created by 王大力 on 2017/11/28.
//  Copyright © 2017年 LangHuaStage. All rights reserved.
//

import UIKit
//import SDAutoLayout

public class DDCustNavView: UIView {
    public var titleLabel:UILabel!
    public var leftButton:UIButton!
    public var title: String? {
        get {
            return self.titleLabel.text
        }
        set {
            self.titleLabel.text = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        self.frame = CGRect(x: 0, y: 0, width: CGFloat(kSizeScreenWidth), height: kTopBarHeight);
        self.backgroundColor = .clear
        setupTitleLabel()
        setupLeftButton()
    }
    
    fileprivate func setupTitleLabel() {
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.textColor = kT333
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.font = DDSFont_M(17)
        titleLabel.frame = CGRect(x: 50, y: kStatusBarHeight, width: kSizeScreenWidth - 100, height: 44)
        self.addSubview(titleLabel)
    }
    
    fileprivate func setupLeftButton() {
        leftButton = UIButton(type: .custom)
        leftButton.setImage(DDSImage("navigationBack"), for: UIControl.State(rawValue: 0))
        leftButton.setImage(DDSImage("navigationBack"), for: .highlighted)
        leftButton.sizeToFit()
        leftButton.backgroundColor = UIColor.clear
        self.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(0)
            make.width.height.equalTo(44)
            make.bottom.equalToSuperview()
        }
    }
}
