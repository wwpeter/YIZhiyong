//
//  ListCardCell.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

class ListCardCell: UITableViewCell {
    
    class func cellID() -> String {
        return "ListCardCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(ListCardCell.self, forCellReuseIdentifier: cellID())
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
    func setTitle(model: BankCardModel) {
        nameLabel.text = model.bank
        cardNumberLabel.text = model.cardNum
    }

    func initViews() {
        contentView.addSubview(groundView)
        groundView.addSubview(bankCard)
        groundView.addSubview(nameLabel)
        groundView.addSubview(cardNumberLabel)
        
        gradient()
    }
    
    override func layoutSubviews() {
       
        bankCard.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(45))
            make.left.equalTo(groundView.snp.left).offset(sxDynamic(10))
            make.top.equalTo(groundView.snp.top).offset(sxDynamic(15))
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(bankCard.snp.top)
            make.height.equalTo(sxDynamic(20))
            make.left.equalTo(bankCard.snp.right).offset(sxDynamic(12))
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(-20))
        }
        cardNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(sxDynamic(36))
            make.height.equalTo(sxDynamic(20))
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(-20))
            make.left.equalTo(nameLabel.snp.left)
        }
    }

    private func gradient() {
         let gradientLayer = CAGradientLayer.init()
         gradientLayer.frame = groundView.bounds
         gradientLayer.colors = [AssetColors.b60Eae6.color.cgColor, AssetColors.b16Bebe.color.cgColor]
         gradientLayer.startPoint = CGPoint(x: 0, y: 0)
         gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        groundView.layer.insertSublayer(gradientLayer, at: 0)
        
        groundView.layer.cornerRadius = sxDynamic(8)
        groundView.layer.masksToBounds = true
     }
    //MARK: - getter
    
    private lazy var groundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = sxDynamic(8)
        view.frame = CGRectMake(sxDynamic(15), sxDynamic(10), kSizeScreenWidth - sxDynamic(30), sxDynamic(123))
        
        return view
    }()
    
    private lazy var bankCard: UIImageView = {
        let img = CreateBaseView.makeIMG("bank_card", .scaleAspectFit)
        
        return img
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = CreateBaseView.makeLabel("--", UIFont.sx.font_t16, .white, .left, 1)
        
        return label
    }()
    
    private lazy var cardNumberLabel: UILabel = {
        let label = CreateBaseView.makeLabel("--", UIFont.sx.font_t16, .white, .left, 1)
        
        return label
    }()
}
