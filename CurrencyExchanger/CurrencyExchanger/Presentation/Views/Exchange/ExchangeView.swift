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
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
    }
    
    // MARK: - Methods
    
    private func commonInit() {}
    
    public func setupViews(forType type: ExchangeViewType, currency: CurrencyType) {
        switch type {
        case .sell:
            iconImageView.image = UIImage(systemName: "arrow.up")
            iconImageView.tintColor = .systemRed
            titleLabel.text = "Sell"
        case .receive:
            iconImageView.image = UIImage(systemName: "arrow.down")
            iconImageView.tintColor = .systemGreen
            titleLabel.text = "Receive"
            textField.isUserInteractionEnabled = false
        }
    }
    
    public func set(currency: CurrencyType) {
        currencySelectionButton.setTitle(currency.rawValue, for: .normal)
    }
    
    // MARK: - IBActions
    
    @IBAction func currencySelectionButtonTapped(_ sender: UIButton) {
        print("Currency button Tapped")
        currencySelectionCallback?()
    }
    
}
