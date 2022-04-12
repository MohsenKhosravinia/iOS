//
//  AuthViewFactory.swift
//  ExampleAbstractFactory
//
//  Created by Mohsen Khosravinia on 4/13/22.
//

import UIKit

protocol AuthViewFactory {
    func createAuthView(for type: AuthType) -> AuthView
    func createAuthViewController(for type: AuthType) -> AuthViewController
}

class AdminViewFactory: AuthViewFactory {
    func createAuthView(for type: AuthType) -> AuthView {
        switch type {
        case .signup:
            return AdminSignUpView()
        case .login:
            return AdminLoginView()
        }
    }
    
    func createAuthViewController(for type: AuthType) -> AuthViewController {
        AdminAuthViewController(contentView: createAuthView(for: type))
    }
}

class EmployeeViewFactory: AuthViewFactory {
    func createAuthView(for type: AuthType) -> AuthView {
        switch type {
        case .signup:
            return EmployeeSignUpView()
        case .login:
            return EmployeeLoginView()
        }
    }
    
    func createAuthViewController(for type: AuthType) -> AuthViewController {
        EmployeeAuthViewController(contentView: createAuthView(for: type))
    }
}
