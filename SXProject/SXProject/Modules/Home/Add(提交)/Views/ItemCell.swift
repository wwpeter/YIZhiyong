//
//  ItemCell.swift
//  SXProject
//
//  Created by 王威 on 2025/3/29.
//

import UIKit

class ItemCell: UICollectionViewCell {
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
    
    //MARK: - actions

    
    func exchangeSel(sel: Bool) {
        if sel {//bf4F5Fc
            groundView.layer.borderColor = kTBlue.cgColor
            groundView.layer.borderWidth = sxDynamic(2)
            groundView.backgroundColor = AssetColors.bf4F5Fc.color
            iconImg.isHidden = false
        } else {
            groundView.layer.borderColor = UIColor.clear.cgColor
            groundView.layer.borderWidth = 0
            groundView.backgroundColor = kBF8
            iconImg.isHidden = true
        }
    }
    
    
    func setTitle(title: String) {
        titleLabel.text = title
    }
    
   
    
    //MARK: - initialize
    func initViews() {
        contentView.addSubview(groundView)
        contentView.addSubview(iconImg)
        contentView.addSubview(titleLabel)
    }
    
    func initViewLayouts() {
        groundView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        iconImg.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(18))
            make.bottom.equalTo(groundView.snp.bottom)
            make.right.equalTo(groundView.snp.right)
        }
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(groundView)
        }
       
    }
    
//    @objc func click(ctr: UIControl) {
//        ctr.isSelected = !ctr.isSelected
//    }
    
    //MARK: - getter
    private lazy var ctr: UIControl = {
        let ctr = UIControl()
//        ctr.addTarget(self, action: #selector(click(ctr:)), for: .touchUpInside)
        
        return ctr
    }()
    
    private lazy var groundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = sxDynamic(8)
        view.backgroundColor = kBF8
        
        return view
    }()
    
    private lazy var iconImg: UIImageView = {
        let img = UIImageView()
       
        img.contentMode = .scaleToFill
        img.image = UIImage(named: "cell_icon")
        img.isHidden = true
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = CreateBaseView.makeLabel("--", UIFont.sx.font_t14, kT333, .center, 2)
        
        return title
    }()

}
