//
//  UpdateTipsController.swift
//  Sleep
//
//  Created by 王威 on 2022/11/21.
//

import UIKit

class UpdateTipsController: UIViewController {
    
    var model: AppUpdate?

    @IBOutlet private weak var contentBgView: UIView!
    
    @IBOutlet private weak var contenLab: UILabel!
  
    @IBOutlet private weak var fuButton: UIButton!
    
    @IBOutlet private weak var bottomViewHeight: NSLayoutConstraint!
    
    @IBOutlet private weak var fuView: UIView!
    
    @IBOutlet private weak var suView: UIView!
    
    @IBOutlet private weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.model = AppUpdate()
        self.model?.app_Version = "V1.1.0\n"
        self.model?.app_Update_Content = "1、 这里是笨笨更新内容 \n 2、 到这里是加下里的内容\n3、 知道阿斯顿发山东阿斯顿发\n4、发觉咖啡机卡了几点几分啦"
        self.model?.app_Is_Force_Update = false
        
        createSubviews()
    }

    func createSubviews() {
        self.contenLab.text = "\(self.model?.app_Version ?? "")\(self.model?.app_Update_Content ?? "")"
        self.fuButton.layer.cornerRadius = 22
        self.contentBgView.layer.cornerRadius = 8
        self.contentBgView.layer.masksToBounds = true
     
        if self.model?.app_Is_Force_Update == true {
            self.closeButton.isHidden = true
            self.suView.isHidden = true
            self.fuView.isHidden = false
            self.bottomViewHeight.constant = 64
        } else {
            self.closeButton.isHidden = false
            self.suView.isHidden = false
            self.fuView.isHidden = true
            self.bottomViewHeight.constant = 55
        }
//        self.view.layoutIfNeeded()
//        let height = CGFloat(CGRectGetMaxY(self.contenLab.frame) + 70)
//        self.contenViewHeight.constant = height
    }

    // MARK: - Action
    // 关闭
    @IBAction private func closeAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    // 更新
    
    @IBAction private func updateAction(_ sender: Any) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://apps.apple.com/cn/app/id962607998"]];
        let url: NSURL = NSURL.init(string: "")!
        UIApplication.shared.open(url as URL)
    }
    
    // 不再更新
    @IBAction private func noTipsAction(_ sender: Any) {
//        [XDUserinfoObject setSelectUpdateWithVersion:self.model.app_Version];
        self.dismiss(animated: true)
    }
}
