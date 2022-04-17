//
//  BalanceInteractorTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

@testable import CurrencyExchanger
import XCTest

class BalanceInteractorTests: XCTestCase {
    
    var userDefaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
    }
    
    override func tearDown() {
        userDefaults = nil
        
        super.tearDown()
    }

    func test_balanceInteractorGetsAccount_receivesCorrectAccount() {
        let localRepository = MockLocalRepository(userDefaults: userDefaults)
        let sut = DefaultBalanceInteractor(localRepository: localRepository)
        
        let account = sut.getAccount()
        
        XCTAssertEqual(account.savings, localRepository.account.savings)
    }
    
    func test_balanceInteractorGetAccount_savingsArrayIsNotEmpty() {
        let localRepository = MockLocalRepository(userDefaults: userDefaults)
        let sut = DefaultBalanceInteractor(localRepository: localRepository)
        
        let account = sut.getAccount()
        
        XCTAssertFalse(account.savings.isEmpty)
    }
    
}
