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
    
    let sampleImages = [
        UIImage(named: "minecraft")!,
        UIImage(named: "minecraft")!,
    ]
    
    let posterStackView = MultiplePosterView(frame: .zero)

    
    func setup() {
        addSubview(posterStackView)
        
        posterStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview().offset(25)
        }
    }
    
    func configureWithItem(_ item: HomeCards) async {
        setup()
        titleLabel.text = item.cardName
        allButton.titleLabel?.textColor = .white
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        layer.cornerRadius = 30
        
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
        setupPosters()
        
    }
    
    func setupPosters() {
        //        itemPosterImage.image = cellPosterImage.image
        //        itemPosterImage.layer.cornerRadius = 30
        
    }
    
    override func prepareForReuse() {
        backgroundColor = .secondarySystemBackground
        titleLabel.text = ""
    }
}
