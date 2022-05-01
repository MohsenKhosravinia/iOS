//
//  BurgerBuilder.swift
//  ExampleBuilder
//
//  Created by Mohsen Khosravinia on 5/1/22.
//

import Foundation

public class BurgerBuilder {
    public private(set) var meat: Meat = .beef
    public private(set) var sauces: Sauces = []
    public private(set) var toppings: Toppings = []
    private var soldOutMeats: [Meat] = []
    
    @discardableResult
    public func addSauces(_ sauce: Sauces) -> BurgerBuilder {
        sauces.insert(sauce)
        return self
    }
    
    @discardableResult
    public func removeSauces(_ sauce: Sauces) -> BurgerBuilder {
        sauces.remove(sauce)
        return self
    }

    @discardableResult
    public func addToppings(_ topping: Toppings) -> BurgerBuilder {
        toppings.insert(topping)
        return self
    }
    
    @discardableResult
    public func removeToppings(_ topping: Toppings) -> BurgerBuilder {
        toppings.remove(topping)
        return self
    }
    
    @discardableResult
    public func setMeat(_ meat: Meat) throws -> BurgerBuilder {
        guard isAvailable(meat) else { throw Error.soldOut }
        self.meat = meat
        return self
    }
    
    public func isAvailable(_ meat: Meat) -> Bool {
        return !soldOutMeats.contains(meat)
    }
    
    public func build() -> Burger {
        Burger(meat: meat,
               sauce: sauces,
               toppings: toppings)
    }
}
