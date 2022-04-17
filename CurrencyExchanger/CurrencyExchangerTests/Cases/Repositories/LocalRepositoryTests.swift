//
//  LocalRepositoryTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/18/22.
//

@testable import CurrencyExchanger
import XCTest

class LocalRepositoryTests: XCTestCase {
    
    var userDefaults: UserDefaults!
    var sut: RealLocalRepository!
    
    override func setUp() {
        super.setUp()
        
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        
        sut = RealLocalRepository(userDefaults: userDefaults)
    }
    
    override func tearDown() {
        userDefaults = nil
        sut = nil
        
        super.tearDown()
    }

    func test_accountInitialValues_haveSetCorrect() {
        let account = sut.account
        
        XCTAssertEqual(account.savings.count, 3)
        XCTAssertEqual(account[.eur]?.amount, "1000.00")
        XCTAssertEqual(account[.usd]?.amount, "0.00")
        XCTAssertEqual(account[.jpy]?.amount, "0.00")
    }
    
    func test_accountSavingAndLoading_worksFine() {
        sut.account = AccountModel(savings: [.init(amount: "100", currency: .eur)])
        
        XCTAssertEqual(sut.account.savings.count, 1)
        XCTAssertEqual(sut.account.savings.first?.amount, "100")
        XCTAssertEqual(sut.account.savings.first?.currency, .eur)
    }
    
    func test_commissionFreeTimesInitialValue_hasSetCorrect() {
        XCTAssertEqual(sut.commissionFreeRemainingTimes, 5)
    }
    
    func test_commissionFreeSavingAndLoading_worksFine() {
        sut.commissionFreeRemainingTimes -= 1
        
        XCTAssertEqual(sut.commissionFreeRemainingTimes, 4)
    }

}
