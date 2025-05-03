//
//  HomeCollectionViewCellModel.swift
//  Better-IMDB
//
//  Created by dbug on 5/3/25.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

protocol HomeCollectionViewCellModelProtocol {
    var item: HomeCards! { get }
    var posters: Driver<[UIImage]> { get }
    func loadPosters()
}

class HomeCollectionViewCellModel: ViewModel, HomeCollectionViewCellModelProtocol {
    
    let item: HomeCards!
    private let movies: [Movie]
    private let postersRelay = BehaviorRelay<[UIImage]>(value: [])
    
    var posters: Driver<[UIImage]> {
        postersRelay.asDriver()
    }
    
    init(item: HomeCards) {
        self.item = item
        self.movies = item.movies
    }
    
    func loadPosters() {
        guard movies.count >= 2 else {
            postersRelay.accept([])
            return
        }
        
        self.startLoading()
        
        Task {
            do {
                let firstPoster = movies.first!.posterImageURL
                let secondPoster = movies[1].posterImageURL
                
                let firstImage = try await ImagePipeline.shared.image(for: firstPoster)
                let secondImage = try await ImagePipeline.shared.image(for: secondPoster)
                
                self.postersRelay.accept([firstImage, secondImage])
                self.stopLoading()
                
            } catch {
                self.stopLoading()
                handleError(error)
                print("Failed to load image")
            }
        }
        
    }
}
