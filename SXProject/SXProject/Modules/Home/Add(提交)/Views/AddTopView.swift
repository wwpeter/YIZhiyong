//
//  AddTopView.swift
//  SXProject
//
//  Created by 王威 on 2025/3/27.
//

import UIKit

typealias AddTopViewBlock = () -> Void
class AddTopView: UIView {

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
        addSubview(img)
        
        addSubview(titleLabel)
        addSubview(backBut)
        
    
        addSubview(leftIcon)
    }
    
    func initViewLayouts() {
        img.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(sxDynamic(13) + kStatusBarHeight)
        }
        backBut.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(sxDynamic(22))
            make.height.equalTo(sxDynamic(15))
            make.left.equalTo(self.snp.left).offset(sxDynamic(15))
        }
        
      
    }
    
   
    //MARK: - getter
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("提交申请", UIFont.sx.font_t18, kWhite, .center, 1)
        
        return label
    }()
    
    lazy var backBut: UIButton = {
        let but = CreateBaseView.makeBut("white_back")
        
        
        return but
    }()
    
    private lazy var img: UIImageView = {
        let img = CreateBaseView.makeIMG("add_top_icon", .scaleAspectFill)
        
        return img
    }()
    
    private lazy var leftIcon: UIImageView = {
        let img = CreateBaseView.makeIMG("fangzhazhinan_icon", .scaleAspectFit)
        
        return img
    }()


}
