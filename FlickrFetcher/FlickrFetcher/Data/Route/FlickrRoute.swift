//
//  FlickerAPI.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import Foundation

struct FlickrRoute: Routable {
    let page: Int
    var authentication: AuthType = .openAPI
    var baseURL: BaseURL = .flicerBaseUrl
    var path: String = "services/rest/"
    
    var parameters: [String: Any]? {
        ["method": "flickr.photos.getRecent",
         "api_key": APIKey.flickr,
         "format": "json",
         "nojsoncallback": 1,
         "extras": "views",
         "page": page]
    }
    
    var headers: [String: String] {
        var headers = ["ContentType": "application/json"]
        headers.merge(authentication.header) { (current, _) in current }
        return headers
    }
    
    init(page: Int = 1) {
        self.page = page
    }
}
