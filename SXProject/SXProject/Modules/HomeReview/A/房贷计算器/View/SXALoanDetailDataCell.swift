//
//  SXALoanDetailDataCell.swift
//  DDStudyBlind
//
//  Created by Felix on 2023/6/15.
//

import UIKit
import SnapKit

class SXALoanDetailDataCell: UITableViewCell {

    func updateCellWithModel(_ model:SXALoadPaymentDetailModel,_ aIndex:Int) {
        if aIndex % 2 == 0 {
            baseView.backgroundColor = .clear
        } else {
            baseView.backgroundColor = kBF8
        }
        qiShuLabel.text = "\(model.month)"
        let toalt = model.principal + model.interest
        monthReturnLabel.text = toalt.format(".2")
        benJinLabel.text = model.principal.format(".2")
        lixiLabel.text = model.interest.format(".2")
    }
    
    fileprivate var baseView:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.setCorner(8)
        return view
    }()
    
    fileprivate var qiShuLabel:UILabel = {
        let label = UILabel()
        label.font = DDSFont(13)
        label.textColor = kT333
        label.text = "1"
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var monthReturnLabel:UILabel = {
        let label = UILabel()
        label.textColor = kT333
        label.font = DDSFont(13)
        label.textAlignment = .center
        label.text = "129.23"
        return label
    }()
    
    fileprivate var benJinLabel:UILabel = {
        let label = UILabel()
        label.textColor = kT333
        label.font = DDSFont(13)
        label.textAlignment = .center
        label.text = "15,916.9"
        return label
    }()

    fileprivate var lixiLabel:UILabel = {
        let label = UILabel()
        label.textColor = kT333
        label.font = DDSFont(13)
        label.textAlignment = .center
        label.text = "12.3"
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

extension SXALoanDetailDataCell {
    fileprivate func setUpViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(baseView)
        baseView.addSubview(qiShuLabel)
        baseView.addSubview(monthReturnLabel)
        baseView.addSubview(benJinLabel)
        baseView.addSubview(lixiLabel)

        baseView.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(40)
        }
        qiShuLabel.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.width.equalTo(60)
            make.top.bottom.equalTo(0)
        }
 
        monthReturnLabel.snp.makeConstraints { make in
            make.left.equalTo(qiShuLabel.snp.right)
            make.top.bottom.equalTo(0)
        }
        
        benJinLabel.snp.makeConstraints { make in
            make.left.equalTo(monthReturnLabel.snp.right)
            make.top.bottom.equalTo(0)
            make.width.equalTo(monthReturnLabel)
        }
        lixiLabel.snp.makeConstraints { make in
            make.left.equalTo(benJinLabel.snp.right)
            make.top.bottom.equalTo(0)
            make.width.equalTo(monthReturnLabel)
            make.right.equalTo(0)
        }
    }
}
