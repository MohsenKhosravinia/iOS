//
//  ExchangeView.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

enum ExchangeViewType {
    case sell, receive
}

class ExchangeView: UIView, NibLoadable {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var currencySelectionButton: UIButton!
    
    public var currencySelectionCallback: (() -> Void)?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupFromNib()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupFromNib()
        commonInit()
    }
    
    // MARK: - Methods
    
    private func commonInit() {}
    
    public func setupViews(forType type: ExchangeViewType, currency: CurrencyType) {
        switch type {
        case .sell:
            iconImageView.image = UIImage(systemName: "arrow.up")
            iconImageView.backgroundColor = .systemRed
            titleLabel.text = "Sell"
            textField.placeholder = "e.g. 100.00"
        case .receive:
            iconImageView.image = UIImage(systemName: "arrow.down")
            iconImageView.backgroundColor = .systemGreen
            titleLabel.text = "Receive"
            textField.placeholder = "exchanged amount"
            textField.isUserInteractionEnabled = false
        }
        
        iconImageView.tintColor = .white
        iconImageView.makeItCapsuleOrCircle()
        
        select(currency: currency)
    }
    
    public func select(currency: CurrencyType) {
        currencySelectionButton.setTitle(currency.rawValue, for: .normal)
    }
    
    // MARK: - IBActions
    
    @IBAction func currencySelectionButtonTapped(_ sender: UIButton) {
        currencySelectionCallback?()
    }
    
}
