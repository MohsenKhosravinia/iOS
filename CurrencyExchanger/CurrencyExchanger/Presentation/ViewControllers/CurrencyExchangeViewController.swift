//
//  CurrencyExchangeViewController.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

class CurrencyExchangeViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var sellExchangeView: ExchangeView!
    @IBOutlet weak var receiveExchangeView: ExchangeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupExchangeViews()
    }
    
    private func setupExchangeViews() {
        sellExchangeView.setupViews(forType: .sell, currency: .usd)
        receiveExchangeView.setupViews(forType: .receive, currency: .eur)
    }

}
