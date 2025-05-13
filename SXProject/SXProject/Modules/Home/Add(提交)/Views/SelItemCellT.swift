//
//  SelItemCellT.swift
//  SXProject
//
//  Created by 王威 on 2025/4/8.
//

import UIKit

typealias SelItemCellTBlock = (_ index: Int) -> Void
class SelItemCellT: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource  {
    var userTimeArr = ["3个月", "6个月", "12个月以上"]
    /// 额度选中
    var userTimeIndex = -1
    var indexBlock: SelItemCellTBlock?
    
    func refreshTableView(selIndex: Int) {
        userTimeIndex = selIndex
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userTimeArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell {
            let titleStr = userTimeArr[indexPath.row]
            cell.setTitle(title: titleStr)
            if userTimeIndex == indexPath.row {
                cell.exchangeSel(sel: true)
            } else {
                cell.exchangeSel(sel: false)
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userTimeIndex = indexPath.row
        self.collectionView.reloadData()
        
        guard let blockT = indexBlock else {return}
        blockT(userTimeIndex)
    }
    
    class func cellID() -> String {
        return "SelItemCellT"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(SelItemCellT.self, forCellReuseIdentifier: cellID())
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
