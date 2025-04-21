//
//  HomeViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa


// improve solid
// remove strong reference
class HomeViewModel { // use delegation, remove depandacny cycle
    let networkService: TMDBNetworkServiceProtocol
    
    private let disposeBag = DisposeBag()
    var items: BehaviorRelay<[HomeCards]> = .init(value: []) // use driver
    
    init(networkService: TMDBNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchItems() {
        items.accept([])
        
        let categories: [MovieSection] = [.popular, .trending, .topRated, .upcoming]
        let categoryObservables = categories.map { fetchCategory($0) }
        
        Observable.concat(categoryObservables)
            .scan(into: [HomeCards]()) { (currentItems, newCard) in
                currentItems.append(newCard)
            }
            .asDriver(onErrorJustReturn: [])
            .drive(items)
            .disposed(by: disposeBag)
    }
    
    private func fetchCategory(_ section: MovieSection) -> Observable<HomeCards> {
        return networkService.fetchMoviesForSection(section, page: 1)
            .map { result -> HomeCards in
                return HomeCards(cardName: section.rawValue
                    .replacingOccurrences(of: "_", with: " ")
                    .uppercased(),
                                 cardType: section,
                                 movies: result.results)
            }
    }
    
}
