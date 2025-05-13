//
//  NotificationView.swift
//  SXProject
//
//  Created by 王威 on 2025/1/6.
//

import UIKit

class NotificationView: UIView {

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
        addSubview(groundView)
        groundView.addSubview(leftImg)
        groundView.addSubview(titleLabel)
    }
    
    func initViewLayouts() {
        groundView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        leftImg.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(16))
            make.left.equalTo(groundView.snp.left).offset(sxDynamic(10))
            make.centerY.equalTo(groundView.snp.centerY)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(leftImg.snp.right).offset(sxDynamic(5))
            make.centerY.equalTo(groundView.snp.centerY)
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(-15))
        }
    }
    
    //MARK: - getter
    
    private var leftImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "home_laba")
        
        return img
    }()
    private var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("申请过程中，无需任何费用请您务必知晓，谨防诈骗", UIFont.sx.font_t12, kT777, .left, 1)
        
        
        return label
    }()
    
    private var groundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = sxDynamic(8)
        
        return view
    }()
}
