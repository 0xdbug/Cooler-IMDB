//
//  ListViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewModel {
    let networkService: TMDBNetworkServiceProtocol
    
    var items = BehaviorRelay<[Movie]>(value: [])
    private let disposeBag = DisposeBag()
    
    private var currentPage = 1
    private var totalPages = 1
    private var currentCategory: HomeCardCategory?
    var canLoadMore: Bool {
        return currentPage < totalPages
    }
    
    init(networkService: TMDBNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchItems(for category: HomeCardCategory) {
        currentPage = 1
        currentCategory = category
        items.accept([])
        
        fetchPage(for: category, page: currentPage)
            .subscribe(onNext: { [weak self] tmdbMovies in
                guard let self = self else { return }
                self.totalPages = tmdbMovies.total_pages
                self.items.accept(tmdbMovies.results)
            }, onError: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func loadMoreItems() {
        guard canLoadMore, let category = currentCategory else { return }
        
        currentPage += 1
        
        fetchPage(for: category, page: currentPage)
            .subscribe(onNext: { [weak self] tmdbMovies in
                guard let self = self else { return }
                let currentItems = self.items.value
                let newItems = currentItems + tmdbMovies.results
                self.items.accept(newItems)
            }, onError: { error in
                print(error)
                self.currentPage -= 1
            })
            .disposed(by: disposeBag)
    }
    
    private func fetchPage(for category: HomeCardCategory, page: Int) -> Observable<TMDBMovies> {
        switch category {
            case .popular:
                return networkService.popular(page: page)
            case .trending:
                return networkService.trending(page: page)
            case .topRated:
                return networkService.topRated(page: page)
            case .upcoming:
                return networkService.upcoming(page: page)
        }
    }
}
