//
//  ListViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewModel: ViewModel {
    weak var coordinator: HomeCoordinator?
    let networkService: TMDBNetworkServiceProtocol
    
    var items = BehaviorRelay<[Movie]>(value: [])
    
    private var currentPage = 1
    private var totalPages = 1
    //    private var currentCategory: HomeCardCategory? // more generic model
    private var currentSection: MovieSection? // more generic model
    var canLoadMore: Bool {
        return currentPage < totalPages
    }
    
    init(networkService: TMDBNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchItems(for section: MovieSection) {
        startLoading()
        currentPage = 1
        currentSection = section
        items.accept([])
        
        networkService.fetchMoviesForSection(section, page: currentPage)
            .subscribe(onNext: { [weak self] tmdbMovies in
                guard let self = self else { return }
                self.totalPages = tmdbMovies.total_pages
                self.items.accept(tmdbMovies.results)
            }, onError: { [weak self] error in
                self?.handleError(error)
                
            }, onCompleted: { [weak self] in
                self?.stopLoading()
                
            })
            .disposed(by: disposeBag)
    }
    
    func loadMoreItems() {
        guard canLoadMore, let section = currentSection else { return }
        currentPage += 1
        
        networkService.fetchMoviesForSection(section, page: currentPage)
            .subscribe(onNext: { [weak self] tmdbMovies in
                guard let self = self else { return }
                let currentItems = self.items.value
                let newItems = currentItems + tmdbMovies.results
                self.items.accept(newItems)
                
            }, onError: { [weak self] error in
                self?.currentPage -= 1
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
    }
    
    func showDetail(_ movie: Movie, from listViewController: ListViewController, at indexPath: IndexPath) {
        coordinator?.showDetail(movie, from: listViewController, at: indexPath)
    }
    
}
