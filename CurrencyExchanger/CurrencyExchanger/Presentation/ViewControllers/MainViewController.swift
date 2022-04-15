//
//  MainViewController.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var myBalancesContainerView: UIView!
    @IBOutlet weak var currencyExchangeContainerView: UIView!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: Properties
    
    private lazy var myBalancesViewController: UIViewController = {
        let viewController = UIStoryboard.main.instantiate(viewController: MyBalancesViewController.self)
        let localRepository = RealLocalRepository.shared
        let interactor = DefaultBalanceInteractor(localRepository: localRepository)
        let viewModel = DefaultMyBalancesViewModel(interactor: interactor)
        viewController.fill(viewModel: viewModel)
        return viewController
    }()
    
    private lazy var currencyExchangeViewController: UIViewController = {
        UIStoryboard.main.instantiate(viewController: CurrencyExchangeViewController.self)
    }()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChildViewControllers()
    }
    
    // MARK: Methods
    
    private func setupChildViewControllers() {
        add(child: myBalancesViewController, container: myBalancesContainerView)
        add(child: currencyExchangeViewController, container: currencyExchangeContainerView)
    }

}
