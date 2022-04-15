//
//  UICollectionView+DequeueCell.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

extension UICollectionView {
    
    func dequeue<T: UICollectionViewCell>(_ cell: T.Type, indexPath: IndexPath) -> T {
        if let dequeuedCell = self.dequeueReusableCell(withReuseIdentifier: String(describing: cell),
                                                       for: indexPath) as? T {
            return dequeuedCell
        }
        return T()
    }
}
