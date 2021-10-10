//
//  LoginViewModel.swift
//  ExampleTesting
//
//  Created by Mohsen Khosravinia on 10/10/21.
//

import Foundation

protocol LoginViewModelInterface {
    func isValid(email: String) -> Bool
}

class LoginViewModel: LoginViewModelInterface {

    func isValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

}
