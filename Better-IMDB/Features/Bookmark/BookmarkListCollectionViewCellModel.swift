//
//  BookmarkListCollectionViewCellModel.swift
//  Better-IMDB
//
//  Created by dbug on 5/3/25.
//

import UIKit
import RxSwift
import RxCocoa
import Nuke

protocol BookmarkListCollectionViewCellModelProtocol {
    var movieDetail: MovieDetail { get }
    var posterImage: Driver<UIImage> { get }
    func loadPosterImage()
}

class BookmarkListCollectionViewCellModel: ViewModel, BookmarkListCollectionViewCellModelProtocol {
    let movieDetail: MovieDetail
    private let posterImageRelay = BehaviorRelay<UIImage>(value: UIImage())
    
    var posterImage: Driver<UIImage> {
        posterImageRelay.asDriver()
    }
    
    init(movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
    }
    
    func loadPosterImage() {
        self.startLoading()
        
        Task {
            do {
                let image = try await ImagePipeline.shared.image(for: movieDetail.posterImageURL)
                
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
