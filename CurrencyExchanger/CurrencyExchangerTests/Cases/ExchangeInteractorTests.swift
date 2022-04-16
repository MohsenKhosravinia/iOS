//
//  ExchangeInteractorTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

@testable import CurrencyExchanger
import XCTest
import Combine

class ExchangeInteractorTests: XCTestCase {
    
    var exchangeInteractor: ExchangeInteractor!
    
    override func setUp() {
        super.setUp()
        
        let mockWebRepository = MockExchangeWebRepository()
        let mockLocalRepository = MockLocalRepository()
        exchangeInteractor = DefaultExchangeInteractor(webRepository: mockWebRepository,
                                                       localRepository: mockLocalRepository)
    }
    
    override func tearDown() {
        exchangeInteractor = nil
        
        super.tearDown()
    }

    func test_exchangeInteractorCalculateExchange_calculatesCorrectly() {
        let exchangeModel = ExchangeModel(amount: 100,
                                          source: .usd,
                                          destination: .eur)
        
        let expectation = expectation(description: "")
        exchangeInteractor.calculateExchange(exchangeModel, completion: <#T##(Result<DepositModel, ExchangeError>) -> Void#>)
    }

}

final class MockExchangeWebRepository: ExchangeWebRepository {
    var networkController: NetworkControllerProtocol = MockNetworkController()
    
    func exchange(_ model: ExchangeModel) -> AnyPublisher<DepositModel, Error> {
        let depositModel = DepositModel(amount: "90", currency: .eur)
        return Just(depositModel)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

final class MockNetworkController: NetworkControllerProtocol {
    
    func get<T>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
        return Just(T.self as! T)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
