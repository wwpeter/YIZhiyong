//
//  TestCell.swift
//  SXProject
//
//  Created by 王威 on 2025/2/28.
//

import UIKit

class TestCell: UITableViewCell {
    class func cellID() -> String {
        return "TestCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(TestCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(51)
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
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    //MARK: - getter
}
