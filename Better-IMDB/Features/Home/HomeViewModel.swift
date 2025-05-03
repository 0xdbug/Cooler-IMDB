//
//  HomeViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa


protocol HomeViewModelProtocol: AnyObject {
    var items: Driver<[HomeCards]> { get }
    func fetchItems()
    func fetchCategory(_ section: MovieSection) -> Observable<HomeCards>
    func showList(_ section: MovieSection)
}

class HomeViewModel: ViewModel, HomeViewModelProtocol {
    weak var coordinator: HomeCoordinator?
    private let repository: TMDBRepositoryProtocol
    
    private let itemsRelay = BehaviorRelay<[HomeCards]>(value: [])
    var items: Driver<[HomeCards]> {
        return itemsRelay.asDriver()
    }
    
    init(repository: TMDBRepositoryProtocol) {
        self.repository = repository
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
    
    func fetchCategory(_ section: MovieSection) -> Observable<HomeCards> {
        return repository.getMoviesForSection(section, page: 1)
            .map { result -> HomeCards in
                return HomeCards(name: section.rawValue
                    .replacingOccurrences(of: "_", with: " ")
                    .uppercased(),
                                 section: section,
                                 movies: result.results)
            }
    }
}

extension HomeViewModel {
    func showList(_ section: MovieSection) {
        coordinator?.list(section)
    }
}

// delegation
//extension HomeViewModel: HomeViewControllerDelegate {
//    func showList(_ section: MovieSection) {
//        coordinator?.list(section)
//    }
//}
