//
//  NetworkControllerProtocol.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation
import Combine

typealias Headers = [String: Any]

protocol NetworkControllerProtocol {
    func get<T>(type: T.Type,
                url: URL,
                headers: Headers) -> AnyPublisher<T, Error> where T: Decodable
}
