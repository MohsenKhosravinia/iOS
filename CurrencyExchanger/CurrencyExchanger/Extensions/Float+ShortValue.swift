//
//  Float+ShortValue.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

import Foundation

extension Double {
    
    var shortValue: String {
        return String(format: "%g", self)
    }
}
