//
//  RequestFailView.swift
//  Sleep
//
//  Created by 王威 on 2022/10/20.
//

import UIKit

typealias RequestFailViewBlock = () -> Void

class RequestFailView: UIView {
    //回调
    var clickBlock: RequestFailViewBlock?
    
    let failImageView: UIImageView = UIImageView().then {
        $0.image = AssetImages.nodata.image
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }
    let titleLabel: UILabel = UILabel().then {
        $0.text = "加载失败，请检查网络！"
        $0.font = UIFont.sx.font_t17
        $0.textColor = AssetColors.t666.color
    }
    
    // MARK: - - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        self.addSubview(failImageView)
        self.addSubview(titleLabel)
        
        //布局
        failImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(-20)
            make.trailing.equalTo(self.snp.trailing)
            make.leading.equalTo(self.snp.leading)
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(sxDynamic(17))
            make.trailing.equalTo(self.snp.trailing)
            make.leading.equalTo(self.snp.leading)
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(tapClick))
        
        self.addGestureRecognizer(tap)
    }
    
    @objc
    func tapClick() {
        self.clickBlock?()
    }
}
