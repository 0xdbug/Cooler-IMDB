//
//  BookmarkViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

class BookmarkViewModel: ViewModel {
    weak var coordinator: BookmarkCoordinator?
    let networkService: TMDBNetworkServiceProtocol
    
    private let itemsRelay = BehaviorRelay<[MovieDetail]>(value: [])
    var items: Driver<[MovieDetail]> {
        return itemsRelay.asDriver()
    }
    
    init(coordinator: BookmarkCoordinator, networkService: TMDBNetworkServiceProtocol) {
        self.coordinator = coordinator
        self.networkService = networkService
    }
    
    func fetchMovies(withIds id: [Int]) {
        startLoading()
        
        networkService.fetchMovies(ids: id)
            .subscribe(onNext: { [weak self] movies in
                guard let self = self else { return }
                self.itemsRelay.accept(movies)
                self.stopLoading()
            }, onError: { [weak self] error in
                self?.stopLoading()
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
    }
}

extension BookmarkViewModel: BookmarkViewControllerDelegate {
    func showDetail(_ movie: MovieDetail, from listViewController: BookmarkViewController, at indexPath: IndexPath) {
        coordinator?.showDetail(movie, from: listViewController, at: indexPath)
    }
}
