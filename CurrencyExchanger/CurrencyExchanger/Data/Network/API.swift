//
//  API.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import Foundation

enum API {
    case exchange(model: ExchangeModel)

    var endPoint: EndPoint {
        switch self {
        case .exchange(let model):
            let basePath = "/currency/commercial/exchange/"
            let values = "\(model.amount)-\(model.source.rawValue)/\(model.destination.rawValue)/latest"
            return EndPoint(path: basePath + values)
        }
    }
}
