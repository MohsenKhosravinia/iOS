//
//  MyBalancesViewController.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

protocol BalanceInteractor {
    func getAccount() -> AccountModel
}

final class DefaultBalanceInteractor: BalanceInteractor {
    
    let localRepository: LocalRepository
    
    init(localRepository: LocalRepository) {
        self.localRepository = localRepository
    }
    
    func getAccount() -> AccountModel {
        // FIXME: REMOVE MOCK MODEL
        AccountModel(savings: [.init(amount: "1000", currency: .eur),
                               .init(amount: "2000", currency: .usd),
                               .init(amount: "0", currency: .jpy)])
//        localRepository.account
    }
}

protocol MyBalancesViewModel {
    var account: AccountModel { get }
}

final class DefaultMyBalancesViewModel: MyBalancesViewModel {
    
    private let interactor: BalanceInteractor
    
    var account: AccountModel {
        interactor.getAccount()
    }
    
    init(interactor: BalanceInteractor) {
        self.interactor = interactor
    }
}

class MyBalancesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: MyBalancesViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    public func fill(viewModel: MyBalancesViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CurrencyCollectionViewCell.self)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }

}

// MARK: - UICollectionViewDataSource

extension MyBalancesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.account.savings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CurrencyCollectionViewCell.self, indexPath: indexPath)
        cell.contentView.backgroundColor = .systemMint
        cell.fill(deposit: viewModel.account.savings[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MyBalancesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = viewModel.account.savings[indexPath.item].concatenated()
        let padding: CGFloat = 30
        return .init(width: text.widht + padding, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        50
    }
}
