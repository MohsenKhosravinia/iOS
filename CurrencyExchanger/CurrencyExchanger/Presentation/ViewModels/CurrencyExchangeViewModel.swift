//
//  CurrencyExchangeViewModel.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

import Foundation
import Combine

protocol CurrencyExchangeViewModel {
    var exchangeCalculationPublisher: PassthroughSubject<DepositModel, Never> { get }
    var exchangeExecutionPublisher: PassthroughSubject<TransactionModel, Never> { get }
    var errorPublisher: PassthroughSubject<String, Never> { get }
    
    func calculateExchange(amount: Double, fromType: CurrencyType, toType: CurrencyType)
    func submitExchange(amount: Double, fromType: CurrencyType, toType: CurrencyType)
}

final class DefaultCurrencyExchangeViewModel: CurrencyExchangeViewModel {
    
    private let interactor: ExchangeInteractor!
    public var exchangeCalculationPublisher = PassthroughSubject<DepositModel, Never>()
    public var exchangeExecutionPublisher = PassthroughSubject<TransactionModel, Never>()
    public var errorPublisher = PassthroughSubject<String, Never>()
    private var cancellables = Set<AnyCancellable>()
        
    init(interactor: ExchangeInteractor) {
        self.interactor = interactor
    }
    
    func calculateExchange(amount: Double, fromType: CurrencyType, toType: CurrencyType) {
        let model = ExchangeModel(amount: amount,
                                  source: fromType,
                                  destination: toType)
        interactor.calculateExchange(model) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let deposit):
                self.exchangeCalculationPublisher.send(deposit)
            case .failure:
                self.errorPublisher.send("Couldn't convert the inputs")
            }
        }
    }
    
    func submitExchange(amount: Double, fromType: CurrencyType, toType: CurrencyType) {
        let model = ExchangeModel(amount: amount,
                                  source: fromType,
                                  destination: toType)
        interactor.executeExchange(model) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let transaction):
                self.exchangeExecutionPublisher.send(transaction)
            case .failure(let error):
                var errorMessage = ""
                
                switch error {
                case .insufficientFund:
                    errorMessage = "Your current saving is not enough."
                case .failedExchange:
                    errorMessage = "Something went wrong. Try again later."
                }
                
                self.errorPublisher.send(errorMessage)
            }
        }
    }
}
