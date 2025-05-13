//
//  SendCodeVC.swift
//  SXProject
//
//  Created by 王威 on 2025/2/22.
//

import UIKit

class SendCodeVC: ViewController {

    /// 验证码
    var startCode = ""
    ///发送验证码之后的 倒计时
    var countdownSeconds = 60
    var timer: Timer?
    /// 使用代码创建一个View会调用该构造方法
    ///  手机号
    var telephone = "" {
        didSet {
            setPhone()
        }
    }
    
    func setPhone() {
        subLabel.text = String.init(format: "我们已给手机号码%@发送了一个4位数的验证码，输入验证码即可登录", telephone)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
    }
    
    func initViews() {
        view.backgroundColor = .white
        codeUI()
        
        view.addSubview(titleLabel)
        view.addSubview(subLabel)
        
        view.addSubview(codeBut)
        view.addSubview(codeSecond)
        
        initViewLayouts()
        
        startCountdown()
    }
    
    func initViewLayouts() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(sxDynamic(30))
            make.top.equalTo(view.snp.top).offset(sxDynamic(60) + kTopBarHeight)
        }
        subLabel.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading).offset(sxDynamic(30))
            make.trailing.equalTo(view.snp.trailing).offset(sxDynamic(-30))
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(10))
        }
        
        codeBut.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(sxDynamic(125))
            make.trailing.equalTo(view.snp.trailing).offset(sxDynamic(-30))
            
        }
        codeSecond.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(sxDynamic(125))
            make.trailing.equalTo(view.snp.trailing).offset(sxDynamic(-30))
        }
    }
    
    //MAKR: - 验证码倒计时功能
    func startCountdown() {
        countdownSeconds = 60
        // 每秒减少计数并更新界面
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            if self?.countdownSeconds ?? 0 > 0 {
                self?.countdownSeconds -= 1
                self?.codeSecond.isHidden = false
                self?.codeBut.isHidden = true
                print("倒计时: \(String(describing: self?.countdownSeconds))秒")
                let tempStr = "重新发送".sx_T
                self?.codeSecond.text = String.init(format: "%@%ld\("s")", tempStr, self?.countdownSeconds ?? 0)
            } else {
                // 倒计时结束
                timer.invalidate()
                print("倒计时结束")
                self?.codeSecond.isHidden = true
                self?.codeBut.isHidden = false
            }
        }
        
        // 设置计时器在主运行循环中运行
        RunLoop.current.add(timer!, forMode: .common)
        
        // 在倒计时结束后取消计时器
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(countdownSeconds)) {
            self.timer?.invalidate()
        }
    }
    //MARK: - actions
    @objc
    private func codeClick(button: UIButton) {

        
        //防止连点
        button.isEnabled = false // 禁用按钮
          
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            button.isEnabled = true // 1秒后启用按钮
        }
        
    }
    
    //MARK: - getter
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("请输入验证码", UIFont.sx.font_t24Blod, kT333, .left, 1)
        
        return label
    }()
    private lazy var subLabel: UILabel = {
        let label = CreateBaseView.makeLabel("我们已给手机号码xxx发送了一个4位数的验证码，输入验证码即可登录", UIFont.sx.font_t13, kT777, .left, 2)
        
        return label
    }()

    /// 密码输入 闪烁特效
    func codeUI() {
        //
        var config = JHVCConfig()
        config.inputBoxNumber = 4
        config.inputBoxSpacing = sxDynamic(20)
        config.inputBoxWidth = sxDynamic(63)
        config.inputBoxHeight = sxDynamic(63)
        config.tintColor = kTBlue
        config.secureTextEntry = false
        config.inputBoxColor = kBF8
        config.groundColor = kBF8
        config.font = UIFont.boldSystemFont(ofSize: 15)
        config.textColor = kT333
        config.inputType = JHVCConfigInputType.number
        config.inputBoxBorderWidth = 1
        config.inputBoxCornerRadius = 5
        config.keyboardType = UIKeyboardType.numberPad
        
        config.autoShowKeyboard = true
        config.autoShowKeyboardDelay = 0.7
        
//        config.inputBoxFinishColors = [UIColor.white, UIColor.white]
//        config.finishFonts = [UIFont.boldSystemFont(ofSize: 20), UIFont.systemFont(ofSize: 20)]
//        config.finishTextColors = [UIColor.green, UIColor.orange]
        
        let codeView = JHVerifyCodeView.init(frame: CGRect(x: 0, y: sxDynamic(160) + kTopBarHeight, width: kSizeScreenWidth, height: sxDynamic(63)),
                                             config: config)
        codeView.inputBlock = { (text: String) -> () in
            printLog(text)
            self.startCode = text
        }
        codeView.finishBlock = { (view: JHVerifyCodeView, code: String) -> () in
            self.goLogin()
          
        }
        codeView.tag = 100
        self.view.addSubview(codeView)
    }
    
    private lazy var codeBut: UIButton = {
        let but = UIButton.init(type: .custom)
        but.titleLabel?.font = UIFont.sx.font_t13
        but.setTitle("重新发送", for: .normal)
        but.isHidden = true
     
        but.setTitleColor(kTBlue, for: .normal)
        but.addTarget(self, action: #selector(codeClick(button:)), for: .touchUpInside)
        
        return but
    }()
    ///发送验证码之后的倒计时
    private lazy var codeSecond: UILabel = {
        let codeSecond = CreateBaseView.makeLabel("", UIFont.sx.font_t13, kT777, .right, 1)
        codeSecond.isHidden = true
        
        return codeSecond
    }()
}
