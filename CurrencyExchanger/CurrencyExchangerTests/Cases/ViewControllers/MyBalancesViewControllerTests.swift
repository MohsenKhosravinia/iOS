//
//  MyBalancesViewControllerTests.swift
//  CurrencyExchangerTests
//
//  Created by Mohsen Khosravinia on 4/17/22.
//

@testable import CurrencyExchanger
import XCTest

class MyBalancesViewControllerTests: XCTestCase {

    func test_collectionView_renders() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.collectionView)
    }
    
    func test_collectionViewDelegate_sets() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.collectionView.delegate)
    }
    
    func test_collectionViewDataSource_sets() {
        let sut = makeSUT()
        
        XCTAssertNotNil(sut.collectionView.dataSource)
    }
    
    func test_collectionViewNumberOfItems_isZero() {
        let sut = makeSUT()
        
        sut.fill(viewModel: MockMyBalancesViewModel())
        let numberOfItems = sut.collectionView.numberOfItems()
        
        XCTAssertEqual(numberOfItems, 0)
    }
    
    func test_collectionViewNumberOfItems_isOne() {
        let sut = makeSUT()
        let viewModel = MockMyBalancesViewModel()
        
        viewModel.account = AccountModel(savings: [.init()])
        sut.fill(viewModel: viewModel)
        let numberOfItems = sut.collectionView.numberOfItems()
        
        XCTAssertEqual(numberOfItems, 1)
    }
    
    func test_collectionViewCellForRow_renderCurrencyCell() {
        let sut = makeSUT()
        let viewModel = MockMyBalancesViewModel()
        
        viewModel.account = AccountModel(savings: [.init()])
        sut.fill(viewModel: viewModel)
        let cell = sut.collectionView.cell()
        
        XCTAssertNotNil(cell)
        XCTAssertIdentical(type(of: cell), CurrencyCollectionViewCell.self)
    }
    
    // MARK: Factory
    
    private func makeSUT() -> MyBalancesViewController {
        let sut = UIStoryboard.main.instantiate(viewController: MyBalancesViewController.self)
        sut.loadViewIfNeeded()
        return sut
    }
}

// MARK: - Extension

private extension UICollectionView {
    
    func numberOfItems() -> Int {
        dataSource?.collectionView(self, numberOfItemsInSection: 0) ?? .zero
    }
    
    func cell() -> CurrencyCollectionViewCell {
        dequeue(CurrencyCollectionViewCell.self, indexPath: .init(row: 0, section: 0))
    }
    
}

// MARK: - Mock

private extension MyBalancesViewControllerTests {
    
    private final class MockMyBalancesViewModel: MyBalancesViewModel {
        var account: AccountModel = AccountModel(savings: [])
    }
}

