//
//  HomeViewModel.swift
//  FlickerFetcher
//
//  Created by Mohsen Khosravinia on 5/20/22.
//

import Foundation
import Combine

protocol HomeViewModel {
    var photoPublisher: PassthroughSubject<PageModel<PhotoModel>, Never> { get }
    var errorPublisher: PassthroughSubject<String, Never> { get }
    
    func fetchPhotos(ofPage page: Int)
}

final class DefaultHomeViewModel: HomeViewModel {
    
    public var photoPublisher = PassthroughSubject<PageModel<PhotoModel>, Never>()
    public var errorPublisher = PassthroughSubject<String, Never>()
    private let interactor: HomeInteractor
    
    init(interactor: HomeInteractor) {
        self.interactor = interactor
    }
    
    func fetchPhotos(ofPage page: Int = 1) {
        interactor.fetchRecentPhotos(of: page) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                guard let photos = model.photos else { return }
                self.photoPublisher.send(photos)
            case .failure(let error):
                switch error {
                case .responseFailure:
                    self.errorPublisher.send("Something went wrong! Try again later.")
                }
            }
        }
            
    }
}
