//
//  PhotoModel.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import Foundation

struct PhotoModel: Codable {
    var id: String?
    var owner: String?
    var secret: String?
    var server: String?
    var farm: Int?
    var title: String?
    var isPublic: Int?
    var isFriend: Int?
    var isFamily: Int?
    
    var imageUrlString: String {
//    https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        guard let farm = farm,
              let server = server,
              let id = id,
              let secret = secret else { return "" }
        return "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case owner
        case secret
        case server
        case farm
        case title
        case isPublic = "ispublic"
        case isFriend = "isfriend"
        case isFamily = "isfamily"
    }
}
