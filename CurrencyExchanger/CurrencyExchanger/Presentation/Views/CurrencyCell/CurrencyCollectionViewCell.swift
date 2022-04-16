//
//  CurrencyCollectionViewCell.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        reset()
    }
    
    public func fill(deposit: DepositModel) {
        titleLabel.text = deposit.concatenated()
        contentView.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.2)
        contentView.setCorner(radius: 10)
    }
    
    private func reset() {
        titleLabel.text = nil
    }

}
