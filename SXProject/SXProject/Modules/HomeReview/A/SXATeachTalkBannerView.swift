//
//  SXATeachTalkBannerView.swift
//  SXProject
//
//  Created by Felix on 2025/5/14.
//

import UIKit
import SnapKit
import JXBanner
import JXPageControl
import Kingfisher

class SXATeachTalkBannerView: UIView {
    
    fileprivate var pageCount = 0
    fileprivate var bannerDataArray = [String]()
    public var jumpBlock: ((_ jumpUrl:String) -> Void)?

    fileprivate lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = "解惑小课堂"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = kT333
        return label
    }()
    
    lazy var linearBanner: JXBanner = {[weak self] in
        let banner = JXBanner()
        banner.indentify = "LinearBannerCell"
        banner.delegate = self
        banner.dataSource = self
        banner.backgroundColor = kBF8
        banner.layer.cornerRadius = 8
        banner.clipsToBounds = true
        return banner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCellWithArray(_ array:[String]) {
        bannerDataArray = array
        pageCount = bannerDataArray.count
        linearBanner.reloadView()
        linearBanner.scrollToIndex(0, animated: false)
    }
    
    fileprivate func setUpViews() {
        self.addSubview(titleLabel)
        self.addSubview(linearBanner)
        self.backgroundColor = .clear
        
        titleLabel.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
        }
        linearBanner.snp.makeConstraints {(maker) in
            maker.left.right.equalTo(0)
            maker.top.equalTo(titleLabel.snp.bottom).offset(10)
            maker.width.equalTo(kSizeScreenWidth).priority(.high)
            maker.height.equalTo(DD_DYNIMICA_BANNER_HEIGHT).priority(.high)
            maker.bottom.equalTo(0)
        }
    }
}

//MARK:- JXBannerDataSource
extension SXATeachTalkBannerView : JXBannerDataSource,JXBannerDelegate {
    
    //总个数
    func jxBanner(numberOfItems banner: JXBannerType)-> Int {
        return pageCount
    }
    
    //点击
    public func jxBanner(_ banner: JXBannerType,didSelectItemAt index: Int) {
        print("点击===\(index)")
        let model = self.bannerDataArray[index]
        if jumpBlock != nil {
            jumpBlock!(model)
        }
    }
    
    //当前第几页
    func jxBanner(_ banner: JXBannerType, center index: Int) {
        //        print("当前===\(index)")
    }
    
    //cell样式
    func jxBanner(_ banner: JXBannerType,cellForItemAt index: Int,cell: UICollectionViewCell) -> UICollectionViewCell {
        let tempCell = cell as! JXBannerCell
        tempCell.msgBgView.isHidden = true
        tempCell.backgroundColor = UIColor.clear
        tempCell.clipsToBounds = true
        tempCell.imageView.contentMode = .scaleAspectFill
        let model = self.bannerDataArray[index]
        //fixme
//        if let url = URL(string: model) {
//            tempCell.imageView.kf.setImage(with: url, placeholder: nil, options: nil)
//        }
        tempCell.imageView.image = DDSImage(model)
        return tempCell
    }
    
    //注册cell
    func jxBanner(_ banner: JXBannerType) -> (JXBannerCellRegister) {
        return JXBannerCellRegister(type: JXBannerCell.self,reuseIdentifier: "LinearBannerCell")
    }
    
    //cell 高度
    func jxBanner(_ banner: JXBannerType,layoutParams: JXBannerLayoutParams) -> JXBannerLayoutParams {
        return layoutParams
            .itemSize(CGSize(width: kSizeScreenWidth, height: DD_DYNIMICA_BANNER_HEIGHT))
            .itemSpacing(15)
    }
    
    //配置项
    func jxBanner(_ banner: JXBannerType,params: JXBannerParams) -> JXBannerParams {
        return params
            .timeInterval(4)
            .isAutoPlay(true)
    }
    
    //PageControl
    func jxBanner(pageControl banner: JXBannerType,numberOfPages: Int,coverView: UIView,builder: JXBannerPageControlBuilder) -> JXBannerPageControlBuilder {
        let pageControl = JXPageControlScale()
        pageControl.contentMode = .bottom
        pageControl.backgroundColor = UIColor.clear
        pageControl.activeSize = CGSize(width: 16, height: 3)
        pageControl.inactiveSize = CGSize(width: 8, height: 3)
        pageControl.activeColor = UIColor.white
        pageControl.inactiveColor = UIColor.init(white: 1, alpha: 0.5)
        pageControl.columnSpacing = 2
        pageControl.hidesForSinglePage = true
        pageControl.isAnimation = true
        builder.pageControl = pageControl
        builder.layout = {
            pageControl.snp.makeConstraints { (maker) in
                maker.left.right.equalTo(coverView)
                maker.bottom.equalTo(coverView.snp.bottom).offset(-10)
                maker.height.equalTo(5)
            }
        }
        return builder
    }
}
