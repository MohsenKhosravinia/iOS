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
    
    var mockLocalRepository: LocalRepository!

    override func setUp() {
        super.setUp()
        
        mockLocalRepository = MockLocalRepository()
    }
    
    override func tearDown() {
        mockLocalRepository = nil
        
        super.tearDown()
    }
    
    func test_exchangeInteractorCalculateExchange_calculatesCorrectly() {
        let exchangeModel = ExchangeModel(amount: 100,
                                          source: .usd,
                                          destination: .eur)
        let sut = makeExchangeInteractor(with: MockSuccessExchangeWebRepository())
        
        let expectation = expectation(description: "")
        var depositModel: DepositModel!
        sut.calculateExchange(exchangeModel) { result in
            switch result {
            case .success(let deposit):
                depositModel = deposit
            case .failure:
                break
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(depositModel.amount, "90")
    }

    
    func test_exchangeInteractorCalculateExchange_failsProperly() {
        let exchangeModel = ExchangeModel(amount: 100,
                                          source: .usd,
                                          destination: .eur)
        let sut = makeExchangeInteractor(with: MockFailureExchangeWebRepository())
        
        let expectation = expectation(description: "")
        var desiredError: ExchangeError!
        sut.calculateExchange(exchangeModel) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                desiredError = error
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(desiredError, ExchangeError.failedExchange)
    }

    // MARK: Factory
    
    private func makeExchangeInteractor(with webRepository: ExchangeWebRepository) -> ExchangeInteractor {
        DefaultExchangeInteractor(webRepository: webRepository, localRepository: mockLocalRepository)
    }

}

// MARK: - Mocks

private extension ExchangeInteractorTests {
    
    final class MockSuccessExchangeWebRepository: ExchangeWebRepository {
        var networkController: NetworkControllerProtocol = MockNetworkController()
        func exchange(_ model: ExchangeModel) -> AnyPublisher<DepositModel, Error> {
            let depositModel = DepositModel(amount: "90", currency: .eur)
            return Just(depositModel)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
    
    final class MockFailureExchangeWebRepository: ExchangeWebRepository {
        var networkController: NetworkControllerProtocol = MockNetworkController()
        func exchange(_ model: ExchangeModel) -> AnyPublisher<DepositModel, Error> {
            return Fail(error: ExchangeError.failedExchange)
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
}

