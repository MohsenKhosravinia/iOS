//
//  CommissionCalculatorTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

@testable import CurrencyExchanger
import XCTest

class CommissionCalculatorTests: XCTestCase {

    var exchangeModel: ExchangeModel!
    var localRepository: LocalRepository!
    
    override func setUp() {
        super.setUp()
            
        exchangeModel = ExchangeModel(amount: 100, source: .eur, destination: .usd)
        localRepository = MockLocalRepository()
    }
    
    override func tearDown() {
        exchangeModel = nil
        localRepository = nil
        
        super.tearDown()
    }
    
    func test_commissionCalculatorHasFreeCommission_returnsZero() {
        localRepository.commissionFreeRemainingTimes = 1
        let sut = CommissionCalculator(localRepository: localRepository,
                                       exchange: exchangeModel)
        
        let commissionFee = sut.calculateCommissionFee()
        
        XCTAssertEqual(commissionFee, .zero)
    }
    
    func test_commissionCalculatorHasNotFreeCommission_returnsFee() {
        let sut = CommissionCalculator(localRepository: localRepository,
                                       exchange: exchangeModel)
        
        let commissionFee = sut.calculateCommissionFee()
        
        XCTAssertNotEqual(commissionFee, .zero)
    }
    
    func test_commissionCalculator_calculatesCorrectly() {
        let sut = CommissionCalculator(localRepository: localRepository,
                                       exchange: exchangeModel)
        let desiredCommissionFee = exchangeModel.amount * CommissionCalculator.Constants.defaultCommissionFee
        
        let commissionFee = sut.calculateCommissionFee()
        
        XCTAssertEqual(commissionFee, desiredCommissionFee)
    }
    
    func test_commissionCalculatorCustomTrueRules_applysCorrectly() {
        let sut = CommissionCalculator(localRepository: localRepository,
                                       exchange: exchangeModel,
                                       rules: [true])
        
        let commissionFee = sut.calculateCommissionFee()
        
        XCTAssertEqual(commissionFee, .zero)
    }
    
    func test_commissionCalculatorCustomFalseRules_applyCorrectly() {
        let sut = CommissionCalculator(localRepository: localRepository,
                                       exchange: exchangeModel,
                                       rules: [false])
        let desiredCommissionFee = exchangeModel.amount * CommissionCalculator.Constants.defaultCommissionFee
        
        let commissionFee = sut.calculateCommissionFee()
        
        XCTAssertEqual(commissionFee, desiredCommissionFee)
    }
}

// MARK: - MOCK

private extension CommissionCalculatorTests {
    
    class MockLocalRepository: LocalRepository {
        var userDefaults: UserDefaults { UserDefaults.standard }
        var commissionFreeRemainingTimes: Int = 0
        
        var account: AccountModel {
            get {
                let mockSavings: [DepositModel] = [.init(amount: "1000", currency: .eur),
                                                   .init(amount: "0", currency: .usd),
                                                   .init(amount: "1000", currency: .jpy)]
                return AccountModel(savings: mockSavings)
            }
            set {}
        }
    }
    
}
