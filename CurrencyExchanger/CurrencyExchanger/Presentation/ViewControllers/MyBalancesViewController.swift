//
//  MyBalancesViewController.swift
//  CurrencyExchanger
//
//  Created by Mohsen Khosravinia on 4/15/22.
//

import UIKit

class MyBalancesViewController: UIViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties
    
    private var viewModel: MyBalancesViewModel!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    // MARK: Methods
    
    public func fill(viewModel: MyBalancesViewModel) {
        self.viewModel = viewModel
    }
    
    public func reload() {
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CurrencyCollectionViewCell.self)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.contentInset.left = Constants.contentHorizontalInset
        collectionView.contentInset.right = Constants.contentHorizontalInset
        collectionView.showsHorizontalScrollIndicator = false
    }
    
}

// MARK: - UICollectionViewDataSource

extension MyBalancesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.account.savings.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(CurrencyCollectionViewCell.self, indexPath: indexPath)
        cell.fill(deposit: viewModel.account.savings[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension MyBalancesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = viewModel.account.savings[indexPath.item].concatenated()
        let padding: CGFloat = Constants.widthPadding
        let height: CGFloat = Constants.cellHeight
        let width = text.width(withConstrainedHeight: height,
                               font: .systemFont(ofSize: Constants.fontSize))
        return .init(width: width + padding, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        Constants.minimumInterItemWidth
    }
}

// MARK: - Constants

extension MyBalancesViewController {
    
    private enum Constants {
        static let widthPadding: CGFloat = 50
        static let cellHeight: CGFloat = 80
        static let fontSize: CGFloat = 14
        static let contentHorizontalInset: CGFloat = 20
        static let minimumInterItemWidth: CGFloat = 30
    }
}
