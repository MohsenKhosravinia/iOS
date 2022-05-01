//
//  Employee.swift
//  ExampleBuilder
//
//  Created by Mohsen Khosravinia on 5/1/22.
//

import Foundation

// MARK: - Director

public class Employee {
    
    public func createCombo1() throws -> Burger {
        let builder = BurgerBuilder()
        try builder.setMeat(.beef)
        builder.addSauces(.secret)
        builder.addToppings([.lettuce, .tomatoes, .pickles])
        return builder.build()
    }
    
    public func createKittenSpecial() throws -> Burger {
        let builder = BurgerBuilder()
        try builder.setMeat(.kitten)
        builder.addSauces(.mustard)
        builder.addToppings([.lettuce, .tomatoes])
        return builder.build()
    }
}
