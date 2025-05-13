//
//  URefresh.swift
//  Sleep
//
//  Created by 王威 on 2022/10/18.
//
//下拉刷新的自定义类

import UIKit
import MJRefresh

extension UIScrollView {
    var uHead: MJRefreshHeader? {
        get { return mj_header }
        set { mj_header = newValue }
    }
    
    var uFoot: MJRefreshFooter? {
        get { return mj_footer }
        set { mj_footer = newValue }
    }
}

class URefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        setImages([AssetImages.refreshIcon.image], for: .idle)
        setImages([AssetImages.refreshIcon1.image], for: .pulling)
        setImages([AssetImages.refreshIcon.image,
                   AssetImages.refreshIcon1.image,
                   AssetImages.refreshIcon2.image,
                   AssetImages.refreshIcon3.image], for: .refreshing)
        
        lastUpdatedTimeLabel?.isHidden = true
        stateLabel?.isHidden = true
    }
}

class URefreshAutoHeader: MJRefreshHeader {}

class URefreshFooter: MJRefreshBackNormalFooter {}

class URefreshAutoFooter: MJRefreshAutoFooter {}

class URefreshDiscoverFooter: MJRefreshBackGifFooter {
    
    override func prepare() {
        super.prepare()
        
        backgroundColor = AssetColors.bfff.color
        setImages([AssetImages.refreshDiscover.image], for: .idle)
        stateLabel?.isHidden = true
        refreshingBlock = { self.endRefreshing() }
    }
}

class URefreshTipKissFooter: MJRefreshBackFooter {
    
    lazy var tipLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.textColor = UIColor.lightGray
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.numberOfLines = 0
        return tl
    }()
    
    lazy var imageView: UIImageView = {
        let iw = UIImageView()
        iw.image = AssetImages.refreshKiss.image
        return iw
    }()
    
    override func prepare() {
        super.prepare()
        backgroundColor = AssetColors.bfff.color
        mj_h = 240
        addSubview(tipLabel)
        addSubview(imageView)
    }
    
    override func placeSubviews() {
        tipLabel.frame = CGRect(x: 0, y: 40, width: bounds.width, height: 60)
        imageView.frame = CGRect(x: (bounds.width - 80 ) / 2, y: 110, width: 80, height: 80)
    }
    
    convenience init(with tip: String) {
        self.init()
        refreshingBlock = { self.endRefreshing() }
        tipLabel.text = tip
    }
}
