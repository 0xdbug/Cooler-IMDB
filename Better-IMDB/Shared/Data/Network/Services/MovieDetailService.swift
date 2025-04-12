//
//  MovieDetailService.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import UIKit
import RxSwift

// sourcery: AutoMockable
protocol MovieDetailNetworkServiceProtocol {
    func fetchMovie(withId id: String) -> Observable<MovieDetail>
}

class MovieDetailService: APIClient, MovieDetailNetworkServiceProtocol {
    var baseURL: URL = URL(string: TMDBAPI.baseURLString)!
    var scheduler: any SchedulerType = MainScheduler.asyncInstance
    
    func fetchMovie(withId id: String) -> Observable<MovieDetail> {
        let request = MovieDetailRequest(id: id).request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(MovieDetail.self, from: data)
            }
            .observe(on: scheduler)
    }
    
}

