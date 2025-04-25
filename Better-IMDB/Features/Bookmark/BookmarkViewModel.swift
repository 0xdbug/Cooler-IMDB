//
//  BookmarkViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

class BookmarkViewModel {
    let networkService: TMDBNetworkServiceProtocol
    
    var items: BehaviorRelay<[MovieDetail]> = .init(value: [])
    private let disposeBag = DisposeBag()
    
    init(networkService: TMDBNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchMovies(withIds id: [Int]) {
        networkService.fetchMovies(ids: id)
            .subscribe(onNext: { [weak self] movies in
                guard let self = self else { return }
                print(movies)
                self.items.accept(movies)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }

}

//class BookmarkViewModel: ViewModel {
//    let networkService: TMDBNetworkServiceProtocol
//    
//    private let itemsRelay = BehaviorRelay<[MovieDetail]>(value: [])
//    var items: Driver<[MovieDetail]> {
//        return itemsRelay.asDriver()
//    }
//    
//    init(networkService: TMDBNetworkServiceProtocol) {
//        self.networkService = networkService
//        super.init()
//    }
//    
//    func fetchMovies(withIds id: [Int]) {
//        startLoading()
//        
//        networkService.fetchMovies(ids: id)
//            .subscribe(onNext: { [weak self] movies in
//                guard let self = self else { return }
//                self.itemsRelay.accept(movies)
//                self.stopLoading()
//            }, onError: { [weak self] error in
//                self?.stopLoading()
//                self?.handleError(error)
//            })
//            .disposed(by: disposeBag)
//    }
//}

