//
//  PageModel.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import Foundation

struct PageModel<T: Codable>: Codable {
    var items: [T]?
    var page: Int?
    var pages: Int?
    var perPage: Int?
    var total: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perPage = "perpage"
        case total
        case items = "photo"
    }
}
