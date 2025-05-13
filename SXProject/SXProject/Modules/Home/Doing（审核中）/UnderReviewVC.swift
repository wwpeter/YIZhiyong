//
//  UnderReviewVC.swift
//  SXProject
//
//  Created by 王威 on 2025/2/23.
//

import UIKit

class UnderReviewVC: ViewController {

    /// 提交的资料
    var addModel = AddModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initViews()
        config()
        
        submitInfo()
    }
    
    func submitInfo() {
       
        let jsonDictionary = JSONHelper.modelToDictionary(addModel)
        Toast.showWaiting()
        //kLogin
        NetworkRequestManager.sharedInstance().requestPath(kLoanInformation, withParam: jsonDictionary) { [weak self] result in
            let dic = JSONHelper.exchangeDic(jsonStr: result)
            
            let result = dic["result"] as? Bool
            if result == true {
                let vc = ApplicationDetailVC()
                
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = ApplicationDetailVC()
                vc.configFaild()
                self?.navigationController?.pushViewController(vc, animated: true)
            }
           
        } failure: { error in
           
            
        }
    }
    
    func initViews() {
        view.backgroundColor = kWhite
        view.addSubview(centerImg)
        view.addSubview(titleLabel)
        view.addSubview(backBut)
        initViewLayouts()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        // 恢复手势（避免影响其他页面）
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    func initViewLayouts() {
        centerImg.snp.makeConstraints { make in
            make.width.equalTo(sxDynamic(185))
            make.height.equalTo(sxDynamic(sxDynamic(100)))
            make.top.equalTo(view.snp.top).offset(sxDynamic(260))
            make.centerX.equalTo(view.snp.centerX)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(centerImg.snp.bottom).offset(sxDynamic(50))
            make.centerX.equalTo(view.snp.centerX)
        }
        backBut.snp.makeConstraints { make in
            make.width.equalTo(sxDynamic(90))
            make.height.equalTo(sxDynamic(sxDynamic(40)))
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(30))
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    
    func config() {
        self.SX_navTitle = "审核中"
    }

    
    //MARK: - getter
    private lazy var centerImg: UIImageView = {
        let img = CreateBaseView.makeIMG("shenhezhong_icon", .scaleAspectFit)
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = CreateBaseView.makeLabel("正在审核您的资质信息~", UIFont.sx.font_t16Blod, kT333, .center, 1)
        
        return titleLabel
    }()
    @objc func dismissVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    private lazy var backBut: UIButton = {
        let but = CreateBaseView.makeBut("返回首页", kWhite, kTBlue, UIFont.sx.font_t13)
        but.layer.cornerRadius = sxDynamic(21)
        but.layer.borderWidth = sxDynamic(1)
        but.layer.borderColor = kTBlue.cgColor
        but.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        return but
    }()
 
}
