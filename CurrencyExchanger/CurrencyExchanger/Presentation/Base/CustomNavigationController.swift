//
//  CustomNavigationController.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

import UIKit

final class CustomNavigationController: UINavigationController {
    
    // MARK: Properties
    
    private let backgroundColor: UIColor = .systemBlue
    private let titleColor: UIColor = .white
    private let itemColor: UIColor = .black
    private let font: UIFont = .systemFont(ofSize: 16)
    
    // MARK: Life cycle
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupViews()
    }
    
    // MARK: Methods
    
    private func setupViews() {
        let appearance = UINavigationBarAppearance()
        
        /// bar background color
        appearance.backgroundColor = backgroundColor
        
        /// title label's attributes
        appearance.titleTextAttributes = [.font: font, .foregroundColor: titleColor]
        
        /// divider color
        appearance.shadowColor = backgroundColor
        
        /// set appearance
        navigationBar.compactAppearance = appearance
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        /// items colors (bar button items)
        navigationBar.tintColor = itemColor
        
        /// remove 'back' text on back button
        navigationBar.backItem?.backButtonTitle = ""
        
        /// make view grows under status bar ???
        navigationBar.isTranslucent = true
    }

}

