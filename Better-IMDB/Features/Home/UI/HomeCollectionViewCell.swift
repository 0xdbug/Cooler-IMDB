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
    
    // i like setupViews clean
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private lazy var allButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        
        var configuration = UIButton.Configuration.gray()
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 10)
            return outgoing
        }
        
        button.configuration = configuration
        button.isHidden = true
        return button
    }()
    
    private lazy var titleStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, allButton])
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        return stack
    }()
    
    private lazy var visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let view = UIVisualEffectView(effect: blurEffect)
        view.tintColor = UIColor(.accentColor)
        return view
    }()

    private lazy var cellPosterImage: UIImageView = {
        let imageview = UIImageView()
        imageview.clipsToBounds = true
        imageview.contentMode = .scaleAspectFill
        return imageview
    }()
    private lazy var contentContainer: UIView = UIView()
    
    var item: HomeCards!
    
    let posterStackView = MultiplePosterView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        layer.cornerRadius = 30
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
        backgroundColor = .secondarySystemBackground
        
        contentView.addSubview(contentContainer)
        contentContainer.addSubview(cellPosterImage)
        contentContainer.addSubview(visualEffectView)
        contentContainer.addSubview(titleStack)
        
        [contentContainer, cellPosterImage, visualEffectView, titleStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    
    private func setupConstraints() {
        contentContainer.pin(to: contentView)
        
        NSLayoutConstraint.activate([
            cellPosterImage.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: -106),
            cellPosterImage.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: -32),
            cellPosterImage.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: 41),
            cellPosterImage.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor, constant: 182)
        ])
        
        visualEffectView.pin(to: contentContainer)
        
        NSLayoutConstraint.activate([
            allButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            titleStack.topAnchor.constraint(equalTo: contentContainer.topAnchor, constant: 35),
            titleStack.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor, constant: 29),
            titleStack.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor, constant: -29),
            titleStack.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
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
    }
    
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
        super.prepareForReuse()
        item = .none
        backgroundColor = .secondarySystemBackground
        titleLabel.text = ""
    }
}
