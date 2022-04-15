//
//  NetworkController.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation
import Combine

// MARK: - Network Controller

final class NetworkController: NetworkControllerProtocol {
    /// Get generic API
    /// - Parameters:
    ///   - type: API data type
    ///   - url: API url address
    ///   - headers: API headers
    /// - Returns: A generic object
    func get<T: Decodable>(type: T.Type,
                           url: URL,
                           headers: Headers) -> AnyPublisher<T, Error> {
        var urlRequest = URLRequest(url: url)
        
        headers.forEach { (key, value) in
            if let value = value as? String {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .map(\.data)
            .handleEvents(receiveOutput: { data in
                self.printPretty(type: type, url: url, headers: headers, data: data)
            })
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

// MARK: - Debugging Helper

extension NetworkController {
    
    func printPretty<T>(type: T.Type, url: URL, headers: Headers, data: Data) {
        print("\n\n\n---------------------------------------------")
        print("URL: ", url.absoluteString)
        print("---------------------------------------------")
        print("HEADERS: ", headers.debugDescription)
        print("---------------------------------------------")
        print("RESULT: ")
        print(String(describing: data.prettyPrintedJSONString))
        print("---------------------------------------------\n\n\n")
    }
}
