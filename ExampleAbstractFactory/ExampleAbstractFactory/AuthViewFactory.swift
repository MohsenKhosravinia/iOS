//
//  AuthViewFactory.swift
//  ExampleAbstractFactory
//
//  Created by Mohsen Khosravinia on 4/13/22.
//

import UIKit

// Factory method: create objects of same family (hide concrete class initialization)
// Abstract Factory: create matrix products

// [admin   signup  login]
// [employy signup  login]

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

class GuestViewFactory: AuthViewFactory {
    static func createAuthView(for type: AuthType) -> AuthView {
        switch type {
        case .signup:
            return EmployeeLoginView() // GuestSignupView()
        case .login:
            return EmployeeLoginView() // GuestLoginView()
        }
    }
    
    static func createAuthViewController(for type: AuthType) -> AuthViewController {
        GuestAuthViewController(authView: createAuthView(for: type))
    }
}
