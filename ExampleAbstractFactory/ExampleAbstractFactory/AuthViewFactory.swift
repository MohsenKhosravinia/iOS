//
//  AuthViewFactory.swift
//  ExampleAbstractFactory
//
//  Created by Mohsen Khosravinia on 4/13/22.
//

import UIKit

protocol AuthViewFactory {
    static func createAuthView(for type: AuthType) -> AuthView
    static func createAuthViewController(for type: AuthType) -> AuthViewController
}

class AdminViewFactory: AuthViewFactory {
    static func createAuthView(for type: AuthType) -> AuthView {
        switch type {
        case .signup:
            return AdminSignUpView()
        case .login:
            return AdminLoginView()
        }
    }
    
    static func createAuthViewController(for type: AuthType) -> AuthViewController {
        AdminAuthViewController(authView: createAuthView(for: type))
    }
}

class EmployeeViewFactory: AuthViewFactory {
    static func createAuthView(for type: AuthType) -> AuthView {
        switch type {
        case .signup:
            return EmployeeSignUpView()
        case .login:
            return EmployeeLoginView()
        }
    }
    
    static func createAuthViewController(for type: AuthType) -> AuthViewController {
        EmployeeAuthViewController(authView: createAuthView(for: type))
    }
}
