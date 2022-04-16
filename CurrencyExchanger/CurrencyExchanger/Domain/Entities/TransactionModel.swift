//
//  TransactionModel.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/17/22.
//

import Foundation

struct TransactionModel {
    var account: AccountModel
    var input: DepositModel
    var output: DepositModel
    var commission: Double
}

extension TransactionModel: CustomStringConvertible {
    
    var description: String {
        "You have converted \(input.concatenated()) to \(output.concatenated()). Commission fee -\(commission.shortValue) \(input.currency?.rawValue ?? "EUR")"
    }
}
