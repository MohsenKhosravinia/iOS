//
//  MyBalancesViewModelTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/17/22.
//

import XCTest
@testable import CurrencyExchanger

class MyBalancesViewModelTests: XCTestCase {

    func test_getAccount_works() {
        let sut = DefaultMyBalancesViewModel(interactor: MockBalanceInteractor())
        
        let deposit = sut.account.savings.first
        let amount = deposit?.amount
        
        XCTAssertEqual(amount, "1000")
    }

}

private extension MyBalancesViewModelTests {
    
    final class MockBalanceInteractor: BalanceInteractor {
        func getAccount() -> AccountModel {
            .init(savings: [.init(amount: "1000", currency: .jpy)])
        }
    }
}
