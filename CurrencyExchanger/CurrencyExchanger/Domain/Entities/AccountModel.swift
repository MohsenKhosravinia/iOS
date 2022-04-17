//
//  AccountModel.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation

struct AccountModel: Codable {
    var savings: [DepositModel]
    
    subscript(_ element: CurrencyType) -> DepositModel? {
        savings.first(where: { $0.currency == element })
    }
}

extension AccountModel: Equatable {
    
    static func == (lhs: AccountModel, rhs: AccountModel) -> Bool {
        lhs.savings == rhs.savings
    }
}
