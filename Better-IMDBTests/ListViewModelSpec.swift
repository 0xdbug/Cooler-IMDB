//
//  ListSpec.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import XCTest
import Quick
import Nimble
import RxTest
import RxCocoa
import RxSwift
import SwiftyMocky
@testable import Better_IMDB

class ListViewModelSpec: QuickSpec {
    
    override class func spec() {
        func sampleMovies(ids: [Int]) -> [Movie] {
            return ids.map { Movie(adult: false, backdropPath: "", genreIds: [11], id: $0, originalLanguage: "", originalTitle: "", overview: "", popularity: 11.0, posterPath: "", releaseDate: "", title: "", video: false, voteAverage: 10.0, voteCount: 10) }
        }
        
        func sampleTMDBResponse(page: Int, totalPages: Int, movies: [Movie]) -> TMDBMovies {
            return TMDBMovies(page: page, results: movies, totalPages: totalPages, totalResults: movies.count * totalPages)
        }
        
        describe("ListViewModel") {
            var viewModel: ListViewModel!
            var mockNetworkService: TMDBNetworkServiceProtocolMock!
            var disposeBag: DisposeBag!
            
            beforeEach {
                mockNetworkService = TMDBNetworkServiceProtocolMock()
                viewModel = ListViewModel(networkService: mockNetworkService)
                disposeBag = DisposeBag()
            }

            
            describe("loading more items") {
                let section = MovieSection.popular
                let page1Movies = sampleMovies(ids: [1, 2])
                let responsePage1 = sampleTMDBResponse(page: 1, totalPages: 2, movies: page1Movies)
                let responsePage2 = sampleTMDBResponse(page: 2, totalPages: 2, movies: [])
                
                context("when more pages exist") {
                    it("should call network service with new page number") {
                        Given(mockNetworkService, .fetchMoviesForSection(.value(section), page: .value(1), willReturn: .just(responsePage1)))
                        viewModel.fetchItems(for: section)
                        
                        Given(mockNetworkService, .fetchMoviesForSection(.value(section), page: .value(2), willReturn: .just(responsePage2)))
                        viewModel.loadMoreItems()
                        
                        Verify(mockNetworkService, 1, .fetchMoviesForSection(.value(.popular), page: .value(1)))
                        Verify(mockNetworkService, 1, .fetchMoviesForSection(.value(.popular), page: .value(2)))
                    }
                }
            }
            
            describe("fetching items") {
                let section = MovieSection.popular
                let page1Movies = sampleMovies(ids: [1, 2])
                let responsePage1 = sampleTMDBResponse(page: 1, totalPages: 3, movies: page1Movies)
                
                context("when fetch succeeds") {
                    beforeEach {
                        Given(mockNetworkService, .fetchMoviesForSection(.value(section), page: .any, willReturn: .just(responsePage1)))
                        Given(mockNetworkService, .fetchMoviesForSection(.value(.trending), page: .any, willReturn: .empty()))
                        
                        viewModel.fetchItems(for: section)
                    }
                    
                    it("should call the correct network service method with page 1") {
                        Verify(mockNetworkService, 1, .fetchMoviesForSection(.value(section), page: .value(1)))
                        Verify(mockNetworkService, 0, .fetchMoviesForSection(.value(.trending), page: .any))
                    }
                    
                    it("should update items with the fetched movies") {

                        var items: [Movie]?
                        
                        viewModel.items
                            .drive(onNext: { movies in
                                items = movies
                            })
                            .disposed(by: disposeBag)
                                                
                        expect(items).toEventually(equal(page1Movies))
                    }
                }
            }
        }
    }
}
