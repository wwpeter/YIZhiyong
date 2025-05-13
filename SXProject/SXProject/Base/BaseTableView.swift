//
//  BaseTableView.swift
//  Sleep
//
//  Created by zyz on 2023/1/2.
//

import UIKit
import EmptyDataSet_Swift
import SwiftRichString

class BaseTableView: UITableView, EmptyDataSetSource, EmptyDataSetDelegate {
    
//    var headerRefresh: Bool = false {
//        willSet {
//            self.uHead = newValue ? URefreshHeader { [weak self] in self?.headerRefreshTrigger.onNext(false) } : nil
//        }
//    }
//    
//    var footerRefresh: Bool = false {
//        willSet {
//            self.uFoot = newValue ? URefreshFooter { [weak self] in self?.footerRefreshTrigger.onNext(false) } : nil
//        }
//    }
    
//    func customView(forEmptyDataSet scrollView: UIScrollView) -> UIView? {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
//        view.backgroundColor = UIColor.red
//        return view
//    }
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        AssetImages.defaultEmpty.image
    }
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        "暂无内容".set(style: "")
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initViews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    func initViews() {
        self.separatorStyle = .none
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
}
