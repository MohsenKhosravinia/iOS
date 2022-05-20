//
//  ViewController.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import UIKit
import Combine

class HomeVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: HomeViewModel?
    private var data: PageModel<PhotoModel>?
    private let cellID = "cellID"
    
    private var collectionViewLayout: UICollectionViewLayout = {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.bottom = 10
        section.orthogonalScrollingBehavior = .none
        
        let layout = UICollectionViewCompositionalLayout { _, _ in section }
        return layout

    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupBindigs()
        
        viewModel?.fetchPhotos(ofPage: 1)
    }
    
    public func fill(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = collectionViewLayout
        collectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: cellID)
    }
    
    private func setupBindigs() {
        viewModel?.photoPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] model in
                guard let self = self,
                      let page = model.page else { return }
                
                if page == 1 {
                    self.data = model
                } else {
                    self.data?.items?.append(contentsOf: model.items ?? [])
                }
                
                self.collectionView.reloadData()
            })
            .store(in: &cancellables)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.items?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ImageCell
        cell.fill(photo: data?.items?[indexPath.item] ?? .init())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        cell.flip()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let items = data?.items,
           indexPath.row == items.count - 1,
           let pages = data?.pages,
           let page = data?.page,
           page < pages {
            viewModel?.fetchPhotos(ofPage: page + 1)
        }

    }
}
