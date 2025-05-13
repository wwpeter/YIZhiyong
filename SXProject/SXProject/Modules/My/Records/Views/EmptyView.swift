//
//  EmptyView.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

class EmptyView: UIView {

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
    
    //open Acions
    func exchange(title: String, icon: String) {
        subTitle.text = title
        iconImg.image = UIImage(named: icon)
    }
    
    //MARK: - initialize
    func initViews() {
        addSubview(iconImg)
        addSubview(subTitle)
    }
    
    func initViewLayouts() {
        iconImg.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.width.height.equalTo(sxDynamic(120))
        }
        subTitle.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(sxDynamic(20))
            make.top.equalTo(iconImg.snp.bottom).offset(sxDynamic(sxDynamic(10)))
        }
    }
    
    //MARK: - getter

    private lazy var iconImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "jk_record")
        
        return img
    }()
    private lazy var subTitle: UILabel = {
        let title = CreateBaseView.makeLabel("暂无借款记录".sx_T, UIFont.sx.font_t12, kT777, .center, 1)
        
        return title
    }()
}
