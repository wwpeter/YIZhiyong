//
//  Meta.swift
//  Sleep
//
//  Created by slan-ww on 2022/10/14.
//

import Foundation

struct PageModel<T: Codable>: Codable {
    var endRow = ""
    var hasNextPage = true
    var hasPreviousPage = true
    var isFirstPage = true
    var isLastPage = true
    var list: [T]
    var navigateFirstPage = 0
    var navigateLastPage = 0
    var navigatePages = 0
    var navigatepageNums: [Int] = []
    var nextPage = 0
    var pageNum = 0
    var pageSize = 0
    var pages = 0
    var prePage = 0
    var size = 0
    var startRow = ""
    var total = ""
}
