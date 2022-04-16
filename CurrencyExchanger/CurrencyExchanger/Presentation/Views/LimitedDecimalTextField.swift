//
//  LimitedDecimalTextField.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/17/22.
//

import UIKit

class LimitedDecimalTextField: UITextField {
    
    // MARK: Properties
    
    private let numberOfDecimalDigits: Int = 2
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // MARK: Methods
    
    private func setup() {
        delegate = self
    }
}

// MARK: - UITextFieldDelegate

extension LimitedDecimalTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }

        let newText = oldText.replacingCharacters(in: r, with: string)
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        let numberOfDots = newText.components(separatedBy: ".").count - 1

        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }

        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= self.numberOfDecimalDigits
    }
}
