//
//  BurialPoint.swift
//  SXProject
//
//  Created by 王威 on 2025/3/28.
//

import UIKit

enum BurialPoint: String, Codable {
    /// 激活数,
    case ACTIVATION = "ACTIVATION"
    /// 注册页浏览,
    case REGISTER_PAGE_VIEW = "REGISTER_PAGE_VIEW"
    /// :登录,
    case LOGIN = "LOGIN"
    /// 提交订单,
    case POST_ORDER = "POST_ORDER"
    /// 填写借款信息浏览,
    case LOAN_PAGE_VIEW = "LOAN_PAGE_VIEW"
    
    /// 首次退出弹窗,
    case FIRST_QUIT = "FIRST_QUIT"
    /// 首次继续填写,
    case CONTINUE_FILL = "CONTINUE_FILL"
    /// 关闭首次弹窗,
    case CLOSE_FIRST_QUIT = "CLOSE_FIRST_QUIT"
    
    /// 二次退出弹窗,
    case SECOND_QUIT = "SECOND_QUIT"
    /// 否，继续填写,
    case NOT_CONTINUE_FILL = "NOT_CONTINUE_FILL"
    /// 是的,
    case YES_BUTTON = "YES_BUTTON"
    /// 关闭二次弹窗,
    case CLOSE_SECOND_QUIT = "CLOSE_SECOND_QUIT"
    
}
/**
 * ACTIVATION:激活数,
 * REGISTER_PAGE_VIEW:注册页浏览,
 * LOGIN:登录,
 * POST_ORDER:提交订单,
 * LOAN_PAGE_VIEW:填写借款信息浏览,
 /hht/h5/userPoint/add
 *
 * FIRST_QUIT:首次退出弹窗,
 * CONTINUE_FILL:首次继续填写,
 * CLOSE_FIRST_QUIT:关闭首次弹窗,
 * SECOND_QUIT:二次退出弹窗,
 * NOT_CONTINUE_FILL:否，继续填写,
 * YES_BUTTON:是的,
 * CLOSE_SECOND_QUIT:关闭二次弹窗,
 /hht/h5/userPoint/addTransformPoint
 */

