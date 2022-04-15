//
//  URLConfiguration.swift
//  vaiyo
//
//  Created by Ibrahim Hosseini on 11/28/21.
//

import Foundation

class URLConfiguration {
    static let shared = URLConfiguration()
        
    var scheme : String
    var host: String
    
    private init() {
        if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            for (_, value) in dict {
                if let value = value as? [String: Any] {
                    scheme  = value["scheme"] as? String ?? ""
                    host  = value["host"]  as? String ?? ""
                    return
                }
            }
        }

        fatalError("Error: Configuration file doesn't exist in project directory, please include it to be able to use this class")
    }
}

