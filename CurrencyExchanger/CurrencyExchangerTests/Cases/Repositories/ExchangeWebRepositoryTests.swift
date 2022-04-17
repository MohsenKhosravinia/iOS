//
//  ExchangeWebRepositoryTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/17/22.
//

@testable import CurrencyExchanger
import XCTest
import Combine

class ExchangeWebRepositoryTests: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        
        super.tearDown()
    }
    
    func test_exchange_givenValidJSON_returnsDeposit() {
        var receivedDeposit: DepositModel? = nil
        let exchangeModel = ExchangeModel(amount: 100, source: .eur, destination: .usd)
        let deposit = DepositModel(amount: "32.00", currency: .eur)
        let sut = DefaultExchangeWebRepository(networkController: MockNetworkController())
        
        let expectation = expectation(description: "Wait for exchange response")
        var receivedError: Error? = nil
        var finishedNormally: Bool = false
        sut.exchange(exchangeModel)
            .sink { completion in
                switch completion {
                case .finished:
                    finishedNormally = true
                case .failure(let error):
                    receivedError = error
                }
                expectation.fulfill()
            } receiveValue: { deposit in
                receivedDeposit = deposit
            }
            .store(in: &cancellables)

        // then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedDeposit, deposit)
        XCTAssertEqual(receivedDeposit?.amount, deposit.amount)
        XCTAssertTrue(finishedNormally)
        XCTAssertNil(receivedError)
    }
}

// MARK: - Mock

private extension ExchangeWebRepositoryTests {
    
    final class MockNetworkController: NetworkControllerProtocol {
        private var isSuccessfullResponse: Bool
        
        init(isSuccessfullResponse: Bool = true) {
            self.isSuccessfullResponse = isSuccessfullResponse
        }
        
        func get<T>(type: T.Type, url: URL, headers: Headers) -> AnyPublisher<T, Error> where T : Decodable {
            let response = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil)!
            
            guard isSuccessfullResponse else {
                let response: AnyPublisher<T, Error> =
                Result<T, Error>.Publisher(.failure(APIError.parsingFailure))
                    .eraseToAnyPublisher()
                return response
            }
            
            let data = try! Data.fromJSON(fileName: "Exchange_Success_Response")

            let publisher: AnyPublisher<T, Error> = Just((data: data, response: response))
                .map(\.data)
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
            
            return publisher
        }
    }
}
