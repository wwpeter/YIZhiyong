//
//  URLDefinePath.swift
//  SXProject
//
//  Created by 王威 on 2024/4/23.
//
//解决Swift 不能调用OC 宏定义的问题

import Foundation

/*
 /yzyhome/agreement/user/   注册协议
 /yzyhome/agreement/privacy/  隐私协议
 /yzyhome/agreement/signout/  注销协议
 /yzyhome/agreement/share/  个人信息共享授权协议
 */

let kWebUrlBase = "https://yzy.yizhiyong.xin"
///注册协议 -- 这是H5 webview加载
let kUserAgreement = "/yzyhome/agreement/user/"
///隐私协议
let kPrivacyAgreement = "/yzyhome/agreement/privacy/"
///注销协议
let kSignoutAgreement = "/yzyhome/agreement/signout/"
///个人信息共享授权协议
let kAgreementShare = "/yzyhome/agreement/share/"

/// 用户登录相关接口
/// 根据手机验证码登录
let kLogin = "/hht/h5/account/login"
/// 登出
let kLogout = "/hht/h5/account/logout"
/// 注销账户
let UserOrderInfo = "/hht/h5/account/removeAccount"
/// 首页 - 首页信息查询
let kAppPageInfo = "/hht/h5/user/appPageInfo"

/// 订单相关接口
/// 填写借款信息
let kLoanInformation = "/hht/h5/user/app/loanInformation"

/// App我的页面相关接口
/// 添加银行卡信息
let kAddCard = "/hht/h5/userIndex/addCard"
/// 删除银行卡信息
let kDdeleteCard = "/hht/h5/userIndex/deleteCard"
/// 查询银行卡列表
let kQueryBankCardList = "/hht/h5/userIndex/queryBankCardList"
///申请记录（新）
let kQueryOrdersHistoryPageApp = "/hht/h5/userIndex/queryOrdersHistoryPageApp"

/// 通用接口
/// 发送验证码
let kSendValidateCode = "/hht/common/sendValidateCode"

///用户主流程相关接口
///用户信息回显
let kQueryUserOrderInfo = "/hht/h5/user/queryUserOrderInfo"

/// app版本管理相关接口
/// 根据系统查询最新app版本信息
let kQueryLastAppVersionInfo = "/hht/h5/version/queryLastAppVersionInfo"

///用户埋点相关接口
///增加埋点
let kPointAdd = "/hht/h5/userPoint/add"
/// 增加渠道用户转化埋点
let kAddTransformPoint = "/hht/h5/userPoint/addTransformPoint"
/// 订单相关接口
/// 根据身份证号查询用户黑名单记录
let kQueryBlackUserIdCard = "/hht/h5/user/queryBlackUserIdCard"
/// 实名信息认证
let kIdCardCredit = "/hht/h5/user/idCardCredit"

///字典控制器
///查询对应的模块 - 提交数据的 展示数据
let kQueryListByType = "/hht/dictionary/queryListByType"


///查询企业名称列表
let kMatchCompanyName = "/hht/mjb/queryCompanyNameList"
///查询匹配方案
let kMatchCompanyDetail = "/hht/mjb/matchInfo"
///查询产品状态
let kMatchTheProcutStatus = "/hht/mjb/productStatus"
//提交匹配
let kDoLoanProduct = "/hht/mjb/match"
//所有产品
let kAllProductsList = "/hht/mjb/queryProductList"
