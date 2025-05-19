//
//  BookmarkListCollectionViewCell.swift
//  Better-IMDB
//
//  Created by dbug on 4/11/25.
//

import UIKit
import RxSwift

class BookmarkListCollectionViewCell: UICollectionViewCell, PosterImageProvider {
    static let id = "bookmarkListMovieCell"
    
    private var viewModel: BookmarkListCollectionViewCellModelProtocol? {
        didSet {
            guard let viewModel else { return }
            self.movieTitle.text = viewModel.movieDetail.title
            bind(viewModel: viewModel)
        }
    }
    private var disposeBag = DisposeBag()
    
    lazy var posterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(viewModel: BookmarkListCollectionViewCellModelProtocol) {
        viewModel.posterImage.drive(onNext: { [weak self] image in
            self?.posterImage.image = image
        }).disposed(by: disposeBag)
    }
    
    private func setupViews() {
        contentView.addSubview(posterImage)
        contentView.addSubview(movieTitle)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            posterImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            posterImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            posterImage.heightAnchor.constraint(equalToConstant: 205),
            
            movieTitle.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 13),
            movieTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            movieTitle.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -20),
            movieTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func configure(with viewModel: BookmarkListCollectionViewCellModelProtocol) {
        self.viewModel = viewModel
        viewModel.loadPosterImage()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.text = ""
        posterImage.image = nil
        disposeBag = DisposeBag()
    }
}

