//
//  SelItemOtherCell.swift
//  SXProject
//
//  Created by 王威 on 2025/4/8.
//

import UIKit
typealias SelItemOtherCellBlock = (_ zhimaIndex: Int, _ zhiyeIndex: Int) -> Void
class SelItemOtherCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    var indexBlock: SelItemOtherCellBlock?
    /// 芝麻分
    var zhimafenArr = ["600以下" ,"600-650" ,"650-700", "700以上", "无"]
    /// 职业
    var occupationArr = ["上班族", "个体户", "自由职业" ,"企业主" ,"公务员/国企事业单位"]
    
    /// 芝麻分选中
    var zhimaIndex = -1
    /// 职业选中
    var zhiyeIndex = -1
    func refreshTableView(zhima: Int, zhiye: Int) {
        zhimaIndex = zhima
        zhiyeIndex = zhiye
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 9999 {
            return zhimafenArr.count
        } else {
            return occupationArr.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as? ItemCell {
            if collectionView.tag == 9999 {
                
                if zhimaIndex == indexPath.row {
                    cell.exchangeSel(sel: true)
                } else {
                    cell.exchangeSel(sel: false)
                }
                let titleStr = zhimafenArr[indexPath.row]
                cell.setTitle(title: titleStr)
                
            } else {
                if zhiyeIndex == indexPath.row {
                    cell.exchangeSel(sel: true)
                } else {
                    cell.exchangeSel(sel: false)
                }
                let titleStr = occupationArr[indexPath.row]
                cell.setTitle(title: titleStr)
            }
         
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 9999 {
            zhimaIndex = indexPath.row
            
            self.collectionView.reloadData()
            
        } else {
            zhiyeIndex = indexPath.row
            
            self.zyCollectionView.reloadData()
        }
        guard let blockT = indexBlock else {return}
        blockT(zhimaIndex, zhiyeIndex)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    class func cellID() -> String {
        return "SelItemOtherCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(SelItemOtherCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(330)
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
        
        addSubview(titleLabelT)
        addSubview(zyCollectionView)
        
        addSubview(titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalTo(self)
//        }
    }
    
    //MARK: - getter
    
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("芝麻分", UIFont.sx.font_t14, kT333, .left, 1)
        label.frame = CGRectMake(sxDynamic(20), sxDynamic(5), sxDynamic(100), sxDynamic(22))
        
        return label
    }()
    
    private lazy var titleLabelT: UILabel = {
        let label = CreateBaseView.makeLabel("职业身份", UIFont.sx.font_t14, kT333, .left, 1)
        label.frame = CGRectMake(sxDynamic(20), sxDynamic(155), sxDynamic(100), sxDynamic(22))
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = sxDynamic(10)
        layout.minimumLineSpacing = sxDynamic(10)

        let width = (kSizeScreenWidth - sxDynamic(62)) / 3
//        layout.headerReferenceSize = CGSize(width: kSizeScreenWidth - sxDynamic(60), height: sxDynamic(210))
        layout.itemSize = CGSize(width: width, height: sxDynamic(52))
        
        collectionView = UICollectionView.init(frame: CGRectMake(sxDynamic(20), sxDynamic(30), kSizeScreenWidth - sxDynamic(40), sxDynamic(115)), collectionViewLayout: layout)
        
        collectionView.register(ItemCell.self, forCellWithReuseIdentifier: "ItemCell")
 
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.tag = 9999
        collectionView.backgroundColor = kWhite
        collectionView.showsHorizontalScrollIndicator = false
//        listCollection.layer.cornerRadius = 2
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: sxDynamic(0), left: sxDynamic(0), bottom:0, right: sxDynamic(0))
        
        return collectionView
    }()

    private lazy var zyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = sxDynamic(10)
        layout.minimumLineSpacing = sxDynamic(10)

        let width = (kSizeScreenWidth - sxDynamic(62)) / 3
//        layout.headerReferenceSize = CGSize(width: kSizeScreenWidth - sxDynamic(60), height: sxDynamic(210))
        layout.itemSize = CGSize(width: width, height: sxDynamic(52))
        
        zyCollectionView = UICollectionView.init(frame: CGRectMake(sxDynamic(20), sxDynamic(182), kSizeScreenWidth - sxDynamic(40), sxDynamic(115)), collectionViewLayout: layout)
        
        zyCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: "ItemCell")
 
        zyCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        zyCollectionView.tag = 6666
        zyCollectionView.backgroundColor = kWhite
        zyCollectionView.showsHorizontalScrollIndicator = false
//        listCollection.layer.cornerRadius = 2
        zyCollectionView.delegate = self
        zyCollectionView.dataSource = self
        zyCollectionView.contentInset = UIEdgeInsets(top: sxDynamic(0), left: sxDynamic(0), bottom:0, right: sxDynamic(0))
        
        return zyCollectionView
    }()

}
