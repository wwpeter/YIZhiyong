//
//  SelItemCell.swift
//  SXProject
//
//  Created by 王威 on 2025/3/29.
//

import UIKit

typealias SelItemCellBlock = (_ index: Int) -> Void
class SelItemCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var limitArr = ["3-5万", "5-10万", "10万以上"]
    
    var indexBlock: SelItemCellBlock?
    /// 额度选中
    var limitIndex = -1
    
    func refreshTableView(selIndex: Int) {
        limitIndex = selIndex
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        limitArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell {
            
            if limitIndex == indexPath.row {
                cell.exchangeSel(sel: true)
            } else {
                cell.exchangeSel(sel: false)
            }
            let titleStr = limitArr[indexPath.row]
            cell.setTitle(title: titleStr)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        limitIndex = indexPath.row
        self.collectionView.reloadData()
        
        guard let blockT = indexBlock else {return}
        blockT(limitIndex)
    }
    
    class func cellID() -> String {
        return "SelItemCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(SelItemCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(75)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
        self.selectionStyle = .none
        initViews()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - action

    
    //MARK: - initializa
    func initViews() {
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalTo(self)
//        }
    }
    
    //MARK: - getter
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = sxDynamic(10)
//        layout.minimumLineSpacing = sxDynamic(15)

        let width = (kSizeScreenWidth - sxDynamic(62)) / 3
//        layout.headerReferenceSize = CGSize(width: kSizeScreenWidth - sxDynamic(60), height: sxDynamic(210))
        layout.itemSize = CGSize(width: width, height: sxDynamic(52))
        
        collectionView = UICollectionView.init(frame: CGRectMake(sxDynamic(20), sxDynamic(10), kSizeScreenWidth - sxDynamic(40), sxDynamic(75)), collectionViewLayout: layout)
        
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "ItemCell")
 
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        collectionView.backgroundColor = kWhite
        collectionView.showsHorizontalScrollIndicator = false
//        listCollection.layer.cornerRadius = 2
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: sxDynamic(0), left: sxDynamic(0), bottom:0, right: sxDynamic(0))
        
        return collectionView
    }()
}
