//
//  RPSheetMorePop.swift
//  FFMallChat
//
//  Created by Felix on 2024/10/28.
//

import UIKit
import SnapKit


public class RPSheetMorePop: UIView {
    fileprivate var dataSoure = [String]()
    
    public var finishBlock:((_ aIndex:Int) -> Void)?
    
    @objc init(dataArray:[String]) {
        super.init(frame: CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: kSizeScreenHight))
        dataSoure = dataArray
        rp_setupAlertsView()
    }
    
    fileprivate lazy var baseView:UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: kSizeScreenHight, width: kSizeScreenWidth , height: 500)
        view.backgroundColor = .white
        view.setCorner(16)
        return view
    }()
    
    ///取消按钮
    fileprivate lazy var cancelBtn:UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.frame = CGRect(x:0,y:154,width:kSizeScreenWidth,height:50)
        button.setTitleColor(kT333, for: .normal)
        button.titleLabel?.font = DDSFont(15)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        button.setTitle("取消", for: .normal)
        return button
    }()
    
    fileprivate lazy var stackView:UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    //MARK:创建
    func rp_setupAlertsView() {
        //布局
        self.frame = CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: kSizeScreenHight)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        self.addGestureRecognizer(tapGesture)
        
        self.addSubview(baseView)
        baseView.addSubview(stackView)
        baseView.addSubview(cancelBtn)
        
        rp_configTIaoJianViews()
        var y_coord:CGFloat = 49.0 * CGFloat(dataSoure.count)
        
        stackView.frame = CGRectMake(0, 0,kSizeScreenWidth,y_coord)
        
        cancelBtn.frame = CGRect(x: 0, y: y_coord + 10,width: kSizeScreenWidth, height: 50)
        y_coord += 60
        y_coord += kStatusBarHeight
        baseView.frame = CGRect(x: 0,y: kSizeScreenHight,width: kSizeScreenWidth, height: y_coord)
    }
    
    //MARK:消失
    @objc public func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.baseView.y = kSizeScreenHight
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        })
    }
    /** 指定视图实现方法 */
    @objc
    public func show() {
        let window = UIWindow.getKeyWindow()
        self.alpha = 0
        window?.addSubview(self)
        UIView.animate(withDuration: 0.35, animations: { () -> Void in
            self.alpha = 1
            self.baseView.y = kSizeScreenHight - self.baseView.height
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //解锁条件
    fileprivate func rp_configTIaoJianViews() {
        for i in  0..<self.dataSoure.count {
            let tempView = rp_getAdditonChildView(i)
            stackView.addArrangedSubview(tempView)
            tempView.snp.makeConstraints { make in
                make.height.equalTo(48)
            }
        }
    }
    
    fileprivate func rp_getAdditonChildView(_ aIndex:Int) -> UIView {
        let text = dataSoure[aIndex]
        let tempView = UIView(frame: CGRectMake(0, 0,kSizeScreenWidth, 48))
        
        let label = UILabel()
        label.font = DDSFont(14)
        label.text = text
        label.textColor = kT333
        label.numberOfLines = 0
        label.textAlignment = .center
        tempView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(0)
        }
        
        let line = UILabel()
        line.backgroundColor = kBF8
        tempView.addSubview(line)
        
       
        
        line.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(1)
        }
        let button = UIButton()
        button.backgroundColor = .clear
        button.tag = aIndex
        button.addTarget(self, action:#selector(finisndAciton(button:)), for: .touchUpInside)
        tempView.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(0)
        }
        return tempView
    }
    
    @objc func  finisndAciton(button:UIButton) {
        self.finishBlock!(button.tag)
        self.dismiss()
    }
}
