//
//  SXALoanDetailCategoryView.swift
//  SXProject
//
//  Created by Felix on 2025/5/14.
//

import UIKit

class SXALoanDetailCategoryView: UIView {
    
    public var finishBlock:((_ aIndex:Int) -> Void)?
    
    fileprivate var baseView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.setCorner(8)
        return view
    }()
    
    fileprivate lazy var button_0:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 0
        button.setTitle("等额本息", for: .normal)
        button.setTitleColor(kT777, for: .normal)
        button.setTitleColor(kTBlue, for: .selected)
        button.titleLabel?.font = DDSFont(14)
        button.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var button_1:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 1
        button.setTitle("等额本金", for: .normal)
        button.setTitleColor(kT777, for: .normal)
        button.setTitleColor(kTBlue, for: .selected)
        button.titleLabel?.font = DDSFont(14)
        button.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var button_2:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 2
        button.setTitle("等本等息", for: .normal)
        button.setTitleColor(kTBlue, for: .selected)
        button.setTitleColor(kT777, for: .normal)
        button.titleLabel?.font = DDSFont(14)
        button.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var button_3:UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 3
        button.setTitle("先息后本", for: .normal)
        button.setTitleColor(kTBlue, for: .selected)
        button.setTitleColor(kT777, for: .normal)
        button.titleLabel?.font = DDSFont(14)
        button.addTarget(self, action: #selector(buttonClicked(button:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var bottomLine:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = kTBlue
        return tempView
    }()
    
    
    @objc func buttonClicked(button:UIButton) {
        print("buttonClicked===\(button.tag)")
        button_0.isSelected = false
        button_1.isSelected = false
        button_2.isSelected = false
        button_3.isSelected = false
        button.isSelected = true
        finishBlock?(button.tag)
        UIView.animate(withDuration: 0.25) {
            self.bottomLine.centerX = button.centerX
        }
    }
    
    //默认选择
    public func showDefaultSelextIndex(_ aIndex:Int) {
        button_0.isSelected = false
        button_1.isSelected = false
        button_2.isSelected = false
        button_3.isSelected = false
        
        if aIndex == 0 {
            button_0.isSelected = true
            self.bottomLine.centerX = self.button_0.centerX
            bottomLine.snp.makeConstraints { make in
                make.bottom.equalTo(0)
                make.height.equalTo(2)
                make.width.equalTo(14)
                make.centerX.equalTo(button_0)
            }
            
        } else if aIndex == 1 {
            button_1.isSelected = true
            //            self.bottomLine.centerX = self.button_1.centerX
            
            bottomLine.snp.makeConstraints { make in
                make.bottom.equalTo(0)
                make.height.equalTo(2)
                make.width.equalTo(14)
                make.centerX.equalTo(button_1)
            }
        } else if aIndex == 2 {
            button_2.isSelected = true
            //            self.bottomLine.centerX = self.button_2.centerX
            
            bottomLine.snp.makeConstraints { make in
                make.bottom.equalTo(0)
                make.height.equalTo(2)
                make.width.equalTo(14)
                make.centerX.equalTo(button_2)
            }
            
        } else {
            button_3.isSelected = true
            bottomLine.snp.makeConstraints { make in
                make.bottom.equalTo(0)
                make.height.equalTo(2)
                make.width.equalTo(14)
                make.centerX.equalTo(button_3)
            }
            //            self.bottomLine.centerX = self.button_3.centerX
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        self.addSubview(baseView)
        baseView.addSubview(button_0)
        baseView.addSubview(button_1)
        baseView.addSubview(button_2)
        baseView.addSubview(button_3)
        baseView.addSubview(bottomLine)
        baseView.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.top.equalTo(10)
            make.bottom.equalTo(-5)
            make.height.equalTo(sxDynamic(38))
        }
        
        button_0.snp.makeConstraints { make in
            make.left.top.bottom.equalTo(0)
        }
        
        button_1.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.left.equalTo(button_0.snp.right)
            make.width.equalTo(button_0)
        }
        
        button_2.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.left.equalTo(button_1.snp.right)
            make.width.equalTo(button_0)
        }
        
        button_3.snp.makeConstraints { make in
            make.top.bottom.equalTo(0)
            make.left.equalTo(button_2.snp.right)
            make.width.equalTo(button_0)
            make.right.equalTo(0)
        }
        
        //        bottomLine.snp.makeConstraints { make in
        //            make.bottom.equalTo(0)
        //            make.height.equalTo(2)
        //            make.width.equalTo(14)
        //            make.centerX.equalTo(button_0)
        //        }
        
    }
}
