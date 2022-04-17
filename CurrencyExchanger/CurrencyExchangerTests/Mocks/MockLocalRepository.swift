//
//  MockLocalRepository.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

@testable import CurrencyExchanger
import Foundation

class MockLocalRepository: LocalRepository {

    var userDefaults: UserDefaults!
    
    required init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    var commissionFreeRemainingTimes: Int = 0
    
    var account: AccountModel {
        get {
            let mockSavings: [DepositModel] = [.init(amount: "1000", currency: .eur),
                                               .init(amount: "0", currency: .usd),
                                               .init(amount: "0", currency: .jpy)]
            return AccountModel(savings: mockSavings)
        }
        set {}
    }
}
