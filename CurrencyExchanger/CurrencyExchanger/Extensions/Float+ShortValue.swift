//
//  Float+ShortValue.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

import Foundation

extension Double {
    
    var shortValue: String {
        String(format: "%g", self)
    }
}
