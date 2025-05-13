//
//  TestView.swift
//  SXProject
//
//  Created by 王威 on 2024/3/6.
//

import UIKit

class TestView: UIView {

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
    
    //MARK: - initialize
    func initViews() {
      
    }
    
    func initViewLayouts() {
        
    }
    
    //MARK: - getter
    private lazy var accountBut: UIButton = {
        let but = UIButton()
        
        
        return but
    }()
    //    convenience init(frame: CGRect, currentTime: String) {
    //
    //    }
    
}
