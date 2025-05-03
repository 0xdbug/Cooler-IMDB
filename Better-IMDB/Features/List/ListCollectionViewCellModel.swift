//
//  ListCollectionViewCellModel.swift
//  Better-IMDB
//
//  Created by dbug on 5/3/25.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

protocol ListCollectionViewCellModelProtocol {
    var movie: Movie { get }
    var posterImage: Driver<UIImage> { get }
    func loadPosterImage()
}

class ListCollectionViewCellModel: ViewModel, ListCollectionViewCellModelProtocol {
    let movie: Movie
    private let posterImageRelay = BehaviorRelay<UIImage>(value: UIImage())
    
    var posterImage: Driver<UIImage> {
        posterImageRelay.asDriver()
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func loadPosterImage() {
        self.startLoading()
        
        Task {
            do {
                let image = try await ImagePipeline.shared.image(for: movie.posterImageURL)
                
                self.posterImageRelay.accept(image)
                self.stopLoading()
                
            } catch {
                self.stopLoading()
                handleError(error)
                print("Failed to load image")
            }
        }
        
    }
}
