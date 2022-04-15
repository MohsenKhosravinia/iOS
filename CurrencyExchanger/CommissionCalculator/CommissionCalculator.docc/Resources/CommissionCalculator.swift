//
//  CommissionCalculator.swift
//  
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation

enum Constants {
    static let defaultCommissionFee: Double = 0.0007
}

enum ExchangeError: Error {
    case insufficientFund
}

private var freeCommissionExchangeTimes: Int { 5 }

public protocol CommissionCalculatable {
    var freeCommissionExchangeTimes: Int { get }
    var customRules: [Bool] { get set }
    
    func calculateCommissionFee(forExchanging amount: Double,
                                ofCurrency inputType: CurrencyType,
                                toCurrecy outputType: CurrencyType) throws -> Double
}

// MARK: - CommissionCalculator Implementation

public class CommissionCalculator: CommissionCalculatable {

    // MARK: Properties
    
    private var freeCommissionExchangeTimes = 5
    private var account: AccountModel
    public var customRules: [Bool]
    
    // MARK: - Initializer
    
    public init(account: AccountModel, rules: [Bool] = []) {
        self.account = account
        self.customRules = rules
    }
    
    // MARK: - Methods
    
    public func calculateCommissionFee(forExchanging amount: Double,
                                ofCurrency inputType: CurrencyType,
                                toCurrecy outputType: CurrencyType) throws -> Double {
        if freeCommissionExchangeTimes > 0 {
            freeCommissionExchangeTimes -= 1
            return .zero
        }
        
        customRules.forEach { rule in
            if rule == true {
                return .zero
            }
        }
        
        let commission = amount * Constants.defaultCommissionFee
        let savedAmountOfCurrency = account.savings.first(where: { $0.currency == inputType }).amount
        
        if savedAmountOfCurrency - amount < commission {
            throw ExchangeError.insufficientFund
        }
        
        return commission
    }
}
