//
//  HomeBottomView.swift
//  SXProject
//
//  Created by 王威 on 2025/1/6.
//

import UIKit

class HomeBottomView: UIView {

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
        groundView .addSubview(topView)
        groundView.addSubview(titleLabel)
        
        groundView.addSubview(leftView)
        groundView.addSubview(centerView)
        groundView.addSubview(rightView)
        
    }
    
    func initViewLayouts() {
        groundView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(sxDynamic(15))
        }
        
        let width = (kSizeScreenWidth - sxDynamic(40)) / 3
        
        leftView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(sxDynamic(52))
            make.width.equalTo(width)
            make.height.equalTo(sxDynamic(95))
            make.left.equalTo(topView.snp.left)
        }
        
        centerView.snp.makeConstraints { make in
            make.top.equalTo(leftView.snp.top)
            make.width.equalTo(width)
            make.height.equalTo(sxDynamic(95))
            make.left.equalTo(leftView.snp.right)
        }
        
        rightView.snp.makeConstraints { make in
            make.top.equalTo(leftView.snp.top)
            make.width.equalTo(width)
            make.height.equalTo(sxDynamic(95))
            make.left.equalTo(centerView.snp.right)
        }
    }
    
    //MARK: - getter
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = sxDynamic(16)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.frame = CGRectMake(0, 0, kSizeScreenWidth - sxDynamic(40), sxDynamic(52))
        view.sx.gradientColor(AssetColors.tfbf4E5.color, AssetColors.bfff.color, CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1))
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var groundView: UIView = {
        let view = UIView ()
        view.layer.cornerRadius = sxDynamic(16)
        view.clipsToBounds = true
        view.backgroundColor = .white
        
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("关于易支用", UIFont.sx.font_t16Blod, kT333, .center, 1)
        
        return label
    }()
    
    private lazy var leftView: HomeBottomItem = {
        let view = HomeBottomItem()
        
        return view
    }()
    
    private lazy var centerView: HomeBottomItem = {
        let view = HomeBottomItem()
        view.exchangeType(type: 2)
        
        return view
    }()
    
    private lazy var rightView: HomeBottomItem = {
        let view = HomeBottomItem()
        view.exchangeType(type: 3)
        
        return view
    }()
}
