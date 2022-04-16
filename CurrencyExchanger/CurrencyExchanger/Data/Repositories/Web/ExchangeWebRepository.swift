//
//  ExchangeWebRepository.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Combine

protocol ExchangeWebRepository: ServiceProtocol {
    func exchange(_ model: ExchangeModel) -> AnyPublisher<DepositModel, Error>
}

struct DefaultExchangeWebRepository: ExchangeWebRepository {

    let networkController: NetworkControllerProtocol
    
    func exchange(_ model: ExchangeModel) -> AnyPublisher<DepositModel, Error> {
        let endPoint = API.exchange(model: model).endPoint
        return networkController.get(type: DepositModel.self,
                                     url: endPoint.url,
                                     headers: endPoint.baseHeaders)
    }
}
