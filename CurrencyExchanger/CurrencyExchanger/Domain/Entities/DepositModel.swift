//
//  DepositModel.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation

struct DepositModel: Codable {
    var amount: String?
    var currency: CurrencyType?
}

// MARK: - Equatable

extension DepositModel: Equatable {
    
    static func == (lhs: DepositModel, rhs: DepositModel) -> Bool {
        lhs.currency == rhs.currency
    }
}

// MARK: - Helper functions

extension DepositModel {
    
    func concatenated() -> String {
        let amount = amount?.asDouble.shortValue ?? "0.00"
        let currency = currency?.rawValue ?? ""
        return amount + " " + currency
    }
    
    public mutating func changeAmount(toValue value: Double) {
        self.amount = String(value)
    }
}
