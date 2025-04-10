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
    let networkService: HomeNetworkServiceProtocol
    
    private let disposeBag = DisposeBag()
    var items: BehaviorRelay<[HomeCards]> = .init(value: [])
    
    init(networkService: HomeNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchItems() {
        items.accept([])

        let categories: [HomeCardCategory] = [.popular, .trending, .topRated, .upcoming]
        let categoryObservables = categories.map { fetchCategory($0) }
        
        Observable.concat(categoryObservables)
            .scan(into: [HomeCards]()) { (currentItems, newCard) in
                currentItems.append(newCard)
            }
            .asDriver(onErrorJustReturn: [])
            .drive(items)
            .disposed(by: disposeBag)
    }
    
    private func fetchCategory(_ category: HomeCardCategory) -> Observable<HomeCards> {
        switch category {
//            case .discover:
//                return fetchPopular()
            case .popular:
                return fetchPopular()
            case .trending:
                return fetchTrending()
            case .topRated:
                return fetchTopRated()
            case .upcoming:
                return fetchUpcoming()
        }
    }
    
    func fetchPopular() -> Observable<HomeCards> {
        networkService.popular()
            .map { result -> HomeCards in
                return HomeCards(cardName: "POPULAR",
                                 cardType: .popular,
                                 movies: result.results)
            }
    }
    
    func fetchTrending() -> Observable<HomeCards> {
        networkService.trending()
            .map { result -> HomeCards in
                return HomeCards(cardName: "TRENDING",
                                 cardType: .trending,
                                 movies: result.results)
            }
    }
    
    func fetchTopRated() -> Observable<HomeCards> {
        networkService.topRated()
            .map { result -> HomeCards in
                return HomeCards(cardName: "TOP RATED",
                                 cardType: .topRated,
                                 movies: result.results)
            }
    }
    
    func fetchUpcoming() -> Observable<HomeCards> {
        networkService.upcoming()
            .map { result -> HomeCards in
                return HomeCards(cardName: "UPCOMING",
                                 cardType: .upcoming,
                                 movies: result.results)
            }
    }
    
}
