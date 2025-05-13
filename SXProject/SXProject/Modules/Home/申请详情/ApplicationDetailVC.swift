//
//  ApplicationDetailVC.swift
//  SXProject
//
//  Created by 王威 on 2025/2/23.
//

import UIKit

class ApplicationDetailVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initViews()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        // 恢复手势（避免影响其他页面）
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @objc func backClick() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    //MARM: - initializa
    func initViews() {
        view.backgroundColor = kBF8
        
        view.addSubview(topView)
        view.addSubview(centerView)
        view.addSubview(bottomLabel)
      
        initViewLayouts()
    }
    
    func initViewLayouts() {
        centerView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(sxDynamic(15))
            make.right.equalTo(view.snp.right).offset(sxDynamic(-15))
            make.top.equalTo(view.snp.top).offset(sxDynamic(292))
            make.height.equalTo(sxDynamic(280))
        }
        bottomLabel.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(sxDynamic(35))
            make.right.equalTo(view.snp.right).offset(sxDynamic(-35))
            make.bottom.equalTo(view.snp.bottom).offset(sxDynamic(-59))
        }
    }
    
    func configFaild() {
        topView.exchangeFaild()
        centerView.showFaild()
    }
    
    //MARM: - getter
    private lazy var topView: TopViewDetailView = {
        let view = TopViewDetailView()
        view.backBut.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        view.frame = CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: sxDynamic(360))
        
        return view
    }()
    
    private lazy var centerView: CenterViewDetailView = {
        let view = CenterViewDetailView()
        view.layer.cornerRadius = sxDynamic(8)
        
        
        return view
    }()
    
    private lazy var bottomLabel: UILabel = {
        let label = CreateBaseView.makeLabel("安全提示：易支用平台不收取任何费用，服务机构联系您放款前收取（例：手续费、保证金、会员费等）切勿盲信，谨防诈骗。", UIFont.sx.font_t13, kTaaa, .center, 0)
        
        return label
    }()


}
