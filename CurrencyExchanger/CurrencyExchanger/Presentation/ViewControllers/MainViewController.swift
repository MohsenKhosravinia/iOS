//
//  MainViewController.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var myBalancesContainerView: UIView!
    @IBOutlet weak var currencyExchangeContainerView: UIView!
    
    // MARK: Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var myBalancesViewController: MyBalancesViewController = {
        DependencyInjector.container.createMyBalancesVC()
    }()
    
    private lazy var currencyExchangeViewController: CurrencyExchangeViewController = {
        DependencyInjector.container.createCurrencyExchangeVC()
    }()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupChildViewControllers()
        setupBindings()
    }
    
    // MARK: Methods
    
    func setupNavigationController() {
        navigationItem.title = "Currency Converter"
    }
    
    private func setupChildViewControllers() {
        add(child: myBalancesViewController, container: myBalancesContainerView)
        add(child: currencyExchangeViewController, container: currencyExchangeContainerView)
    }
    
    private func setupBindings() {
        currencyExchangeViewController
            .exchangePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.myBalancesViewController.reload()
            }
            .store(in: &cancellables)
    }
}
