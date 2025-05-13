//
//  ActivateFirstView.swift
//  SXProject
//
//  Created by 王威 on 2024/7/12.
//

import UIKit

class ActivateFirstView: UIView {

    /// 使用代码创建一个View会调用该构造方法
    ///
    /// - Parameter frame: <#frame description#>
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
        
        self.perform(#selector(dismiss), with: self, afterDelay: 1.4)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.initViewLayouts()
    }
    func show() {
        //获取delegate
        let window = UIWindow.key
        self.frame = window?.bounds ?? CGRect.zero
        window?.addSubview(self)
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.3) {
//            self.contentView.transform = CGAffineTransformMakeScale
            
        } completion: { finished in
            self.removeFromSuperview()
        }
    }
    
    //MARK: - initialize
    func initViews() {
        self.backgroundColor = kWhite
        addSubview(topIMG)
        addSubview(buerIMG)
        addSubview(titleLabel)
        addSubview(subLabel)
    }
    
    func initViewLayouts() {
        topIMG.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(200))
            make.leading.trailing.top.equalTo(0)
        }
        buerIMG.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(sxDynamic(160))
            make.width.equalTo(sxDynamic(135))
            make.height.equalTo(sxDynamic(90))
            make.centerX.equalTo(self.snp.centerX)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(buerIMG.snp.centerX)
            make.top.equalTo(buerIMG.snp.bottom).offset(sxDynamic(60))
        }
        subLabel.snp.makeConstraints { make in
            make.centerX.equalTo(buerIMG.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(14))
        }
    }
    
    //MARK: - getter
    private lazy var topIMG: UIImageView = {
        let img = UIImageView.init(image: UIImage(named: "launch_meng"))
        
        return img
    }()
    
    private lazy var buerIMG: UIImageView = {
        let img = UIImageView.init(image: UIImage(named: "launch_icon"))
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "launch_titile".sx_T
        label.textColor = kT333
        label.font = UIFont.boldSystemFont(ofSize: 45)
        label.textAlignment = .center
        
        return label
    }()
    
    
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.text = "launch_titile_sub".sx_T
        label.textColor = kT333
        label.font = UIFont.sx.font_t35Blod
        label.textAlignment = .center
        
        return label
    }()
}
