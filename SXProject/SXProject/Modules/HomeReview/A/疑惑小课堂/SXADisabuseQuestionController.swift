//
//  SXADisabuseQuestionController.swift
//  SXProject
//
//  Created by Felix on 2025/5/19.
//


import UIKit

class SXADisabuseQuestionController: DDBaseViewController {
    
    // UI组件
    private let loanAmountTextField = UITextField()//金额
    private let loanTermTextField = UITextField() //期限
    private let yearPaymentTextField = UITextField() //年华
    private let returnTypeTextField = UITextField() //还款
    
    private var returnTypeIndex = -1
    
    fileprivate lazy var topView :UIView = {
        let tempView = UIView()
        let img_1 = UIImageView()
        img_1.image = DDSImage("disabuse_question_title")
        tempView.addSubview(img_1)
        
        let img_2 = UIImageView()
        img_2.image = DDSImage("disabuse_question_book")
        tempView.addSubview(img_2)
        
        img_2.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.right.equalTo(-30)
            make.width.equalTo(80)
            make.height.equalTo(62)
            make.bottom.equalTo(0)
        }
        
        img_1.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.width.equalTo(135)
            make.height.equalTo(20)
            make.centerY.equalTo(img_2.snp.centerY)
        }
        
        return tempView
    }()
    
    
    fileprivate lazy var mscollView:UIScrollView = {
        let tempView = UIScrollView()
        tempView.backgroundColor = .white
        tempView.layer.cornerRadius = 8
        tempView.backgroundColor = .white
        tempView.showsVerticalScrollIndicator = false
        return tempView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = "解惑小课堂"
        self.view.backgroundColor = .white
        let bgImg = UIImageView()
        bgImg.image = DDSImage("a_home_icon_1")
        self.view.addSubview(bgImg)
        bgImg.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
            make.height.equalTo(kSizeScreenWidth)
        }
        self.view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(kTopBarHeight)
        }
        
        self.view.addSubview(mscollView)
        mscollView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(topView.snp.bottom).offset(-4)
            make.bottom.equalTo(0)
        }
        
        let qustionView_1 = setupChildViews(imgeString: "disabuse_question_1", height: 230)
        mscollView.addSubview(qustionView_1)
        qustionView_1.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(20)
            make.width.equalTo(kSizeScreenWidth - 40)
        }
        
        let qustionView_2 = setupChildViews(imgeString: "disabuse_question_2", height: 290)
        mscollView.addSubview(qustionView_2)
        qustionView_2.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(qustionView_1.snp.bottom).offset(10)
        }
        
        let qustionView_3 = setupChildViews(imgeString: "disabuse_question_3", height: 250)
        mscollView.addSubview(qustionView_3)
        qustionView_3.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(qustionView_2.snp.bottom).offset(10)
        }
        
        let qustionView_4 = setupChildViews(imgeString: "disabuse_question_4", height: 300)
        mscollView.addSubview(qustionView_4)
        qustionView_4.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(qustionView_3.snp.bottom).offset(10)
        }
        
        let qustionView_5 = setupChildViews(imgeString: "disabuse_question_5", height: 200)
        mscollView.addSubview(qustionView_5)
        qustionView_5.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(qustionView_4.snp.bottom).offset(10)
        }
        
        let qustionView_6 = setupChildViews(imgeString: "disabuse_question_6", height: 190)
        mscollView.addSubview(qustionView_6)
        qustionView_6.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(qustionView_5.snp.bottom).offset(10)
            make.bottom.equalTo(-40)
        }
        
    }
    
    fileprivate func setupChildViews(imgeString:String,height:CGFloat )->UIView {
        let tempView = UIView()
        tempView.backgroundColor = kBF8
        tempView.setCorner(radius: 8)
        
        let img = UIImageView()
        img.image = DDSImage(imgeString)
        img.contentMode = .scaleAspectFit
        tempView.addSubview(img)
        img.snp.makeConstraints { make in
            make.left.equalTo(5)
            make.right.equalTo(-5)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.height.equalTo(height)
        }
        return tempView
    }
}
