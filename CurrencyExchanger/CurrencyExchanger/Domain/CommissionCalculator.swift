//
//  CommissionCalculator.swift
//  
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation

// MARK: - CommissionCalculator Implementation

public class CommissionCalculator {

    enum Constants {
        static let defaultCommissionFee: Double = 0.0007
    }

    // MARK: Properties

    private let exchange: ExchangeModel
    private let customRules: [Bool]
    private var localRepository: LocalRepository
    
    // MARK: - Initializer
    
    init(localRepository: LocalRepository, exchange: ExchangeModel, rules: [Bool] = []) {
        self.localRepository = localRepository
        self.exchange = exchange
        self.customRules = rules
    }
    
    // MARK: - Methods
    
    public func calculateCommissionFee() -> Double {
        if localRepository.commissionFreeRemainingTimes > 0 {
            localRepository.commissionFreeRemainingTimes -= 1
            return .zero
        }
        
        for rule in customRules where rule { return .zero }
        
        let commission = exchange.amount * Constants.defaultCommissionFee
        return commission
    }
}
