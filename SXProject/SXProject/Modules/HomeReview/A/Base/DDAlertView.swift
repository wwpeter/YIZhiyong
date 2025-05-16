//
//  DDAlertView.swift
//  FNEnjoySwfitLib
//
//  Created by Felix on 2021/11/2.
//

import UIKit
import SnapKit

fileprivate let POP_VIEW_HEIGHT:CGFloat = 200
fileprivate let POP_VIEW_WIDHT:CGFloat = 300

@objc
public class DDAlertView: UIView {
    public typealias clickAlertClosure = () -> Void //声明闭包，点击按钮传值
    @objc public var clickClosure: clickAlertClosure?
    fileprivate var cancelClosure: clickAlertClosure?
    fileprivate var closeClosure: clickAlertClosure?

    //为闭包设置调用函数
    @objc public func sureBlock(_ closure:clickAlertClosure?){
        //将函数指针赋值给myClosure闭包
        clickClosure = closure
    }
    
    @objc public func cancleBlock(_ closure:clickAlertClosure?){
        //将函数指针赋值给myClosure闭包
        cancelClosure = closure
    }
    
    @objc public func closeBlock(_ closure:clickAlertClosure?){
        //将函数指针赋值给myClosure闭包
        closeClosure = closure
    }
    
    //MARK:消失
    @objc public func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.baseView.alpha = 0
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        })
    }
    
    @objc public func show() {
        let wind = UIWindow.getKeyWindow()
        self.alpha = 0
        wind?.addSubview(self)
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 1
        })
    }
    
    @objc init(_ title: String = "提示",content:String,cancelButtonTitle: String?, sureButtonTitle: String?,isTextCenter:Bool = false) {
        super.init(frame: CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: kSizeScreenHight))
        setupAlertView(cancelButtonTitle)
        self.titleLabel.text = title
        self.contentLabel.text = content
        
        var textHeight = calculateTextHeight(text: content, font: self.contentLabel.font, width: POP_VIEW_WIDHT) + 150
        textHeight = max(POP_VIEW_HEIGHT, textHeight)
        self.baseView.frame = CGRect(x: (kSizeScreenWidth - POP_VIEW_WIDHT) / 2, y: (kSizeScreenHight - textHeight) / 2 - 50, width: POP_VIEW_WIDHT, height: textHeight)
//        baseView.backgroundColor = .white
        
        if isTextCenter {
            self.contentLabel.textAlignment = .center
        } else {
            self.contentLabel.textAlignment = .left
        }
        self.cancelBtn.setTitle(cancelButtonTitle, for: .normal)
        self.sureBtn.setTitle(sureButtonTitle, for: .normal)
    }
    
    //计算文本高度
    func calculateTextHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: NSParagraphStyle.default.mutableCopy() as! NSParagraphStyle // 可以根据需要自定义段落样式，比如行间距
        ]
        
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let size = CGSize(width: width, height: .greatestFiniteMagnitude) // 设置高度为极大值，以便自动计算
        let rect = text.boundingRect(with: size, options: option, attributes: attributes, context: nil)
        
        return rect.size.height // 返回计算得到的高度
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var baseView:UIView = {
        let view = UIView()
        view.frame = CGRect(x: (kSizeScreenWidth - POP_VIEW_WIDHT) / 2, y: (kSizeScreenHight - POP_VIEW_HEIGHT) / 2 - 50, width: POP_VIEW_WIDHT, height: POP_VIEW_HEIGHT)
        view.backgroundColor = kTBlue
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        
        let witheView = UIView()
        witheView.backgroundColor = .white
        witheView.setCorner(16)
        view.addSubview(witheView)
        witheView.snp.makeConstraints { make in
            make.left.top.equalTo(5)
            make.bottom.right.equalTo(-5)
        }
        
        return view
    }()
    
    fileprivate lazy var titleLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = kT333
        titleLabel.font = DDSFont_M(15)
        titleLabel.text = "提示"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        return titleLabel
    }()
    
    fileprivate lazy var contentLabel:UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = kT777
        titleLabel.font = DDSFont(14)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.backgroundColor = .clear
        titleLabel.adjustsFontSizeToFitWidth = true
        return titleLabel
    }()
    
    fileprivate lazy var cancelBtn:UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.backgroundColor = UIColor.clear
        cancelBtn.setTitleColor(kT777, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelBtn.addTarget(self, action: #selector(cancleBtnAction(_:)), for: .touchUpInside)
        cancelBtn.backgroundColor = kBF2
        cancelBtn.layer.cornerRadius = 17
        return cancelBtn
    }()
    
    fileprivate lazy var sureBtn:UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.backgroundColor = UIColor.clear
        sureBtn.setTitleColor(.white, for: .normal)
        sureBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        sureBtn.tag = 2
        sureBtn.frame = CGRectMake(10, 0, POP_VIEW_WIDHT / 2, 35)
        sureBtn.backgroundColor = kTBlue
        sureBtn.layer.cornerRadius = 17
        sureBtn.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        return sureBtn
    }()

    //MARK:创建
    func setupAlertView(_ cancelButtonTitle:String?) {
        //布局
        self.frame = CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: kSizeScreenHight)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        self.addSubview(baseView)
        baseView.addSubview(titleLabel)
        baseView.addSubview(contentLabel)
        baseView.addSubview(cancelBtn)
        baseView.addSubview(sureBtn)
        
        self.baseView.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.width.equalTo(POP_VIEW_WIDHT)
            make.centerY.equalTo(self)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(25)
            make.left.equalTo(25)
            make.right.equalTo(-25)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(25)
            make.right.equalTo(-25)
            make.height.greaterThanOrEqualTo(80)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.bottom.equalTo(-25)
            make.left.equalTo(25)
            make.height.equalTo(35)
            make.width.equalTo(115)
        }
        
        sureBtn.snp.makeConstraints { make in
            make.right.equalTo(-25)
            make.bottom.equalTo(-25)
            make.height.equalTo(35)
            make.width.equalTo(115)
            make.top.equalTo(contentLabel.snp.bottom).offset(10)
        }
        
        if cancelButtonTitle == nil {
            cancelBtn.isHidden = true
            sureBtn.frame = CGRectMake(0, 0, POP_VIEW_WIDHT - 100, 35)
            sureBtn.snp.updateConstraints { make in
                make.right.equalTo(-50)
                make.width.equalTo(POP_VIEW_WIDHT - 100)
            }
        }

    }
    
    //MARK:按键的对应的方法
    @objc func clickBtnAction(_ sender: UIButton) {
        if (clickClosure != nil) {
            clickClosure!()
        }
        dismiss()
    }
    
    @objc func cancleBtnAction(_ sender: UIButton) {
        if (cancelClosure != nil) {
            cancelClosure!()
        }
        dismiss()
    }
    
    @objc func closeBtnAction(_ sender: UIButton) {
        if (closeClosure != nil) {
            closeClosure!()
        }
        dismiss()
    }
}
