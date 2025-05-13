//
//  Cache.swift
//  DigitalSleep
//
//  Created by ww on 2021/11/19.
//
//  存储单例类

import Foundation
import Cache

//private let kDiskCacheKey = "SLEEP_DISK"
//private let kCacheUserInfoKey = "DS_CACHE_USERINFO_KEY"
//private let kCacheTokenKey = "DS_CACHE_TOKEN_KEY"
//
//public class CacheManage {
//    
//    private let storage = try! Storage<String, Data>(diskConfig: DiskConfig(name: kDiskCacheKey),
//                               memoryConfig: MemoryConfig(),
//                               transformer: TransformerFactory.forData())
//    private let stringStorage: Storage<String, String>
//    private let useInfoStorage: Storage<String, UserInfo>
//
//    public static let shared = CacheManage()
//    
//    
//    private init() {
////        stringStorage = storage.transformCodable(ofType: String.self)
////        useInfoStorage = storage.transformCodable(ofType: UserInfo.self)
//    }
//
//    /// 存用户ID
//    func setUserInfo(userInfo: UserInfo) {
//        try? useInfoStorage.setObject(userInfo, forKey: kCacheUserInfoKey)
//    }
//    
//    /// 获取用户ID
//    func userInfo() -> UserInfo? {
//        try? useInfoStorage.object(forKey: kCacheUserInfoKey)
//    }
//    ///  存储用户access token
//    func setAccessToken(token: String) {
//        try? stringStorage.setObject(token, forKey: kCacheTokenKey)
//    }
//    
//    /// 获取的access token
//    func accessToken() -> String? {
//        try? stringStorage.object(forKey: kCacheTokenKey)
//    }
//    
//    /// 清除本地所有缓存
//    func removeAllStorage() {
//        try? storage.removeAll()
//    }
//    
//    // 更新用户信息
//    func updateUserInfo() {
//      
//    }
//}
