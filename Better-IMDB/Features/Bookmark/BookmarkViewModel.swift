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

