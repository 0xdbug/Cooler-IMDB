//
//  DependencyContainer.swift
//  Better-IMDB
//
//  Created by dbug on 4/29/25.
//

import UIKit

class DependencyContainer {
    static let shared = DependencyContainer()
    
    let tmdbService: TMDBNetworkServiceProtocol
    let movieDetailService: MovieDetailNetworkServiceProtocol
    let userDefaults: UserDefaultsProtocol
    
    private init() {
        self.tmdbService = TMDBService()
        self.movieDetailService = MovieDetailService()
        self.userDefaults = UserDefaults.standard
    }
}
