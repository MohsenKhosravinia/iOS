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
    
    // swiftlint:disable line_length
    var description: String {
        let currencyType = input.currency?.rawValue ?? "EUR"
        let commissionString = commission.shortValue == "0"
        ? "is free"
        : ("-\(commission.shortValue) \(currencyType)")
        return "You have converted \(input.concatenated()) to \(output.concatenated()). Commission fee \(commissionString)"
    }
}
