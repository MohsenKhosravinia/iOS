//
//  EndPoint.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation

struct EndPoint {
    var path: String
    var queryItems: [String: Any] = [:]
}

extension EndPoint {
    /// setting up url with queries if there is any
    ///
    var url: URL {
        var components = URLComponents()
        components.scheme = URLConfiguration.shared.scheme
        components.host = URLConfiguration.shared.host
        components.path = path
        
        var queryParameterItems: [URLQueryItem] = []
        
        queryItems.forEach { (item: (key: AnyHashable, value: Any)) in
            if item.value is [UInt64] {
                (item.value as! [UInt64]).forEach({ (int) in
                    queryParameterItems.append(URLQueryItem(name: "\(item.key)" + "[]", value: "\(int)"))
                })
            } else {
                queryParameterItems.append(URLQueryItem(name: "\(item.key)", value: "\(item.value)"))
            }
        }
        
        components.queryItems?.forEach({ (item) in
            queryParameterItems.append(item)
        })
        
        if queryParameterItems != [] {
            components.queryItems = queryParameterItems
        }
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
    
    /// base headers (tokenless)
    /// returns [String: Any] dictionary aka typealiase headers
    var baseHeaders: Headers {
        ["Accept": "application/json",
         "Content-Type": "application/json"]
    }
}
