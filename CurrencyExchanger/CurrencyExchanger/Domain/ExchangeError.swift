//
//  ExchangeError.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/17/22.
//

import Foundation

enum ExchangeError: Error {
    case insufficientFund
    case failedExchange
}
