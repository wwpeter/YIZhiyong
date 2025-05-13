//
//  BaseView.swift
//  Sleep
//
//  Created by 王威 on 2022/12/26.
//

import UIKit
import SnapKit
import SXBaseModule

class BaseView: UIView {

    //负责对象销毁
    //这个功能类似NotificationCenter的removeObserver

    /// 使用代码创建一个View会调用该构造方法
    ///
    /// - Parameter frame: <#frame description#>
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        innerInit()
    }
    
    /// 可视化布局的时候
    ///
    /// - Parameter aDecoder: <#aDecoder description#>
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        innerInit()
    }
    
    // 加载一个xibview
    func loadNib() -> UIView? {
        let contentView = Bundle.main.loadNibNamed(String(describing: Self.self), owner: self, options: nil)?.first as? UIView
        contentView?.frame = bounds
        return contentView
    }
    
    func innerInit() {
        initViews()
        initDatas()
        initListeners()
    }
    
    /// 初始化控件
    func initViews() {}
    
    /// 初始化数据
    func initDatas() {}
    
    /// 初始化监听器
    func initListeners() {}
}
