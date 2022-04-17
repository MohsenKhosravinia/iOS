//
//  MainViewControllerTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/17/22.
//

@testable import CurrencyExchanger
import XCTest

class MainViewControllerTests: XCTestCase {

    func test_properties_areNotNil() {
        let sut = makeMainViewController()
        
        XCTAssertNotNil(sut.myBalancesContainerView)
        XCTAssertNotNil(sut.currencyExchangeContainerView)
    }
    
    func test_navigationBar_isNotHidden() {
        let viewController = makeMainViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let sut = navigationController.viewControllers.first as! MainViewController
        
        XCTAssertFalse(sut.navigationController!.isNavigationBarHidden)
    }
    
    func test_navigationBarTitle_sets() {
        let viewController = makeMainViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let sut = navigationController.viewControllers.first as! MainViewController
        
        sut.setupNavigationController()
        let title = try! XCTUnwrap(sut.navigationItem.title)
        
        XCTAssertEqual(title, "Currency Converter")
    }
    
    // MARK: Factory
    
    private func makeMainViewController() -> MainViewController {
        let sut = UIStoryboard.main.instantiate(viewController: MainViewController.self)
        sut.loadViewIfNeeded()
        return sut
    }

}
