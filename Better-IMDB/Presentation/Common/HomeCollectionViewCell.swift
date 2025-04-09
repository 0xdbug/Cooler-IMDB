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
    @IBOutlet weak var itemPosterImage: UIImageView!
        
    func setup() {
        allButton.titleLabel?.textColor = .white
        titleLabel.text = "TOP MOVIES"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        
//        itemPosterImage.clipsToBounds = true
        itemPosterImage.layer.cornerRadius = 30
        
        layer.cornerRadius = 30
    }
 
    func configureWithItem(_ item: DiscoverResult) async {
        setup()
        
        do {
            print(item.posterImageURL)
            try await cellPosterImage.loadImage(item.posterImageURL)
            itemPosterImage.image = cellPosterImage.image
            
            itemPosterImage.setShadowWithColor(color: .yellow, opacity: 0.9, offset: CGSize(width: 500, height: 500), radius: 100, viewCornerRadius: 30)
            
        } catch {
            print("Failed to load image")
        }
    }
    
    override func prepareForReuse() {
        backgroundColor = .secondarySystemBackground
        titleLabel.text = ""
    }
}
