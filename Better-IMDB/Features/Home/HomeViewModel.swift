//
//  HomeViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

enum HomeCardCategory {
    case popular
    case trending
    case topRated
    case upcoming
}

class HomeViewModel {
    let networkService: TMDBNetworkServiceProtocol
    
    private let disposeBag = DisposeBag()
    var items: BehaviorRelay<[HomeCards]> = .init(value: [])
    
    init(networkService: TMDBNetworkServiceProtocol) {
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
        networkService.popular(page: 1)
            .map { result -> HomeCards in
                return HomeCards(cardName: "POPULAR",
                                 cardType: .popular,
                                 movies: result.results)
            }
    }
    
    func fetchTrending() -> Observable<HomeCards> {
        networkService.trending(page: 1)
            .map { result -> HomeCards in
                return HomeCards(cardName: "TRENDING",
                                 cardType: .trending,
                                 movies: result.results)
            }
    }
    
    func fetchTopRated() -> Observable<HomeCards> {
        networkService.topRated(page: 1)
            .map { result -> HomeCards in
                return HomeCards(cardName: "TOP RATED",
                                 cardType: .topRated,
                                 movies: result.results)
            }
    }
    
    func fetchUpcoming() -> Observable<HomeCards> {
        networkService.upcoming(page: 1)
            .map { result -> HomeCards in
                return HomeCards(cardName: "UPCOMING",
                                 cardType: .upcoming,
                                 movies: result.results)
            }
    }
    
}
