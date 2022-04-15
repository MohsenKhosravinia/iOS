//
//  Storyboards.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

// MARK: - Storyboard names

public extension UIStoryboard {
    
    class var main: UIStoryboard {
        self.init(name: "Main", bundle: nil)
    }
}

// MARK: - Instantiating

public extension UIStoryboard {
    
    func instantiate<T: UIViewController>(viewController: T.Type) -> T {
        if let viewController = self.instantiateViewController(withIdentifier: String(describing: T.self)) as? T {
            return viewController
        }
        return T()
    }
}
