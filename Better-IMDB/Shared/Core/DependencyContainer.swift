//
//  DependencyContainer.swift
//  Better-IMDB
//
//  Created by dbug on 4/29/25.
//

import UIKit

class DependencyContainer {
    private var registry = [String: () -> Any]()
    
    static let shared = DependencyContainer()
//    
//    let tmdbService: TMDBNetworkServiceProtocol
//    let movieDetailService: MovieDetailNetworkServiceProtocol
//    let userDefaults: UserDefaultsProtocol
//    
    private init() {
//        self.tmdbService = TMDBService()
//        self.movieDetailService = MovieDetailService()
//        self.userDefaults = UserDefaults.standard
    }
//    
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        var instance: T?
        registry[key] = {
            if instance == nil {
                instance = factory()
            }
            return instance!
        }
    }
    
    func resolve<T>(_ type: T.Type) throws -> T {
        let key = String(describing: type)
        guard let factory = registry[key]?() as? T else {
            throw DependencyError.dependencyNotRegistered("No entry for \(T.self)")
        }
        return factory
    }
    
    func get<T>() -> T {
        do {
            return try resolve(T.self)
        } catch {
            fatalError("Failed to resolve \(T.self): \(error)")
        }
    }
}

extension DependencyContainer {
    static func register() {
        let container = DependencyContainer.shared
        
        container.register(TMDBNetworkServiceProtocol.self) { TMDBService() }
        container.register(MovieDetailNetworkServiceProtocol.self) { MovieDetailService() }
        
        container.register(TMDBRepositoryProtocol.self) {
            let tmdbService: TMDBNetworkServiceProtocol = container.get()
            let movieDetailService: MovieDetailNetworkServiceProtocol = container.get()
            return TMDBRepository(tmdbService: tmdbService, movieDetailService: movieDetailService)
        }
    }
}
