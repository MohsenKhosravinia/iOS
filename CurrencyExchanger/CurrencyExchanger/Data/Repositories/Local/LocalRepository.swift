//
//  LocalRepository.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation

protocol LocalRepository {
    var userDefaults: UserDefaults { get }
    var account: AccountModel { get set }
}

// MARK: - LocalRepository Declaration

struct RealLocalRepository: LocalRepository {
    
    static let shared = RealLocalRepository()
    
    let userDefaults = UserDefaults.standard
    
    struct StorageKeys {
        static let account = "user.savings"
    }
}

extension RealLocalRepository {
    
    var account: AccountModel {
        get { loadAccount() }
        set { saveAccount(newValue) }
    }
    
    func saveAccount(_ account: AccountModel) {
        
    }
    
    private func loadAccount() -> AccountModel {
        if let accountString = userDefaults.string(forKey: StorageKeys.account) {
            do {
                return try JSONDecoder().decode(AccountModel.self, from: Data(accountString.utf8))
            } catch {
                return .init(savings: [])
            }
        } else {
            return .init(savings: [.init(amount: "1000.00", currency: .eur),
                                   .init(amount: "0.00", currency: .usd),
                                   .init(amount: "0.00", currency: .jpy),])
        }
    }
}
