//
//  AddCardListCell.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

typealias AddCardListCellBlock = () -> Void
class AddCardListCell: UITableViewCell {

    var blockClick: AddCardListCellBlock?
    class func cellID() -> String {
        return "AddCardListCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(AddCardListCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(133)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        contentView.backgroundColor = kBF8
        self.selectionStyle = .none
        initViews()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - action


    func initViews() {
        contentView.addSubview(groundView)
        groundView.addSubview(bankCard)
        groundView.addSubview(titleLabel)
        
        contentView.addSubview(ctr)
    }
    
    override func layoutSubviews() {
        groundView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(sxDynamic(15))
            make.trailing.equalTo(contentView.snp.trailing).offset(sxDynamic(-15))
            make.top.bottom.equalTo(self)
        }
        bankCard.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(15))
            make.centerY.equalTo(groundView.snp.centerY)
            make.right.equalTo(groundView.snp.centerX).offset(sxDynamic(-20))
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(bankCard.snp.centerY)
            make.height.equalTo(sxDynamic(20))
            make.left.equalTo(bankCard.snp.right).offset(sxDynamic(5))
        }
        
        ctr.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    @objc func addBack() {
        guard let blockT = blockClick else {return}
        blockT()
    }
    
    //MARK: - getter
    private lazy var groundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = sxDynamic(8)
//        view.frame = CGRectMake(0, sxDynamic(10), kSizeScreenWidth - sxDynamic(30), sxDynamic(123))
        
        return view
    }()
    
    private lazy var bankCard: UIImageView = {
        let img = CreateBaseView.makeIMG("cell_add_card", .scaleAspectFit)
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = CreateBaseView.makeLabel("添加银行卡", UIFont.sx.font_t16, kT333, .left, 1)
        
        return titleLabel
    }()
    
    private lazy var ctr: UIControl = {
        let ctr = UIControl()
        ctr.addTarget(self, action: #selector(addBack), for: .touchUpInside)
        
        return ctr
    }()
    
}
