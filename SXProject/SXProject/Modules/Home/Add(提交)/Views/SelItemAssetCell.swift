//
//  SelItemAssetCell.swift
//  SXProject
//
//  Created by 王威 on 2025/4/8.
//

import UIKit

typealias SelItemAssetCellBlock = (_ arr: [Bool]) -> Void
class SelItemAssetCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var assetBlock: SelItemAssetCellBlock?
    var assetInfoArr = ["有社保", "有公积金", "有房产", "有车产", "有微粒贷", "有信用卡", "有保单", "有白条", "有花呗", "无逾期", "本科及以上", "以上均无"]

    /// 选中资产
    var assetSelArr = [false, false, false, false, false, false, false, false, false, false, false, false,]
    
    /// 是否操作过
    var control = false
    /*
     社保code - Z ，BB 无
     公积金
     */
    func refreshTableView(selArr: [Bool]) {
        assetSelArr.removeAll()
        assetSelArr.append(contentsOf: selArr)
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        assetInfoArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell {
            
            /// 查看以上均无的 选项
            let noneAbove = assetSelArr[11]
            
            if noneAbove == true {
                assetSelArr.enumerated().map { index, result in
                    assetSelArr[index] = false
                    if index == assetSelArr.count - 1 {
                        assetSelArr[index] = true
                    }
                }
                cell.exchangeSel(sel: false)
                if indexPath.row == 11 {
                    cell.exchangeSel(sel: true)
                }
            } else {
                let tempSel = assetSelArr[indexPath.row]
                cell.exchangeSel(sel: tempSel)
            }
            
            let titleStr = assetInfoArr[indexPath.row]
            cell.setTitle(title: titleStr)
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < assetSelArr.count - 1 {
            assetSelArr[11] = false
        }
        var tempSel = assetSelArr[indexPath.row]
        tempSel = !tempSel
        
        assetSelArr[indexPath.row] = tempSel
        self.collectionView.reloadData()
        
        guard let blockT = assetBlock else {return}
        blockT(assetSelArr)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
        var tempSel = assetSelArr[indexPath.row]
        tempSel = !tempSel
        
        assetSelArr[indexPath.row] = tempSel
        self.collectionView.reloadData()
        
        guard let blockT = assetBlock else {return}
        blockT(assetSelArr)
    }
    
    class func cellID() -> String {
        return "SelItemAssetCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(SelItemAssetCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(240)
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
        layout.minimumInteritemSpacing = sxDynamic(0)
        layout.minimumLineSpacing = sxDynamic(10)

        let width = (kSizeScreenWidth - sxDynamic(62)) / 3
//        layout.headerReferenceSize = CGSize(width: kSizeScreenWidth - sxDynamic(60), height: sxDynamic(210))
        layout.itemSize = CGSize(width: width, height: sxDynamic(45))
        
        collectionView = UICollectionView.init(frame: CGRectMake(sxDynamic(20), sxDynamic(10), kSizeScreenWidth - sxDynamic(40), sxDynamic(240)), collectionViewLayout: layout)
        
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
