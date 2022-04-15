//
//  UIView+CornerRadius.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

extension UIView {
    
    func makeItCapsuleOrCircle() {
        if frame.height >= frame.width {
            layer.cornerRadius = frame.width / 2
        } else {
            layer.cornerRadius = frame.height / 2
        }
        
        layer.masksToBounds = true
        clipsToBounds = true
    }
}
