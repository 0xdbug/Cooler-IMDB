//
//  HomeViewModelSpec.swift
//  Better-IMDB
//
//  Created by dbug on 4/27/25.
//

import XCTest
import Quick
import Nimble
import RxTest
import RxCocoa
import RxSwift
import SwiftyMocky
@testable import Better_IMDB

class HomeViewModelSpec: QuickSpec {
    override class func spec() {
        func sampleMovies(ids: [Int]) -> [Movie] {
            return ids.map { Movie(adult: false, backdropPath: "", genreIds: [11], id: $0, originalLanguage: "", originalTitle: "", overview: "", popularity: 11.0, posterPath: "", releaseDate: "", title: "", video: false, voteAverage: 10.0, voteCount: 10) }
        }
        
        func sampleTMDBResponse(page: Int, totalPages: Int, movies: [Movie]) -> TMDBMovies {
            return TMDBMovies(page: page, results: movies, totalPages: totalPages, totalResults: movies.count * totalPages)
        }
        
        describe("HomeViewModel") {
            var viewModel: HomeViewModel!
            var mockRepository: TMDBRepositoryProtocolMock!
            var disposeBag: DisposeBag!
            
            beforeEach {
                mockRepository = TMDBRepositoryProtocolMock()
                viewModel = HomeViewModel(repository: mockRepository)
                disposeBag = DisposeBag()
            }
            
            describe("fetchItems") {
                context("when fetch succeeds") {
                    let popularMovies = sampleMovies(ids: [1, 2])
                    let trendingMovies = sampleMovies(ids: [3, 4])
                    let topRatedMovies = sampleMovies(ids: [5, 6])
                    let upcomingMovies = sampleMovies(ids: [7, 8])
                    
                    let popularResponse = sampleTMDBResponse(page: 1, totalPages: 1, movies: popularMovies)
                    let trendingResponse = sampleTMDBResponse(page: 1, totalPages: 1, movies: trendingMovies)
                    let topRatedResponse = sampleTMDBResponse(page: 1, totalPages: 1, movies: topRatedMovies)
                    let upcomingResponse = sampleTMDBResponse(page: 1, totalPages: 1, movies: upcomingMovies)
                    
                    beforeEach {
                        Given(mockRepository, .getMoviesForSection(.value(.popular), page: .value(1), willReturn: .just(popularResponse)))
                        Given(mockRepository, .getMoviesForSection(.value(.trending), page: .value(1), willReturn: .just(trendingResponse)))
                        Given(mockRepository, .getMoviesForSection(.value(.topRated), page: .value(1), willReturn: .just(topRatedResponse)))
                        Given(mockRepository, .getMoviesForSection(.value(.upcoming), page: .value(1), willReturn: .just(upcomingResponse)))
                        
                        viewModel.fetchItems()
                    }
                    
                    it("should call for each section") {
                        Verify(mockRepository, 1, .getMoviesForSection(.value(.popular), page: .value(1)))
                        Verify(mockRepository, 1, .getMoviesForSection(.value(.trending), page: .value(1)))
                        Verify(mockRepository, 1, .getMoviesForSection(.value(.topRated), page: .value(1)))
                        Verify(mockRepository, 1, .getMoviesForSection(.value(.upcoming), page: .value(1)))
                    }
                    
                    it("should update items") {
                        var emits: [HomeCards]?
            
                        viewModel.items
                            .drive(onNext: { items in
                                emits = items
                            })
                            .disposed(by: disposeBag)
                        
                        expect(emits?.count).toEventually(equal(4))
                    }
                }
            }   
        }
    }
}
