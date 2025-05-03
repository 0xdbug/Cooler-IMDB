//
//  TMDBRepository.swift
//  Better-IMDB
//
//  Created by dbug on 5/3/25.
//

import RxSwift

// sourcery: AutoMockable 
protocol TMDBRepositoryProtocol {
    func getMoviesForSection(_ section: MovieSection, page: Int) -> Observable<TMDBMovies>
    func getMovieDetail(id: String) -> Observable<MovieDetail>
    func getMovieVideoURL(id: Int) -> Observable<String>
    func getMovies(ids: [Int]) -> Observable<[MovieDetail]>
}

class TMDBRepository: TMDBRepositoryProtocol {
    private let tmdbService: TMDBNetworkServiceProtocol
    private let movieDetailService: MovieDetailNetworkServiceProtocol
    
    init(tmdbService: TMDBNetworkServiceProtocol, movieDetailService: MovieDetailNetworkServiceProtocol) {
        self.tmdbService = tmdbService
        self.movieDetailService = movieDetailService
    }
    
    func getMoviesForSection(_ section: MovieSection, page: Int) -> Observable<TMDBMovies> {
        return tmdbService.fetchMoviesForSection(section, page: page)
    }
    
    func getMovieDetail(id: String) -> Observable<MovieDetail> {
        return movieDetailService.fetchMovie(withId: id)
    }
    
    func getMovieVideoURL(id: Int) -> Observable<String> {
        return movieDetailService.fetchVideoURLString(withId: id)
    }
    
    func getMovies(ids: [Int]) -> Observable<[MovieDetail]> {
        return tmdbService.fetchMovies(ids: ids)
    }
}

