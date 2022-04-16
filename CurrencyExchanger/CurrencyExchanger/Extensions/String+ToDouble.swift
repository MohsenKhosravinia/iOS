//
//  String+ToDouble.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

import Foundation

extension String {
    
    var asDouble: Double {
        Double(self) ?? .zero
    }
}
