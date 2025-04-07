//
//  APIClient.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import Foundation
import RxSwift
import RxCocoa

class APIClient {
    private let baseURL = URL(string: TMDBAPI.baseURLString)!

    func send<T: Codable>(apiRequest: APIRequest) -> Observable<T> {
        let request = apiRequest.request(with: baseURL)
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(T.self, from: data)
            }
            .observe(on: MainScheduler.asyncInstance)
    }
    
    func discover<T: Codable>() -> Observable<T> {
        let request = DiscoverRequest().request(with: baseURL)
        
        return URLSession.shared.rx.data(request: request)
            .map { data in
                try JSONDecoder().decode(T.self, from: data)
            }
            .observe(on: MainScheduler.asyncInstance)
    }
    
}
