//
//  Person.swift
//  SXProject
//
//  Created by 王威 on 2024/4/26.
//

import UIKit

struct Person: HandyJSON {
    var name: String?
    var age: Int?
}
func test() {
    let jsonString = "{\"name\":\"John\",\"age\":25}"
    if let person = JSONDeserializer<Person>.deserializeFrom(json: jsonString) {
        print("Name: \(person.name ?? "")")
        print("Age: \(person.age ?? 0)")
    } else {
        print("JSON 解析失败")
    }
}
