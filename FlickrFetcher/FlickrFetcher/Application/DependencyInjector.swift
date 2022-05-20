//
//  DependencyInjector.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import UIKit

final class DependencyInjector {
    
    static let shared = DependencyInjector()
    
    private init() {}
    
    lazy var homeVC: HomeVC = {
        let viewController = UIStoryboard.home.instantiate(viewController: HomeVC.self)
        let networkController = NetworkController()
        let webRepository = DefaultHomeWebRepository(networkController: networkController)
        let interactor = DefaultHomeInteractor(webRepository: webRepository)
        let viewModel = DefaultHomeViewModel(interactor: interactor)
        viewController.fill(viewModel: viewModel)
        return viewController
    }()
    
}
