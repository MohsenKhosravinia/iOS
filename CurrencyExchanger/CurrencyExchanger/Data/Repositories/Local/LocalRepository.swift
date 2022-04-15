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

struct RealLocalRepository: LocalRepository {
    public let userDefaults = UserDefaults.standard
    
    struct StorageKeys {
        static let account = "user.savings"
    }
}
