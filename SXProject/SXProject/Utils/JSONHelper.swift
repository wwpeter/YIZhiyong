//
//  JsonHeap.swift
//  SXProject
//
//  Created by 王威 on 2024/4/26.
//

import UIKit

class JSONHelper {
    
    ///JSONStr -> Model
    static func parse<T: HandyJSON>(jsonString: String) -> T? {
        return JSONDeserializer<T>.deserializeFrom(json: jsonString)
    }
    
    ///model -> JSONString
    static func toJSONString<T: HandyJSON>(object: T) -> String? {
        return object.toJSONString()
    }
    
    
    /// JSON get Dictionary
    static func exchangeDic(jsonStr: String) -> Dictionary<AnyHashable, Any> {
        if let jsonString = jsonStr.data(using: .utf8) {
            do {
                if let jsonDictionary = try JSONSerialization.jsonObject(with: jsonString, options: []) as? [String: Any] {
                    // 使用转换后的字典
                    print("JSON Dictionary: \(jsonDictionary)")
                    return jsonDictionary
                } else {
                    print("JSON 解析失败")
                }
            } catch {
                print("JSON 解析错误: \(error.localizedDescription)")
            }
        } else {
            print("无效的 JSON 字符串")
        }
        return ["":""]
    }
    /**
     *  Json转对象
     */
    static  func jsonToModel(_ jsonStr:String, _ modelType:HandyJSON.Type) -> HandyJSON? {
        
        if jsonStr == "" || jsonStr.count == 0 {
#if DEBUG
            print("jsonToModel:字符串为空")
#endif
            return nil
        }
        
        return modelType.deserialize(from: jsonStr)
    }
    
    
    /**
     * Json转数组对象
     *
     @param jsonArray  array格式的 json 字符串 / JSON 数组
     */
    static func jsonArrayToModel(_ jsonArray:Any?, _ modelType:HandyJSON.Type) -> [HandyJSON?]? {
        
        if jsonArray == nil {
#if DEBUG
            print("jsonArrayToModel:jsonArray字符串为空")
#endif
            return nil
        }
        
        
        var resultJsonArray:[[String:Any?]]?
        if jsonArray is String {//array格式的 json 字符串
            
            let jsonArrayStr = jsonArray as! String
            let data = jsonArrayStr.data(using: String.Encoding.utf8)
            resultJsonArray = try! JSONSerialization.jsonObject(with:data!, options: JSONSerialization.ReadingOptions()) as? [[String:Any?]]
            
        }else if jsonArray is [[String:Any?]] {//JSON 数组
            resultJsonArray = jsonArray as? [[String:Any?]]
        }
        
        var modelArray:[HandyJSON?]? = []
        
        if let resultJsonArray = resultJsonArray {
            for itemDic:[String:Any?] in resultJsonArray {
                modelArray?.append(modelType.deserialize(from: itemDic as [String : Any]))
            }
        }
        
        return modelArray
        
    }
    
    
    /**
     *  字典转对象
     */
    static func dictionaryToModel(_ dictionStr:[String:Any],_ modelType:HandyJSON.Type) -> HandyJSON? {
        if dictionStr.count == 0 {
#if DEBUG
            print("dictionaryToModel:字符串为空")
#endif
            return nil
        }
        return modelType.deserialize(from: dictionStr)
    }
    
    
    /**
     *  对象转JSON
     */
    static func modelToJson(_ model:HandyJSON?) -> String? {
        if model == nil {
#if DEBUG
            print("modelToJson:model为空")
#endif
            return nil
        }
        return (model?.toJSONString())
    }
    
    /**
     *  对象数组 转 json数组
     */
    static func modelArrayToJsonArray(_ modelArray:[HandyJSON]?) -> [[String:Any?]]? {
        if modelArray == nil {
#if DEBUG
            print("modelArrayToJsonArray:modelArray为空")
#endif
            return nil
        }
        
        var resultJsonArray:[[String:Any]] = []
        
        if let modelArray {
            for itemDic in modelArray {
                let itemJson = itemDic.toJSON()
                if let itemJson {
                    resultJsonArray.append(itemJson)
                }
            }
        }
        return resultJsonArray
    }
    
    
    /**
     *  对象转字典
     */
    static func modelToDictionary(_ model:HandyJSON?) -> [String:Any?] {
        if model == nil {
#if DEBUG
            print("modelToDictionary:model为空")
#endif
            return [:]
        }
        return (model?.toJSON())!
    }        
       
}
