//
//  ShippingViewModel.swift
//  ExampleOptionSet
//
//  Created by Mohsen Khosravinia on 12/25/22.
//

import Foundation


final class ShippingViewModel: ObservableObject {
    @Published public var items: [String] = []
    
    public init(types: [ShippingOptions]) {
        if types.contains(.airplane) {
            items.append("Airplane ✈️")
        }
        
        if types.contains(.truck) {
            items.append("Truck 🚚")
        }
        
        if types.contains(.ship) {
            items.append("Ship ⛴️")
        }
        
        if types.contains(.train) {
            items.append("Train 🚊")
        }
    }
}
