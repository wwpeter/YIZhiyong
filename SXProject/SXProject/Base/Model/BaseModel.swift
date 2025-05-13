//
//  BaseModel.swift
//  Sleep
//
//  Created by slan-ww on 2022/10/14.
//

import Foundation

struct BaseModel<T: HandyJSON>: HandyJSON {
    init() {
        
    }
    
    
    /// 200 为请求成功
    var code: Int = 200
    
    /// 错误信息
    /// 发生了错误不一定有
    var msg: String = ""
    
    /// data
    var data: T?
    
    ///请求流水
    var serialNo: String = ""
}

extension BaseModel {
//    static func normal() -> Self {
//        BaseModel(code: -1, msg: "", serialNo: "")
//    }
}
/**
 // 假设这是服务端返回的统一定义的response格式
 class BaseResponse<T: HandyJSON>: HandyJSON {
     var code: Int? // 服务端返回码
     var data: T? // 具体的data的格式和业务相关，故用泛型定义

     public required init() {}
 }

 // 假设这是某一个业务具体的数据格式定义
 struct SampleData: HandyJSON {
     var id: Int?
 }
 
 // 如果有特殊字段名或需要映射的字段，可以使用 mapping(mapper:) 方法进行映射
   mutating func mapping(mapper: HelpingMapper) {
       // 对于特殊字段名，进行字段映射
       mapper.specify(property: &name, name: "person_name")
   }

 let sample = SampleData(id: 2)
 let resp = BaseResponse<SampleData>()
 resp.code = 200
 resp.data = sample

 let jsonString = resp.toJSONString()! // 从对象实例转换到JSON字符串
 print(jsonString) // print: {"code":200,"data":{"id":2}}

 if let mappedObject = JSONDeserializer<BaseResponse<SampleData>>.deserializeFrom(json: jsonString) { // 从字符串转换为对象实例
     print(mappedObject.data?.id)
 }
 */
