//
//  NetworkControllerProtocol.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import Foundation
import Alamofire
import Combine

protocol NetworkControllerProtocol {
    func get<T>(type: T.Type, route: Routable) -> AnyPublisher<T, AFError> where T: Decodable
    func post<T>(type: T.Type, route: Routable) -> AnyPublisher<T, AFError> where T: Decodable
    func put<T>(type: T.Type, route: Routable) -> AnyPublisher<T, AFError> where T: Decodable
    func delete<T>(type: T.Type, route: Routable) -> AnyPublisher<T, AFError> where T: Decodable
}
