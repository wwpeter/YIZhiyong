//
//  WebController.swift
//  DigitalSleep
//
//  Created by zs on 2021/12/1.
//

import UIKit
import WebKit

class WebController: BaseController {

    @IBOutlet weak private var go: UIBarButtonItem!
    
    @IBOutlet weak private var back: UIBarButtonItem!
    
    @IBOutlet weak private var webTitle: UILabel!
    
    @IBOutlet weak private var refresh: UIButton!
    
    @IBOutlet weak private var webView: WKWebView!
    
    @IBOutlet weak private var progressView: UIProgressView!
    
    var url: URL!
    
    // 重定向成功的地址
    var receiveServer: String?
    // 重定向后的回调
    var receiveServerParamesClosure: (([String: String]?) -> Void)?

    private var backObserve: NSKeyValueObservation!
    private var goObserve: NSKeyValueObservation!
    private var titleObserve: NSKeyValueObservation!
    private var progressObserve: NSKeyValueObservation!
    
    let failView: RequestFailView = RequestFailView().then {
        $0.frame = CGRect(x: (kSizeScreenWidth - 100) / 2, y: kSizeScreenHight / 2 - 50, width: 100, height: 100)
        $0.isHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.requestURL()
        webView.navigationDelegate = self
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        
        addObserve()
        
        self.view.addSubview(failView)
        failView.clickBlock = { [weak self] in
            self?.exchangeFailView(false)
        }
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
    
    //加载网络web
    func requestURL() {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @IBAction private func backAction(_ sender: UIBarButtonItem) {
        if webView.canGoBack { webView.goBack() }
    }
    
    @IBAction private func goAction(_ sender: UIBarButtonItem) {
        if webView.canGoForward { webView.goForward() }
    }
    @IBAction private func doneAction(_ sender: UIButton) {
        dismiss()
    }
    @IBAction private func refreshAction(_ sender: UIButton) {
        webView.reload()
    }
    
    private func dismiss() {
        if self.presentingViewController != nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    deinit {
//        webView.load(URLRequest(url: URL(string: "about:blank")!))
    }
}

extension WebController {
    func addObserve() {
        backObserve = webView.observe(\.canGoBack, options: [.new]) { [weak self] foo, _  in
            self?.back.isEnabled = foo.canGoBack
        }
        goObserve = webView.observe(\.canGoForward, options: [.new]) { [weak self] foo, _  in
            self?.go.isEnabled = foo.canGoForward
        }
        titleObserve = webView.observe(\.title, options: [.new]) { [weak self] foo, _  in
            self?.webTitle.text = foo.title
        }
        progressObserve = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] foo, _  in
            let progress = Float(foo.estimatedProgress)
            self?.progressView.progress = progress >= 1 ? 0.0 : progress
        }
        
        kSXNotificationCenter.addObserver(self, selector: #selector(netWorkStatus(noti:)), name: NSNotification.Name(rawValue:kZLNotificationnetWork), object: nil)
    }
}

//通知的回调
extension WebController {
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

extension WebController: WKNavigationDelegate {
    
    /// 页面加载失败调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // 进度条设置为0
        progressView.setProgress(0.0, animated: true)
        self.exchangeFailView(true)
    }
    /// 提交发生错误
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // 进度条设置为0
        progressView.setProgress(0.0, animated: true)
        self.exchangeFailView(true)
    }
    /// 重定向
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        printLog("重定向\(String(describing: webView.url))")
    }
    /// 接收到服务器跳转的http
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let receiveServer = receiveServer,
              let receiveServerParamesClosure = receiveServerParamesClosure  else {
                decisionHandler(.allow)
                return
        }

        if let url = webView.url,
           url.absoluteString.contains(receiveServer) {
            receiveServerParamesClosure(url.queryParameters)
            decisionHandler(.cancel)
            dismiss()
            return
        }
        decisionHandler(.allow)
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        printLog("加载完成！！")
    }
}
