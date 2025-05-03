//
//  MovieDetailViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import UIKit
import RxSwift
import RxCocoa

//
class MovieDetailViewModel: ViewModel {
    let repository: TMDBRepositoryProtocol
    
    var item: BehaviorRelay<MovieDetail?> = .init(value: nil)
    var videoURL: BehaviorRelay<String?> = .init(value: nil)
    var bookmarkState: BehaviorRelay<Bool> = .init(value: false)
    
    private var currentPage = 1
    private var totalPages = 1
    private var currentSection: MovieSection?
    
    init(repository: TMDBRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchMovie(withId id: String) {
        repository.getMovieDetail(id: id)
            .subscribe(onNext: { [weak self] movie in
                guard let self = self else { return }
                self.item.accept(movie)
            }, onError: { [weak self] error in
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchTrailer(withId id: Int) {
        repository.getMovieVideoURL(id: id)
            .subscribe(onNext: { [weak self] urlString in
                guard let self = self else { return }
                videoURL.accept(urlString)
            }, onError: { [weak self] error in
                self?.handleError(error)
            })
            .disposed(by: disposeBag)
    }
    
    func toggleBookmark(for id: Int) {
        let isNowBookmarked = MoviePersistence(movieId: id).toggleBookmark()
        bookmarkState.accept(isNowBookmarked)
    }
    
    func updateBookmarkState(for id: Int) {
        let isBookmarked = MoviePersistence(movieId: id).isBookmarked()
        bookmarkState.accept(isBookmarked)
    }
    
}
