//
//  CurrencyExchangeViewModelTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/17/22.
//

@testable import CurrencyExchanger
import XCTest
import Combine

class CurrencyExchangeViewModelTests: XCTestCase {

    private var cancellables = Set<AnyCancellable>()
    
    func test_calculateExchange_works() {
        let mockDeposit = DepositModel(amount: "20", currency: .usd)
        let mockInteractor = MockExchangeInteractor(deposit: mockDeposit)
        let sut = DefaultCurrencyExchangeViewModel(interactor: mockInteractor)
        
        let expectation = expectation(description: "Wait for calculation")
        var depositModel: DepositModel?
        sut.exchangeCalculationPublisher
            .sink { deposit in
                depositModel = deposit
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.calculateExchange(amount: 10, fromType: .eur, toType: .usd)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(depositModel)
        XCTAssertEqual(depositModel?.amount, "20")
        XCTAssertEqual(depositModel?.currency, .usd)
    }
    
    func test_calculateExchange_fails() {
        let mockInteractor = MockExchangeInteractor(isSuccessfull: false)
        let sut = DefaultCurrencyExchangeViewModel(interactor: mockInteractor)
        
        let expectation = expectation(description: "Wait for calculation")
        var errorMessage: String?
        sut.errorPublisher
            .sink { message in
                errorMessage = message
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.calculateExchange(amount: 10, fromType: .eur, toType: .usd)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(errorMessage)
    }
    
    func test_executeExchange_works() {
        let mockDeposit = DepositModel(amount: "20", currency: .usd)
        let mockInteractor = MockExchangeInteractor(deposit: mockDeposit)
        let sut = DefaultCurrencyExchangeViewModel(interactor: mockInteractor)
        
        let output = DepositModel(amount: "15", currency: .eur)
        let desiredTransaction = TransactionModel(account: AccountModel(savings: []),
                                                  input: mockDeposit,
                                                  output: output,
                                                  commission: 0)
        
        let expectation = expectation(description: "Wait for execution")
        var transactionModel: TransactionModel?
        sut.exchangeExecutionPublisher
            .sink { transaction in
                transactionModel = transaction
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.submitExchange(amount: 20, fromType: .usd, toType: .eur)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(transactionModel)
        XCTAssertEqual(transactionModel?.output, desiredTransaction.output)
        XCTAssertEqual(transactionModel?.output.amount, desiredTransaction.output.amount)
    }
    
    func test_executeExchange_fails() {
        let mockInteractor = MockExchangeInteractor(isSuccessfull: false)
        let sut = DefaultCurrencyExchangeViewModel(interactor: mockInteractor)
        
        let expectation = expectation(description: "Wait for execution")
        var errorMessage: String?
        sut.errorPublisher
            .sink { message in
                errorMessage = message
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        sut.submitExchange(amount: 20, fromType: .usd, toType: .eur)
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNotNil(errorMessage)
    }


}

private extension CurrencyExchangeViewModelTests {
    
    final class MockExchangeInteractor: ExchangeInteractor {
        var account: AccountModel = AccountModel(savings: [])
        var deposit: DepositModel!
        var isSuccessfull: Bool!
        
        private var mockTransaction: TransactionModel {
            TransactionModel(account: account,
                             input: deposit,
                             output: DepositModel(amount: "15", currency: .eur),
                             commission: 0)
        }
        
        init(deposit: DepositModel = .init(), isSuccessfull: Bool = true) {
            self.deposit = deposit
            self.isSuccessfull = isSuccessfull
        }
        
        func calculateExchange(_ input: ExchangeModel, completion: @escaping (Result<DepositModel, ExchangeError>) -> Void) {
            if isSuccessfull {
                completion(.success(deposit))
            } else {
                completion(.failure(ExchangeError.failedExchange))
            }
        }
        
        func executeExchange(_ input: ExchangeModel, completion: @escaping (Result<TransactionModel, ExchangeError>) -> Void) {
            if isSuccessfull {
                completion(.success(mockTransaction))
            } else {
                completion(.failure(.failedExchange))
            }
        }
    }
}
