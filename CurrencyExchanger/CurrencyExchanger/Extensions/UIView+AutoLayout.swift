//
//  UIView+AutoLayout.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

extension UIView {
    
    func fillSuperview() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview` before calling `bindFrameToSuperviewBounds()`")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
    }
    
    func fillSuperview(padding: CGFloat) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview` before calling `bindFrameToSuperviewBounds()`")
            return
        }
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding).isActive = true
    }

    func fillSuperview(horizontalPadding: CGFloat = 0, verticalPadding: CGFloat = 0) {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview` before calling `bindFrameToSuperviewBounds()`")
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: verticalPadding).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -verticalPadding).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: horizontalPadding).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -horizontalPadding).isActive = true
    }
}
