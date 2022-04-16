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
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: Properties
    
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var myBalancesViewController: MyBalancesViewController = {
        let viewController = UIStoryboard.main.instantiate(viewController: MyBalancesViewController.self)
        let localRepository = RealLocalRepository.shared
        let interactor = DefaultBalanceInteractor(localRepository: localRepository)
        let viewModel = DefaultMyBalancesViewModel(interactor: interactor)
        viewController.fill(viewModel: viewModel)
        return viewController
    }()
    
    private lazy var currencyExchangeViewController: CurrencyExchangeViewController = {
        let viewController = UIStoryboard.main.instantiate(viewController: CurrencyExchangeViewController.self)
        let networkController = NetworkController()
        let webRepository = DefaultExchangeWebRepository(networkController: networkController)
        let localRepository = RealLocalRepository.shared
        let interactor = DefaultExchangeInteractor(webRepository: webRepository, localRepository: localRepository)
        let viewModel = DefaultCurrencyExchangeViewModel(interactor: interactor)
        viewController.fill(viewModel: viewModel)
        return viewController
    }()
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupChildViewControllers()
        setupBindings()
    }
    
    // MARK: Methods
    
    private func setupNavigationController() {
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
            .sink { [weak self] accountModel in
                self?.myBalancesViewController.reload()
            }
            .store(in: &cancellables)
    }

}
