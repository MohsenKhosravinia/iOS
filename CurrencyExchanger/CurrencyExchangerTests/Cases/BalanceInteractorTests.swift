//
//  BalanceInteractorTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

@testable import CurrencyExchanger
import XCTest

class BalanceInteractorTests: XCTestCase {

    func test_balanceInteractorGetsAccount_receivesCorrectAccount() {
        let localRepository = MockLocalRepository()
        let sut = DefaultBalanceInteractor(localRepository: localRepository)
        
        let account = sut.getAccount()
        
        XCTAssertEqual(account.savings, localRepository.account.savings)
    }
    
    func test_balanceInteractorGetAccount_savingsArrayIsNotEmpty() {
        let localRepository = MockLocalRepository()
        let sut = DefaultBalanceInteractor(localRepository: localRepository)
        
        let account = sut.getAccount()
        
        XCTAssertFalse(account.savings.isEmpty)
    }
}
