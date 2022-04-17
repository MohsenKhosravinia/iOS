//
//  DependencyInjector.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/16/22.
//

import UIKit

final class DependencyInjector {
    
    static let container = DependencyInjector()
    
    private init() {}
    
    func createMyBalancesVC() -> MyBalancesViewController {
        let viewController = UIStoryboard.main.instantiate(viewController: MyBalancesViewController.self)
        let localRepository = RealLocalRepository(userDefaults: UserDefaults.standard)
        let interactor = DefaultBalanceInteractor(localRepository: localRepository)
        let viewModel = DefaultMyBalancesViewModel(interactor: interactor)
        viewController.fill(viewModel: viewModel)
        return viewController
    }

    func createCurrencyExchangeVC() -> CurrencyExchangeViewController {
        let viewController = UIStoryboard.main.instantiate(viewController: CurrencyExchangeViewController.self)
        let networkController = NetworkController()
        let webRepository = DefaultExchangeWebRepository(networkController: networkController)
        let localRepository = RealLocalRepository(userDefaults: UserDefaults.standard)
        let interactor = DefaultExchangeInteractor(webRepository: webRepository, localRepository: localRepository)
        let viewModel = DefaultCurrencyExchangeViewModel(interactor: interactor)
        viewController.fill(viewModel: viewModel)
        return viewController
    }
}
