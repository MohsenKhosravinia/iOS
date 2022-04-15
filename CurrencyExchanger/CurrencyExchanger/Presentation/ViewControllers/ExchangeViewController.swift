//
//  ExchangeViewController.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

class ExchangeViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var myBalancesContainerView: UIView!
    @IBOutlet weak var currencyExchangeContainerView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Properties
    
    private lazy var myBalancesViewController: UIViewController = {
        UIStoryboard.main.instantiate(viewController: MyBalancesViewController.self)
    }()
    
    private lazy var currencyExchangeViewController: UIViewController = {
        UIStoryboard.main.instantiate(viewController: CurrencyExchangeViewController.self)
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
        
        myBalancesViewController.view.backgroundColor = .red
    }
    
    // MARK: - Methods
    
    private func setupChildViewControllers() {
        add(child: myBalancesViewController, container: myBalancesContainerView)
        add(child: currencyExchangeViewController, container: currencyExchangeContainerView)
    }

}