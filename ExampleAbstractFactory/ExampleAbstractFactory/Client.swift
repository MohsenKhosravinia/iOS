//
//  Client.swift
//  ExampleAbstractFactory
//
//  Created by Mohsen Khosravinia on 4/13/22.
//

import Foundation
import UIKit

class Client {
    
    private let factoryType: AuthViewFactory.Type
    
    init(factoryType: AuthViewFactory.Type) {
        self.factoryType = factoryType
    }
    
    public func loginViewController() -> UINavigationController {
        let viewController = factoryType.createAuthViewController(for: .login)
        return UINavigationController(rootViewController: viewController)
        
    }
    
    public func signUpViewController() -> UINavigationController {
        let viewController = factoryType.createAuthViewController(for: .signup)
        return UINavigationController(rootViewController: viewController)
    }
}
