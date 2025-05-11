//
//  BookmarkViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

protocol BookmarkViewModelProtocol: AnyObject {
    var items: Driver<[MovieDetail]> { get }
    func fetchMovies(withIds id: [Int])
    func showDetail(_ movie: MovieDetail, from listViewController: BookmarkViewController, at indexPath: IndexPath)
}

class BookmarkViewModel: ViewModel, BookmarkViewModelProtocol {
    weak var delegate: BookmarkViewModelDelegate?
    private let repository: TMDBRepositoryProtocol
    
    private let itemsRelay = BehaviorRelay<[MovieDetail]>(value: [])
    var items: Driver<[MovieDetail]> {
        return itemsRelay.asDriver()
    }
    
    init(repository: TMDBRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchMovies(withIds id: [Int]) {
        startLoading()
        
        repository.getMovies(ids: id)
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
    
    func showDetail(_ movie: MovieDetail, from listViewController: BookmarkViewController, at indexPath: IndexPath) {
        delegate?.showDetail(movie, from: listViewController, at: indexPath)
    }
}

