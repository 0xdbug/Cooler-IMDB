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
        return self.request(request)
    }
    
    func fetchMovies(ids: [Int]) -> Observable<[MovieDetail]> {
        let observables = ids.map { id -> Observable<MovieDetail> in
            let request = MovieDetailRequest(id: "\(id)").request(with: baseURL)
            return self.request(request)
        }
        
        return Observable.merge(observables)
            .toArray()
            .asObservable()
    }
    
    private func request<T: Decodable>(_ urlRequest: URLRequest) -> Observable<T> {
        return urlSession.rx.response(request: urlRequest)
            .map { (response, data) in
                
                if response.statusCode != 200 {
                    if let errorResponse = try? JSONDecoder().decode(TMDBErrorResponse.self, from: data) {
                        if let statusMessage = errorResponse.statusMessage {
                            throw TMDBError.apiError(
                                statusCode: errorResponse.statusCode ?? response.statusCode,
                                message: statusMessage
                            )
                        }
                    }
                }
                
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                } catch let decodingError {
                    print(decodingError)
//                    throw TMDBError.decodingError(decodingError)
                    // its nicer to show unkown error to use than decoding error
                    // could add a flag for debug and production
                    throw TMDBError.unknown
                }
            }
            .observe(on: scheduler)
    }
}
