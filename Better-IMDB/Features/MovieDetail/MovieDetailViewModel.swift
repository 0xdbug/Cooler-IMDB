//
//  MovieDetailViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailViewModel {
    let networkService: MovieDetailNetworkServiceProtocol
    
    var item: BehaviorRelay<MovieDetail?> = .init(value: nil)
    var videoURL: BehaviorRelay<String?> = .init(value: nil)
    private let disposeBag = DisposeBag()
    
    private var currentPage = 1
    private var totalPages = 1
    private var currentCategory: HomeCardCategory?
    
    init(networkService: MovieDetailNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchMovie(withId id: String) {
        networkService.fetchMovie(withId: id)
            .subscribe(onNext: { [weak self] movie in
                guard let self = self else { return }
                self.item.accept(movie)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchTrailer(withId id: Int) {
        networkService.fetchVideoURLString(withId: id)
            .subscribe(onNext: { [weak self] urlString in
                guard let self = self else { return }
                videoURL.accept(urlString)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
}
