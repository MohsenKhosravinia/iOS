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
    
    var userDefaults: UserDefaults!
    var exchangeInteractor: ExchangeInteractor!
    var mockLocalRepository: LocalRepository!
    var mockDepositModel: DepositModel!

    override func setUp() {
        super.setUp()
        
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        mockLocalRepository = MockLocalRepository(userDefaults: userDefaults)
        
        mockDepositModel = DepositModel()
    }
    
    override func tearDown() {
        userDefaults = nil
        mockLocalRepository = nil
        mockDepositModel = nil
        
        super.tearDown()
    }
    
    func test_calculateExchange_calculatesCorrectly() {
        let exchangeModel = ExchangeModel(amount: 100,
                                          source: .usd,
                                          destination: .eur)
        let mockDeposit = DepositModel(amount: "90", currency: .usd)
        let mockWebRepository = MockSuccessExchangeWebRepository(deposit: mockDeposit)
        let sut = makeExchangeInteractor(with: mockWebRepository)
        
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

    
    func test_calculateExchange_fails() {
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
    
    func test_executeExchange_changesOnBalance() {
        let exchangeModel = ExchangeModel(amount: 100,
                                          source: .eur,
                                          destination: .usd)
        let depositAccount = DepositModel(amount: "100", currency: .usd)
        let sut = makeExchangeInteractor(with: MockSuccessExchangeWebRepository(deposit: depositAccount))
        
        let calculator = CommissionCalculator(localRepository: mockLocalRepository, exchange: exchangeModel)
        let commissionFee = calculator.calculateCommissionFee()
        let desiredEuroAmount = String(Double(900) - commissionFee)
        let input = DepositModel(amount: desiredEuroAmount, currency: .eur)
        var depositAfterDeduction: DepositModel?
        let output = DepositModel(amount: "100", currency: .usd)
        var desiredOutput: DepositModel?
        
        let expectation = expectation(description: "")
        var occuredError: ExchangeError?
        sut.executeExchange(exchangeModel) { result in
            switch result {
            case .success(let transaction):
                depositAfterDeduction = transaction.account[.eur]
                desiredOutput = transaction.output
            case .failure(let error):
                occuredError = error
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(occuredError)
        XCTAssertEqual(depositAfterDeduction?.amount?.asDouble.shortValue, input.amount?.asDouble.shortValue)
        XCTAssertEqual(desiredOutput?.amount?.asDouble.shortValue, output.amount?.asDouble.shortValue)
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
        var mockDeposit = DepositModel()
        
        convenience init(deposit: DepositModel) {
            self.init()
            self.mockDeposit = deposit
        }
        
        func exchange(_ model: ExchangeModel) -> AnyPublisher<DepositModel, Error> {
            return Just(mockDeposit)
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

