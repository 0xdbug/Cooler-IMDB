//
//  HomeCollectionViewCell.swift
//  Better-IMDB
//
//  Created by dbug on 4/9/25.
//

import UIKit

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
        allButton.titleLabel?.textColor = .white
        titleLabel.text = "TOP MOVIES"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        layer.cornerRadius = 30
        
        addSubview(posterStackView)
        
        posterStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview().offset(25)
        }
    }
    
    func configureWithItem(_ item: DiscoverResult) async {
        setup()
        
        do {
            try await cellPosterImage.loadImage(item.posterImageURL)
            posterStackView.updatePosters(sampleImages)
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
