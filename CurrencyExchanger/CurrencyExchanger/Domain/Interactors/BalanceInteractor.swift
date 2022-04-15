//
//  BalanceInteractor.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation

protocol BalanceInteractor {
    func getAccount() -> AccountModel
}

final class DefaultBalanceInteractor: BalanceInteractor {
    
    let localRepository: LocalRepository
    
    init(localRepository: LocalRepository) {
        self.localRepository = localRepository
    }
    
    func getAccount() -> AccountModel {
        // FIXME: REMOVE MOCK MODEL
//        AccountModel(savings: [.init(amount: "1000", currency: .eur),
//                               .init(amount: "2000", currency: .usd),
//                               .init(amount: "0", currency: .jpy)])
        localRepository.account
    }
}
