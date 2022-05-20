//
//  Routable.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import Foundation

protocol Routable {
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    var authentication: AuthType { get }
    var body: [String: Any] { get }
    var baseURL: BaseURL { get }
    var path: String { get }
    var url: URL? { get }
}

extension Routable {
    var url: URL? {
        URL(string: baseURL.rawValue + path)
    }
    
    var body: [String: Any] {
        [:]
    }
}
