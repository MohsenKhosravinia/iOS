//
//  CurrencyExchangeViewControllerTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/17/22.
//

@testable import CurrencyExchanger
import XCTest
import Combine

class CurrencyExchangeViewControllerTests: XCTestCase {

    func test_properties_render() {
        let sut = makeCurrencyExchangeVC()
        
        XCTAssertNotNil(sut.sellExchangeView)
        XCTAssertNotNil(sut.receiveExchangeView)
        XCTAssertNotNil(sut.submitButton)
    }
    
    func test_sellExchangeView_setupCorrectly() {
        let sut = makeCurrencyExchangeVC()
        
        sut.setupExchangeViews()
        
        XCTAssertEqual(sut.sellExchangeView.currencyType, .eur)
        XCTAssertEqual(sut.receiveExchangeView.currencyType, .usd)
    }
    
    func test_ExchangeViewCallbacks_instantiate() {
        let sut = makeCurrencyExchangeVC()
        
        sut.setupCallbacks()
        
        XCTAssertNotNil(sut.sellExchangeView.currencySelectionCallback)
        XCTAssertNotNil(sut.receiveExchangeView.currencySelectionCallback)
    }
    
    // MARK: Factory
    
    private func makeCurrencyExchangeVC() -> CurrencyExchangeViewController {
        let sut = UIStoryboard.main.instantiate(viewController: CurrencyExchangeViewController.self)
        sut.loadViewIfNeeded()
        return sut
    }

}

//private extension CurrencyExchangeViewControllerTests {
//
//    final class MockCurrencyExchangeViewModel: CurrencyExchangeViewModel {
//        var exchangeCalculationPublisher: PassthroughSubject<DepositModel, Never> { PassthroughSubject<DepositModel, Never>() }
//
//        var exchangeExecutionPublisher: PassthroughSubject<TransactionModel, Never> { PassthroughSubject<TransactionModel, Never>() }
//
//        var errorPublisher: PassthroughSubject<String, Never> { PassthroughSubject<String, Never>() }
//
//        func calculateExchange(amount: Double, fromType: CurrencyType, toType: CurrencyType) {
//            let mockDeposit = DepositModel(amount: "100", currency: .usd)
//            exchangeCalculationPublisher.send(mockDeposit)
//        }
//
//        func submitExchange(amount: Double, fromType: CurrencyType, toType: CurrencyType) {
//
//        }
//    }
//}


//func test_navigationBar_isNotHidden() {
//    let viewController = makeCurrencyExchangeVC()
//    let navigationController = UINavigationController(rootViewController: viewController)
//    let sut = navigationController.viewControllers.first as! CurrencyExchangeViewController
//
//    sut.setupNavigationController()
//
//    XCTAssertNotNil(sut.sellExchangeView)
//}
