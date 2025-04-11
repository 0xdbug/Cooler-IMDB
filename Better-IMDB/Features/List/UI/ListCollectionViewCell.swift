//
//  ListCollectionViewCell.swift
//  Better-IMDB
//
//  Created by dbug on 4/11/25.
//

import UIKit
import Nuke

class ListCollectionViewCell: UICollectionViewCell {
    static let id = "listMovieCell"
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    func setup() {
        posterImage.layer.cornerRadius = 20
    }
    
    func configureWithMovie(_ movie: Movie) async {
        setup()
        movieTitle.text = movie.title
        do {
            try await self.posterImage.loadImage(movie.posterImageURL)
            
        } catch {
            print("Failed to load image")
        }
    }
    
    override func prepareForReuse() {
        movieTitle.text = ""
        posterImage.image = UIImage()
    }

}
