//
//  FlickrModel.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import Foundation

struct FlickrModel: Codable {
    var photos: PageModel<PhotoModel>?
    var status: String?
    
    enum CodingKeys: String, CodingKey {
        case photos
        case status = "stat"
    }
}
