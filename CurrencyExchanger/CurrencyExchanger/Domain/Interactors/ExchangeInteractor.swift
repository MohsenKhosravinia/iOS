//
//  ExchangeInteractor.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

import Foundation
import Combine

protocol ExchangeInteractor {
    var account: AccountModel { get }
    
    func calculateExchange(_ input: ExchangeModel,
                           completion: @escaping (Result<DepositModel, ExchangeError>) -> Void)
    func executeExchange(_ input: ExchangeModel,
                         completion: @escaping (Result<AccountModel, ExchangeError>) -> Void)
}

final class DefaultExchangeInteractor: ExchangeInteractor {
    
    private let webRepository: ExchangeWebRepository
    private var localRepository: LocalRepository
    private var cancellables = Set<AnyCancellable>()
    var account: AccountModel {
        get { localRepository.account }
        set { localRepository.account = newValue }
    }
    
    init(webRepository: ExchangeWebRepository, localRepository: LocalRepository) {
        self.webRepository = webRepository
        self.localRepository = localRepository
    }
    
    func calculateExchange(_ input: ExchangeModel,
                           completion: @escaping (Result<DepositModel, ExchangeError>) -> Void) {
        callExchangeAPI(input, completion: completion)
    }
    
    func executeExchange(_ input: ExchangeModel,
                         completion: @escaping (Result<AccountModel, ExchangeError>) -> Void) {
        let commissionFee = getCommission(for: input)
        
        let savedAmount = account[input.source]?.amount?.asDouble ?? 0
        
        if (input.amount - commissionFee) < savedAmount {
            completion(.failure(ExchangeError.insufficientFund))
            return
        }
        
        callExchangeAPI(input) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let receivedDeposit):
                var accounts = self.account
                
                guard var soldDeposit = accounts[input.source],
                      let soldDepositAmount = soldDeposit.amount?.asDouble else { return }
                
                let newAmountValue = soldDepositAmount - (input.amount + commissionFee)
                soldDeposit.changeAmount(toValue: newAmountValue)
                
                if let index: Int = accounts.savings.firstIndex(of: soldDeposit) {
                    accounts.savings[index] = soldDeposit
                }
                
                if let index: Int = accounts.savings.firstIndex(of: receivedDeposit) {
                    accounts.savings[index] = receivedDeposit
                }
                
                self.account = accounts
                
                completion(.success(accounts))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func callExchangeAPI(_ model: ExchangeModel,
                                 completion: @escaping (Result<DepositModel, ExchangeError>) -> Void) {
        webRepository.exchange(model)
            .receive(on: DispatchQueue.main)
            .sink { completionExchange in
                switch completionExchange {
                case .finished:
                    print("finished exchaning")
                case .failure:
                    completion(.failure(ExchangeError.failedExchange))
                }
            } receiveValue: { deposit in
                completion(.success(deposit))
            }
            .store(in: &cancellables)
    }
    
    private func getCommission(for model: ExchangeModel) -> Double {
        let commissionCalculator = CommissionCalculator(localRepository: localRepository,
                                                        exchange: model)
        let commissionFee = commissionCalculator.calculateCommissionFee()
        return commissionFee
    }
}
