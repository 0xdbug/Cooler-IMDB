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
class HomeViewModel: ViewModel {
    weak var coordinator: HomeCoordinator?
    let networkService: TMDBNetworkServiceProtocol
    
    private let itemsRelay = BehaviorRelay<[HomeCards]>(value: [])
    var items: Driver<[HomeCards]> {
        return itemsRelay.asDriver()
    }
    
    init(networkService: TMDBNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchItems() {
        itemsRelay.accept([])
        
        startLoading()
        
        let categories: [MovieSection] = [.popular, .trending, .topRated, .upcoming]
        let categoryObservables = categories.map { fetchCategory($0) }
        
        Observable.concat(categoryObservables)
            .scan(into: [HomeCards]()) { (currentItems, newCard) in
                currentItems.append(newCard)
            }
            .do(onError: { [weak self] error in
                self?.stopLoading()
                self?.handleError(error)
            }, onCompleted: { [weak self] in
                self?.stopLoading()
            })
            .asDriver(onErrorJustReturn: [])
            .drive(itemsRelay)
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

// delegation
extension HomeViewModel: HomeViewControllerDelegate {
    func showList(_ card: HomeCards) {
        coordinator?.list(card)
    }
}
