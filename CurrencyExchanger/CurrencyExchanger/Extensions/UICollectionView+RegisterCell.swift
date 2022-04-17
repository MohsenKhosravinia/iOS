//
//  UICollectionView+RegisterCell.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

extension UICollectionView {

    /// Register cells with nib file
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: String(describing: cell), bundle: nil),
                      forCellWithReuseIdentifier: String(describing: cell))
    }
}
