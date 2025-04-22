//
//  HomeCollectionViewCell.swift
//  Better-IMDB
//
//  Created by dbug on 4/9/25.
//

import UIKit
import Nuke

class HomeCollectionViewCell: UICollectionViewCell {
    static let id = "homeMainCell"
    
    @IBOutlet weak var titleStack: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var cellPosterImage: UIImageView!
    
    var item: HomeCards!
    
    let posterStackView = MultiplePosterView(frame: .zero)
    
    func configureWithItem(_ item: HomeCards) async {
        self.item = item
        setupCard()
        await setupPosters()
    }
    
    func setupCard() {
        addSubview(posterStackView)
        
        posterStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            posterStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 25)
        ])

        titleLabel.text = item.cardName
        allButton.titleLabel?.textColor = .white
        titleLabel.font = .systemFont(ofSize: 25, weight: .heavy)
        layer.cornerRadius = 30
    }
    
    // remove logic
    func setupPosters() async {
        guard item.movies.count >= 2 else { return }
        let firstPoster = item.movies.first!.posterImageURL
        let secondPoster = item.movies[1].posterImageURL
        
        do {
            try await cellPosterImage.loadImage(firstPoster)
            let secondPosterImage = try await ImagePipeline.shared.image(for: secondPoster)
            
            posterStackView.updatePosters([cellPosterImage.image!, secondPosterImage])
        } catch {
            print("Failed to load image")
        }
        
    }
    
    override func prepareForReuse() {
        item = .none
        backgroundColor = .secondarySystemBackground
        titleLabel.text = ""
    }
}
