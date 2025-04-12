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
    func popular(page: Int) -> Observable<TMDBMovies>
    func trending(page: Int) -> Observable<TMDBMovies>
    func topRated(page: Int) -> Observable<TMDBMovies>
    func upcoming(page: Int) -> Observable<TMDBMovies>
}

class TMDBService: APIClient, TMDBNetworkServiceProtocol {
    
    var baseURL: URL = URL(string: TMDBAPI.baseURLString)!
    var scheduler: any SchedulerType = MainScheduler.asyncInstance
    
    func discover(page: Int = 1) -> Observable<TMDBMovies> {
        let request = DiscoverRequest(page: page).request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    
    func popular(page: Int = 1) -> Observable<TMDBMovies> {
        let request = PopularRequest(page: page).request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    
    func trending(page: Int = 1) -> Observable<TMDBMovies> {
        let request = TrendingRequest(page: page).request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    
    func topRated(page: Int = 1) -> Observable<TMDBMovies> {
        let request = TopRatedRequest(page: page).request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    
    func upcoming(page: Int = 1) -> Observable<TMDBMovies> {
        let request = UpcomingRequest(page: page).request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(TMDBMovies.self, from: data)
            }
            .observe(on: scheduler)
    }
    
}
