//
//  TMDBService.swift
//  Better-IMDB
//
//  Created by dbug on 4/8/25.
//

import UIKit
import RxSwift

// sourcery: AutoMockable
protocol TMDBNetworkServiceProtocol {
    func fetchMoviesForSection(_ section: MovieSection, page: Int) -> Observable<TMDBMovies>
    func fetchMovies(ids: [Int]) -> Observable<[MovieDetail]>
}

class TMDBService: APIClient, TMDBNetworkServiceProtocol {
    
    var baseURL: URL
    var scheduler: any SchedulerType
    var urlSession: URLSession
    
    init(
        baseURL: URL = URL(string: TMDBAPI.baseURLString)!,
        scheduler: any SchedulerType = MainScheduler.asyncInstance,
        urlSession: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.scheduler = scheduler
        self.urlSession = urlSession
    }
    
    func fetchMoviesForSection(_ section: MovieSection, page: Int = 1) -> Observable<TMDBMovies> {
        let request = SectionRequest(path: TMDBAPI.moviesForSection(section), page: page).request(with: baseURL)
        
        return urlSession.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    
    func fetchMovies(ids: [Int]) -> Observable<[MovieDetail]> {
        print(ids)
        let requests = ids.map { id -> Observable<MovieDetail> in
            let request = MovieDetailRequest(id: "\(id)").request(with: baseURL)
            
            return urlSession.rx.data(request: request)
                .map { data in
                    try JSONDecoder().decode(MovieDetail.self, from: data)
                }
        }
        
        return Observable.merge(requests)
            .toArray()
            .asObservable()
    }
}
