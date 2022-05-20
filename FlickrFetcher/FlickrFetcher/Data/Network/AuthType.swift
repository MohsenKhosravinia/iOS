//
//  AuthType.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import Foundation

enum AuthType {
    case bearer(token: String)
    case basic(token: String)
    case openAPI
    
    var header: [String: String] {
        switch self {
        case .bearer(let token):
            return ["Authorization": "Bearer \(token)"]
        case .basic(let token):
            return ["Authorization": token]
        case .openAPI:
            return [:]
        }
    }
}
