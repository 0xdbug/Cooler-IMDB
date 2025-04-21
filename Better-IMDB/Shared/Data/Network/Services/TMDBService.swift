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

// not testabl
class TMDBService: APIClient, TMDBNetworkServiceProtocol {
    
    var baseURL: URL = URL(string: TMDBAPI.baseURLString)!
    var scheduler: any SchedulerType = MainScheduler.asyncInstance
    
    func fetchMoviesForSection(_ section: MovieSection, page: Int = 1) -> Observable<TMDBMovies> {
        let request = SectionRequest(path: TMDBAPI.moviesForSection(section), page: page).request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    

    // todo
    func fetchMovies(ids: [Int]) -> Observable<[MovieDetail]> {
        print(ids)
        let requests = ids.map { id -> Observable<MovieDetail> in
            let request = MovieDetailRequest(id: "\(id)").request(with: baseURL)
            
            return URLSession.shared.rx.data(request: request)
                .map { data in
                    try JSONDecoder().decode(MovieDetail.self, from: data)
                }
        }
        
        return Observable.merge(requests)
            .toArray()
            .asObservable()
    }
    
}
