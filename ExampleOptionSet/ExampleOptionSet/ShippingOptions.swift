//
//  ShippingOptions.swift
//  ExampleOptionSet
//
//  Created by Mohsen Khosravinia on 12/25/22.
//

import Foundation

struct ShippingOptions: OptionSet {
    let rawValue: UInt
    
    static let airplane = ShippingOptions(rawValue: 1 << 0)
    static let ship = ShippingOptions(rawValue: 1 << 1)
    static let train = ShippingOptions(rawValue: 1 << 2)
    static let truck = ShippingOptions(rawValue: 1 << 3)
    
    static let land: [ShippingOptions] = [.train, .truck]
    static let all: [ShippingOptions] = [.airplane, .ship, .train, .truck]
}

extension ShippingOptions: Identifiable {
    var id: String { UUID().uuidString }
}
