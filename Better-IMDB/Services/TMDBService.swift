//
//  TMDBService.swift
//  Better-IMDB
//
//  Created by dbug on 4/8/25.
//

import UIKit
import RxSwift

class TMDBService: APIClient, HomeNetworkServiceProtocol {
    var baseURL: URL = URL(string: TMDBAPI.baseURLString)!
    var scheduler: any SchedulerType = MainScheduler.asyncInstance
    
    func discover() -> Observable<TMDBMovies> {
        let request = DiscoverRequest().request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    
    func popular() -> Observable<TMDBMovies> {
        let request = PopularRequest().request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    
    func trending() -> Observable<TMDBMovies> {
        let request = TrendingRequest().request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    
    func topRated() -> Observable<TMDBMovies> {
        let request = TopRatedRequest().request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    
    func upcoming() -> Observable<TMDBMovies> {
        let request = UpcomingRequest().request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    
}
