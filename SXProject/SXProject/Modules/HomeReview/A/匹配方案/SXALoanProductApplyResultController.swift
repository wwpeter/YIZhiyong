//
//  SXALoanProductApplyResultController.swift
//  SXProject
//
//  Created by Felix on 2025/5/19.
//

import UIKit

class SXALoanProductApplyResultController: DDBaseViewController {
    
    fileprivate lazy var statusImg:UIImageView = {
        let img = UIImageView()
        img.image = DDSImage("a_load_stauat_1")
        return img
    }()
    
    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "审核中"
        label.textAlignment = .center
        label.font = DDSFont_B(16)
        label.textColor = kT333
        return label
    }()
    
    fileprivate lazy var statusLabel:UILabel = {
        let label = UILabel()
        label.text = "您的资料提交成功！\n审核时长预计5分钟，请耐心等待"
        label.numberOfLines = 0
        label.font = DDSFont(13)
        label.textAlignment = .center
        label.textColor = kT333
        return label
    }()
    
    fileprivate lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("返回首页", for: .normal)
        button.setTitleColor(kTBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(doErDuLookAction), for: .touchUpInside)
        button.setCorner(20,kTBlue,1)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "申请详情"
        self.view.addSubview(statusImg)
        self.view.addSubview(titleLabel)
        self.view.addSubview(statusLabel)
        self.view.addSubview(sureButton)
        
        statusImg.snp.makeConstraints { make in
            make.top.equalTo(kTopBarHeight + 100)
            make.width.equalTo(185)
            make.height.equalTo(100)
            make.centerX.equalTo(self.view)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(statusImg.snp.bottom).offset(30)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        sureButton.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.width.equalTo(90)
            make.height.equalTo(40)
            make.top.equalTo(statusLabel.snp.bottom).offset(90)
        }
    }
    
    @objc func doErDuLookAction() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
}
