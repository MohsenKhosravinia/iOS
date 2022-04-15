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

extension DepositModel {
    
    func concatenated() -> String {
        let amount = amount ?? "0.00"
        let currency = currency?.rawValue ?? ""
        return amount + " " + currency
    }
}
