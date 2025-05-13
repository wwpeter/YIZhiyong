//
//  BaseCell.swift
//  Sleep
//
//  Created by zyz on 2022/12/30.
//

import UIKit
import SXBaseModule

class BaseCell: UITableViewCell {
    
    lazy var bottomLine: UIView = UIView().then {
        $0.backgroundColor = AssetColors.be7E8E9.color
    }
    
    class func cellName() -> String {
        String(describing: Self.self)
    }
    
    class func registerBibCell(tableView: UITableView) {
        tableView.register(UINib.init(nibName: cellName(), bundle: nil), forCellReuseIdentifier: cellName())
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    func initView() {
        selectionStyle = .none
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
    
    deinit {
        printLog("释放！！")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
