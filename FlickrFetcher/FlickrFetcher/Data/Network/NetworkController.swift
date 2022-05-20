//
//  NetworkController.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import Foundation
import Combine
import Alamofire

final class NetworkController: NetworkControllerProtocol {

    func get<T>(type: T.Type, route: Routable) -> AnyPublisher<T, AFError> where T: Decodable {
        guard let url = route.url else { preconditionFailure() }
        
        let anyPublisher = AF.request(url,
                                      method: .get,
                                      parameters: route.parameters,
                                      encoding: URLEncoding.queryString,
                                      headers: HTTPHeaders(route.headers))
            .publishDecodable(type: T.self)
            .value()
            .eraseToAnyPublisher()
//            .retry(2)
//            .mapError { _ in APIError.responseFailure }
//            .eraseToAnyPublisher()
        return anyPublisher
    }
    
    func post<T>(type: T.Type, route: Routable) -> AnyPublisher<T, AFError> where T: Decodable {
        guard let url = route.url else { preconditionFailure() }

        let anyPublisher = AF.request(url,
                                      method: .post,
                                      parameters: route.body,
                                      encoding: JSONEncoding.default,
                                      headers: HTTPHeaders(route.headers))
            .publishDecodable(type: T.self)
            .value()
//            .retry(2)
//            .mapError { _ in APIError.responseFailure }
//            .eraseToAnyPublisher()
        dump(route.body)
        return anyPublisher
    }
    
    func put<T>(type: T.Type, route: Routable) -> AnyPublisher<T, AFError> where T: Decodable {
        guard let url = route.url else { preconditionFailure() }

        let anyPublisher = AF.request(url,
                                      method: .put,
                                      parameters: route.body,
                                      encoding: JSONEncoding.default,
                                      headers: HTTPHeaders(route.headers))
            .publishDecodable(type: T.self)
            .value()
//            .retry(2)
//            .mapError { _ in APIError.responseFailure }
//            .eraseToAnyPublisher()
        dump(route.body)
        return anyPublisher

    }
    
    func delete<T>(type: T.Type, route: Routable) -> AnyPublisher<T, AFError> where T: Decodable {
        guard let url = route.url else { preconditionFailure() }

        let anyPublisher = AF.request(url,
                                      method: .delete,
                                      headers: HTTPHeaders(route.headers))
            .publishDecodable(type: T.self)
            .value()
//            .retry(2)
//            .mapError { _ in APIError.responseFailure }
//            .eraseToAnyPublisher()
        return anyPublisher
    }
    
}
