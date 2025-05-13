//
//  DsWebController.swift
//  Sleep
//
//  Created by zyz on 2022/7/26.
//

import UIKit
import dsBridge

enum Namespace:String {
    case auth
    case device
    case page
    case ui
    case navigator
    case tracker
}

class DsWebController: ViewController {
    
    let failView: RequestFailView = RequestFailView().then {
        $0.frame = CGRect(x: (kSizeScreenWidth - 200) / 2, y: kSizeScreenHight / 2 - 160, width: 200, height: 200)
        $0.isHidden = true
    }
    
    private var titleObserve: NSKeyValueObservation!
    private var fialObserve: NSKeyValueObservation!
    
    // 初始化是需要加载的url
    var url: String = ""
    var showNav: Bool = true
    var config: WKWebViewConfiguration {
        let config = WKWebViewConfiguration()
        config.applicationNameForUserAgent = "DSBRIDGE_\(UIApplication.sx.version ?? "")_\(UIDevice.current.systemVersion)_iOS"
        return config
    }
    lazy var dsWebView: DWKWebView = DWKWebView(frame: CGRect.zero, configuration: config).then {
//        $0.addJavascriptObject(DsAuthApi(), namespace: Namespace.auth.rawValue)
//        $0.addJavascriptObject(DsDeviceApi(), namespace: Namespace.device.rawValue)
//        $0.addJavascriptObject(DsPageApi(), namespace: Namespace.page.rawValue)
//        $0.addJavascriptObject(DsUIApi(), namespace: Namespace.ui.rawValue)
//        $0.addJavascriptObject(DsNivApi(), namespace: Namespace.navigator.rawValue)
//        $0.addJavascriptObject(DsTracker(), namespace: Namespace.tracker.rawValue)
        $0.setDebugMode(true)
    }
    
    //加载网络web
    func requestURL() {
        //        dsWebView.navigationDelegate.self
                
        //        let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
        //        let urlPath = Bundle.main.path(forResource: "test", ofType: "html") ?? ""
        //
        //        let urlStr = try? String(contentsOfFile: urlPath, encoding: .utf8)
        //
        //        dsWebView.loadHTMLString(urlStr ?? "", baseURL: baseURL)
                if !url.isEmpty {
                    dsWebView.loadUrl(url)
                } else {
//                    dsWebView.loadUrl("https://www.baidu.com")
                   dsWebView.loadUrl("http://192.168.2.57:5173/#/test")
                }
        //        dsWebView.loadUrl("http://192.168.2.57:5173/#/test")
        //        dsWebView.loadUrl("https://www.baidu.com")
    }
    func setUp() {

        //加载
        self.requestURL()
        
        kSXNotificationCenter.addObserver(self, selector: #selector(netWorkStatus(noti:)), name: NSNotification.Name(rawValue:kZLNotificationnetWork), object: nil)
    }
    //动态改变视图
    private func exchangeFailView(_ show: Bool) {
        if show {
            self.failView.isHidden = false
        } else {
            self.failView.isHidden = true
            self.requestURL()
        }
    }
    
    func addAndLayoutSubView() {
        view.addSubview(dsWebView)
        dsWebView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.dsWebView.navigationDelegate = self
    }
    
    func bind() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        addAndLayoutSubView()
        bind()
        addObserve()
        
        //失败页面
        self.view.addSubview(failView)
        failView.clickBlock = { [weak self] in
            self?.exchangeFailView(false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc
    func settingEvent(btn: UIButton) {
    }
    override func hideNavigationBar() -> Bool {
        !showNav
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

//        self.perform(#selector(agent), with: nil, afterDelay: 2.0)
    }
    @objc
    func agent() {
        //navigator.userAgent
//        dsWebView.callHandler("navigator.userAgent", arguments: nil)
//        dsWebView.callHandler("navigator.userAgent") {value in
//        print("navigator.userAgent\(String(describing: value))")
//        }
    }
}

extension DsWebController {
    func addObserve() {
        titleObserve = dsWebView.observe(\.title, options: [.new]) { [weak self] foo, _  in
            self?.title = foo.title
        }
//        fialObserve = dsWebView.observe(\.isLoading, options: [.new]) { [weak self] foo, _  in
//            let status = foo.isLoading
//            printLog(status)
//        }
    }
}

//通知的回调
extension DsWebController {
    @objc
    func netWorkStatus(noti: Notification) {
        guard let object = noti.object as? [AnyHashable : Any],
             let _ = object["network"] as? Bool else {
                self.exchangeFailView(true)
                return
        }
        self.exchangeFailView(false)
    }
}

extension DsWebController: WKNavigationDelegate {
    /// 页面加载失败调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        printLog("加载失败！！！")
        self.exchangeFailView(true)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        printLog("加载完成！！！")
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        printLog("进入加载失败！！！")
        self.exchangeFailView(true)
    }
}
