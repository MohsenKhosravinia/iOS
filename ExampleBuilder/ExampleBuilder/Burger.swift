//
//  Burger.swift
//  ExampleBuilder
//
//  Created by Mohsen Khosravinia on 5/1/22.
//

import Foundation

public struct Burger {
    public let meat: Meat
    public let sauce: Sauces
    public let toppings: Toppings
}

extension Burger: CustomStringConvertible {
    public var description: String {
        return meat.rawValue + " burger"
    }
}

public enum Meat: String {
    case beef
    case chicken
    case kitten
    case tofu
}

public struct Sauces: OptionSet {
    public static let mayonnaise = Sauces(rawValue: 1 << 0)
    public static let mustard = Sauces(rawValue: 1 << 1)
    public static let ketchup = Sauces(rawValue: 1 << 2)
    public static let secret = Sauces(rawValue: 1 << 3)
    
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public struct Toppings: OptionSet {
    public static let cheese = Toppings(rawValue: 1 << 0)
    public static let lettuce = Toppings(rawValue: 1 << 1)
    public static let pickles = Toppings(rawValue: 1 << 2)
    public static let tomatoes = Toppings(rawValue: 1 << 3)
    
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}
