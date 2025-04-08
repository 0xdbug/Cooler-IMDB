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
    
    func discover() -> Observable<Discover> {
        let request = DiscoverRequest().request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(Discover.self, from: data)
            }
            .observe(on: scheduler)
    }
}
