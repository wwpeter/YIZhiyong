//
//  ProtocolTopView.swift
//  SXProject
//
//  Created by 王威 on 2025/2/22.
//

import UIKit

typealias ProtocolTopViewIndexBlock = (_ index: Int) -> Void

class ProtocolTopView: UIView {

    var indexBlock: ProtocolTopViewIndexBlock?
    
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
    
    func dealSelItem(type: Int) {
        var width = 0.0
        if type == 1 {
            leftLabel.isSelected = true
      
            rightLabel.isSelected = false
            
        } else if type == 2 {
            leftLabel.isSelected = false
 
            rightLabel.isSelected = false
            width = kSizeScreenWidth / 3.0
        } else if type == 3 {
            leftLabel.isSelected = false
       
            rightLabel.isSelected = true
            width = kSizeScreenWidth / 3.0 * 2
        }
 
    }
    
    
    //MARK: - initialize
    func initViews() {
     
        addSubview(leftLabel)
     
        addSubview(rightLabel)
 
    }
    
    func initViewLayouts() {
    

        let width = kSizeScreenWidth / 2
        leftLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.top.equalTo(self.snp.top).offset(sxDynamic(6))
            make.width.equalTo(width)
            make.height.equalTo(sxDynamic(52))
        }
        

        rightLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(sxDynamic(6))
            make.width.equalTo(width)
            make.height.equalTo(sxDynamic(52))
        }
    }
    
    //MARK: - getter
    
    private lazy var leftLabel: UIButton = {//clean_assistant_owner
        let but = CreateBaseView.makeBut("用户协议", .white, kTaaa, UIFont.sx.font_t15Blod)
        but.setImage(UIImage(named: "left_icon"), for: .selected)
        but.setTitleColor(kT333, for: .selected)
        but.titleLabel?.numberOfLines = 1
        but.titleLabel?.contentMode = .center
        but.isSelected = true
        but.addTarget(self, action: #selector(clickT2), for: .touchUpInside)
        
        return but
    }()
    @objc func clickT2(button: UIButton) {
        if button.isSelected == true {
            return
        }
        button.isSelected = !button.isSelected
        rightLabel.isSelected = !button.isSelected

        guard let blockT = self.indexBlock else {
            return
        }//int，1：托管，2：通用，3：定制
        blockT(1)
    }
  
    
    private lazy var rightLabel: UIButton = {//
        let but = CreateBaseView.makeBut("隐私协议", .white, kTaaa, UIFont.sx.font_t15Blod)
        but.setImage(UIImage(named: "right_icon"), for: .selected)
        but.setTitleColor(kT333, for: .selected)
        but.titleLabel?.numberOfLines = 1
        but.titleLabel?.contentMode = .center
//        label.isSelected = true
        but.addTarget(self, action: #selector(clickT), for: .touchUpInside)
        
        return but
    }()
    @objc func clickT(button: UIButton) {
        if button.isSelected == true {
            return
        }
        button.isSelected = !button.isSelected
        leftLabel.isSelected = !button.isSelected
 
        guard let blockT = self.indexBlock else {
            return
        }//int，1：托管，2：通用，3：定制
        blockT(3)
    }
}
