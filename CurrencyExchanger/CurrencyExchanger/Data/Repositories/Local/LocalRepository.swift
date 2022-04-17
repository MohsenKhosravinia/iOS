//
//  LocalRepository.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation

protocol LocalRepository {
    var account: AccountModel { get set }
    var commissionFreeRemainingTimes: Int { get set }
    
    init(userDefaults: UserDefaults)
}

// MARK: - LocalRepository Declaration

struct RealLocalRepository: LocalRepository {
    
    let userDefaults: UserDefaults!
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    enum StorageKeys {
        static let account = "user.savings"
        static let remainingFreecommissions = "user.remaining.free.commissions"
    }
    
    fileprivate func encode<T: Encodable>(_ object: T, forKey: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(object) {
            userDefaults.set(encoded, forKey: forKey)
        }
    }
    
    fileprivate func decode<T: Decodable>(_ object: T.Type, forKey: String) -> T? {
        if let data = userDefaults.object(forKey: forKey) as? Data {
            let decoder = JSONDecoder()
            if let savedObject = try? decoder.decode(T.self, from: data) {
                return savedObject
            }
        }
        return nil
    }
}

// MARK: - Account

extension RealLocalRepository {
    
    var account: AccountModel {
        get { loadAccount() }
        set { saveAccount(newValue) }
    }
    
    func saveAccount(_ account: AccountModel) {
        encode(account, forKey: StorageKeys.account)
    }
    
    private func loadAccount() -> AccountModel {
        if let savedAccount = decode(AccountModel.self, forKey: StorageKeys.account) {
            return savedAccount
        } else {
            let account: AccountModel = .init(savings: [.init(amount: "1000.00", currency: .eur),
                                                        .init(amount: "0.00", currency: .usd),
                                                        .init(amount: "0.00", currency: .jpy)])
            saveAccount(account)
            return account
        }
    }
}

// MARK: - Commission

extension RealLocalRepository {
    
    private var defaultFreeCommissionExchangeTimes: Int { 5 }
    
    var commissionFreeRemainingTimes: Int {
        get { loadRemainingFreeCommissionTimes() }
        set { saveRemainingFreeCommission(times: newValue) }
    }
    
    func saveRemainingFreeCommission(times: Int) {
        userDefaults.set(String(times), forKey: StorageKeys.remainingFreecommissions)
    }
    
    private func loadRemainingFreeCommissionTimes() -> Int {
        guard let remainingTimes = userDefaults
                .string(forKey: StorageKeys.remainingFreecommissions) else {
            return defaultFreeCommissionExchangeTimes
        }
        return Int(remainingTimes) ?? defaultFreeCommissionExchangeTimes
    }
}
