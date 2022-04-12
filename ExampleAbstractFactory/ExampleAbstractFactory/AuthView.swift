//
//  AuthView.swift
//  ExampleAbstractFactory
//
//  Created by Mohsen Khosravinia on 4/13/22.
//

import UIKit

enum AuthType { case signup, login }

protocol AuthView {
    typealias AuthAction = (AuthType) -> Void
    
    var contentView: UIView { get }
    var description: String { get }
    var handler: AuthAction? { get set }
}

class AdminSignUpView: UIView, AuthView {
    var contentView: UIView { return self }
    
    var handler: AuthAction?
}

class AdminLoginView: UIView, AuthView {
    var contentView: UIView { return self }
    
    var handler: AuthAction?
}

class EmployeeSignUpView: UIView, AuthView {
    var contentView: UIView { return self }
    
    var handler: AuthAction?
}

class EmployeeLoginView: UIView, AuthView {
    var contentView: UIView { return self }
    
    var handler: AuthAction?
}
