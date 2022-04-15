//
//  MyBalancesViewModel.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation

protocol MyBalancesViewModel {
    var account: AccountModel { get }
}

final class DefaultMyBalancesViewModel: MyBalancesViewModel {
    
    private let interactor: BalanceInteractor
    
    var account: AccountModel {
        interactor.getAccount()
    }
    
    init(interactor: BalanceInteractor) {
        self.interactor = interactor
    }
}
