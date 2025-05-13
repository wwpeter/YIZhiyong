//
//  TopGuideCell.swift
//  SXProject
//
//  Created by 王威 on 2025/2/23.
//

import UIKit

class TopGuideCell: UITableViewCell {

  
    class func cellID() -> String {
        return "TopGuideCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(TopGuideCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(110)
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
    
    func setDataSource(dic: [String:String]) {
        titlleLabel.text = dic["title"]
        subLabel.text = dic["sub"]
    }
    
    //MARK: - initializa
    func initViews() {
    
        contentView.addSubview(groundView)
        contentView.addSubview(subLabel)
        contentView.addSubview(titlleLabel)
    }
    
    override func layoutSubviews() {
        titlleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(35))
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(10))
            make.height.equalTo(sxDynamic(25))
        }
        groundView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(20))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
            make.top.equalTo(titlleLabel.snp.bottom).offset(sxDynamic(10))
            make.bottom.equalTo(contentView.snp.bottom).offset(sxDynamic(-5))
        }
        subLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(35))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-35))
            make.top.equalTo(groundView.snp.top).offset(sxDynamic(15))
            make.bottom.equalTo(groundView.snp.bottom).offset(sxDynamic(-15))
        }
    }
    
    //MARK: - getter
    
    private lazy var titlleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("", UIFont.sx.font_t16Blod, kT333, .left, 1)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = CreateBaseView.makeLabel("", UIFont.sx.font_t13, kT333, .left, 0)
      
        
        return label
    }()
    
    private lazy var groundView: UIView = {
        let view = UIView()
        view.backgroundColor = kBF8
        view.layer.cornerRadius = sxDynamic(16)
        
        return view
    }()
}
