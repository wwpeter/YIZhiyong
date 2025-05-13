//
//  UIFountExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/3.
//

import UIKit

public extension Box where Base: UIFont {
    
    ///  extraSmall 字号
    static var extraSmall: UIFont {
        Base.systemFont(ofSize: 10)
    }
    //粗体
//    func zl_blod() -> UIFont {
//        return UIFont.boldSystemFont(ofSize: self.pointSize)
//    }
    
    /**
     * 字体t35     35pt
     *
     * @实际值： 35pt
     * @使用场景:用作阿拉伯数字如门锁临时密钥的展现等
     */
    static var font_t35: UIFont {
        Base.systemFont(ofSize: 35)
    }
    /**
     * 字体t35加粗     35pt
     *
     * @实际值： 35pt
     * @使用场景:用于单行列表内 右边操作说明的信息文字
     */
    static var font_t35Blod: UIFont {
        Base.boldSystemFont(ofSize: 35)
    }
    
    /**
     * 字体t35     30pt
     *
     * @实际值：   30pt
     * @使用场景:用作阿拉伯数字如门锁临时密钥的展现等
     */
    static var font_t30: UIFont {
        Base.systemFont(ofSize: 30)
    }
    /**
     * 字体t30加粗       30pt
     *
     * @实际值： 30pt
     * @使用场景:用于单行列表内 右边操作说明的信息文字
     */
    static var font_t30Blod: UIFont {
        Base.boldSystemFont(ofSize: 30)
    }
    
    /**
     * 字体t20     20pt
     *
     * @实际值： 20pt
     * @使用场景:--
     */
    static var font_t20: UIFont {
        Base.systemFont(ofSize: 20)
    }
    
    /**
     * 字体t20加粗     20pt
     *
     * @实际值： 20pt
     * @使用场景
     */
    static var font_t20Blod: UIFont {
        Base.boldSystemFont(ofSize: 20)
    }
    
    /**
     * 字体t24     24pt
     *
     * @实际值： 24pt
     * @使用场景:--
     */
    static var font_t24: UIFont {
        Base.systemFont(ofSize: 24)
    }
    
    /**
     * 字体t24加粗     24pt
     *
     * @实际值： 24pt
     * @使用场景
     */
    static var font_t24Blod: UIFont {
        Base.boldSystemFont(ofSize: 24)
    }
    
    /**
     * 字体t17     17pt
     *
     * @实际值： 17pt
     * @使用场景:--
     */
    static var font_t17: UIFont {
        Base.systemFont(ofSize: 17)
    }
    /**
     * 字体t17加粗     17pt
     *
     * @实际值： 17pt
     * @使用场景
     */
    static var font_t17Blod: UIFont {
        Base.boldSystemFont(ofSize: 17)
    }
    
    /**
     * 字体t18    18pt
     *
     * @实际值： 18pt
     * @使用场景:--
     */
    static var font_t18: UIFont {
        Base.systemFont(ofSize: 18)
    }
    /**
     * 字体t18加粗     18pt
     *
     * @实际值： 18pt
     * @使用场景
     */
    static var font_t18Blod: UIFont {
        Base.boldSystemFont(ofSize: 18)
    }
    
    /**
     * 字体t16     16pt
     *
     * @实际值： 16pt
     * @使用场景:--
     */
    static var font_t16: UIFont {
        Base.systemFont(ofSize: 16)
    }
    /**
     * 字体t16加粗     16pt
     *
     * @实际值： 16pt
     * @使用场景
     */
    static var font_t16Blod: UIFont {
        Base.boldSystemFont(ofSize: 16)
    }
    
    /**
     * 字体t15     15pt
     *
     * @实际值： 15pt
     * @使用场景:--
     */
    static var font_t15: UIFont {
        Base.systemFont(ofSize: 15)
    }
    /**
     * 字体t15加粗     15pt
     *
     * @实际值： 15pt
     * @使用场景
     */
    static var font_t15Blod: UIFont {
        Base.boldSystemFont(ofSize: 15)
    }
    
    /**
     * 字体t14     14pt
     *
     * @实际值： 14pt
     * @使用场景:--
     */
    static var font_t14: UIFont {
        Base.systemFont(ofSize: 14)
    }
    /**
     * 字体t14加粗     14pt
     *
     * @实际值： 15pt
     * @使用场景
     */
    static var font_t14Blod: UIFont {
        Base.boldSystemFont(ofSize: 14)
    }
    
    /**
     * 字体t13     13pt
     *
     * @实际值： 13pt
     * @使用场景:--
     */
    static var font_t13: UIFont {
        Base.systemFont(ofSize: 13)
    }
    /**
     * 字体t13加粗     13pt
     *
     * @实际值： 13pt
     * @使用场景
     */
    static var font_t13Blod: UIFont {
        Base.boldSystemFont(ofSize: 13)
    }
    
    /**
     * 字体t12     12pt
     *
     * @实际值： 20pt
     * @使用场景:--
     */
    static var font_t12: UIFont {
        Base.systemFont(ofSize: 12)
    }
    /**
     * 字体t12加粗     12pt
     *
     * @实际值： 12pt
     * @使用场景
     */
    static var font_t12Blod: UIFont {
        Base.boldSystemFont(ofSize: 12)
    }
    
    /**
     * 字体t11     11pt
     *
     * @实际值： 11pt
     * @使用场景:--
     */
    static var font_t11: UIFont {
        Base.systemFont(ofSize: 11)
    }
    /**
     * 字体t11加粗     11pt
     *
     * @实际值： 11pt
     * @使用场景
     */
    static var font_t11Blod: UIFont {
        Base.boldSystemFont(ofSize: 11)
    }
    
    /**
     * 字体t9     9pt
     *
     * @实际值： 9pt
     * @使用场景:--
     */
    static var font_t9: UIFont {
        Base.systemFont(ofSize: 9)
    }
    /**
     * 字体t9加粗     9pt
     *
     * @实际值： 9pt
     * @使用场景
     */
    static var font_t9Blod: UIFont {
        Base.boldSystemFont(ofSize: 9)
    }
    
    /// 设置字体大小
    static func Font(_ size:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    /// 设置粗体字字号
    static func BoldFont(_ size:CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
}
