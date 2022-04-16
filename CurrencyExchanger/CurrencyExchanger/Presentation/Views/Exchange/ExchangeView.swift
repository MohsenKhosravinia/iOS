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
    @IBOutlet weak var textField: LimitedDecimalTextField!
    @IBOutlet weak var currencySelectionButton: UIButton!
    
    public var currencyType: CurrencyType = .usd
    public var currencySelectionCallback: ((CurrencyType) -> Void)?
    
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
        currencyType = currency
        
        switch type {
        case .sell:
            iconImageView.image = UIImage(systemName: "arrow.up")
            iconImageView.backgroundColor = .systemRed
            titleLabel.text = "Sell"
            textField.placeholder = "e.g. 100.00"
            textField.textColor = .black
        case .receive:
            iconImageView.image = UIImage(systemName: "arrow.down")
            iconImageView.backgroundColor = .systemGreen
            titleLabel.text = "Receive"
            textField.placeholder = "exchanged amount"
            textField.textColor = .systemGreen
            textField.isUserInteractionEnabled = false
        }
        
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        
        iconImageView.tintColor = .white
        iconImageView.makeItCapsuleOrCircle()
        
        select(currency: currency)
    }
    
    public func select(currency: CurrencyType) {
        currencyType = currency
        currencySelectionButton.setTitle(currency.rawValue, for: .normal)
    }
    
    public func set(amount: String) {
        textField.text = amount
    }
    
    public func clear() {
        textField.text = ""
    }
    
    // MARK: - IBActions
    
    @IBAction func currencySelectionButtonTapped(_ sender: UIButton) {
        currencySelectionCallback?(currencyType)
    }
    
}
