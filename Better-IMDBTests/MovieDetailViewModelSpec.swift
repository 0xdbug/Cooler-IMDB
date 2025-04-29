//
//  MovieDetailViewModelSpec.swift
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

class MovieDetailViewModelSpec: QuickSpec {
    
    override class func spec() {
        func sampleMovieDetail(id: Int) -> MovieDetail {
            MovieDetail(adult: false, backdropPath: "/zb6fM1CX41D9rF9hdgclu0peUmy.jpg", budget: 22000000.0, homepage: "http://www.schindlerslist.com/", id: id, imdbId: "tt0108052", originalLanguage: "en", originalTitle: "Schindler\'s List", overview: "The true story of how businessman Oskar Schindler saved over a thousand Jewish lives from the Nazis while they worked as slaves in his factory during World War II.", popularity: 22.3843, posterPath: "/sF1U4EUQS8YHUYjNl3pMGNIQyr0.jpg", productionCountries: [Better_IMDB.MovieProduction(iso3166_1: "US", name: "United States of America")], releaseDate: "1993-12-15", revenue: 321365567, runtime: 195, status: "Released", tagline: "Whoever saves one life, saves the world entire.", title: "Schindler\'s List", video: false, voteAverage: 8.563, voteCount: 16346)
        }
        
        describe("MovieDetailViewModel") {
            var viewModel: MovieDetailViewModel!
            var mockNetworkService: MovieDetailNetworkServiceProtocolMock!
            
            context("when fetch succeeds") {
                beforeEach {
                    mockNetworkService = MovieDetailNetworkServiceProtocolMock()
                    viewModel = MovieDetailViewModel(networkService: mockNetworkService)
                }
                
                let movieDetailResponse = sampleMovieDetail(id: 100)
                
                beforeEach {
                    Given(mockNetworkService, .fetchMovie(withId: .value("100"), willReturn: .just(movieDetailResponse)))
                    viewModel.fetchMovie(withId: "100")
                    
                }
                
                it("should should call the network service with movie id") {
                    Verify(mockNetworkService, .fetchMovie(withId: .value("100")))
                }
                
                it("should update item with fetched detail") {
                    expect(viewModel.item.value).toEventually(equal(movieDetailResponse))
                }
            }
        }
    }
}
