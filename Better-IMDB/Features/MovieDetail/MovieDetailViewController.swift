//
//  MovieDetailViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import UIKit
import RxSwift
import RxCocoa
import SafariServices

class MovieDetailViewController: ViewController {
    private var viewModel: MovieDetailViewModelProtocol?
    
    // MARK: - Properties
    var selectedMovieId: Int!
    private var dominantColor: BehaviorRelay<UIColor> = .init(value: .secondarySystemBackground)

    
    // MARK: - UI Components
    private lazy var headerContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "baseline.jpeg")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var playView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(playVideo), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        button.addTarget(self, action: #selector(toggleBookmark), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var movieTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var valuePairStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var plotContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 25
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var movieOverviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: MovieDetailViewModelProtocol? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupBindings()
        initialBookmarkState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isMovingToParent {
            if let tabBarController = navigationController?.tabBarController as? BITabBarController {
                UIView.animate(withDuration: 0.25) {
                    tabBarController.biTabBar.alpha = 0
                    tabBarController.visualEffectView.alpha = 0
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            if let _ = navigationController?.viewControllers.last as? BookmarkViewController,
               let tabBarController = navigationController?.tabBarController as? BITabBarController {
                UIView.animate(withDuration: 0.25) {
                    tabBarController.biTabBar.alpha = 1
                    tabBarController.visualEffectView.alpha = 1
                }
            }
        }
    }
    
    // MARK: - Setup Methods
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(headerContainer)
        headerContainer.addSubview(headerImageView)
        headerContainer.addSubview(playView)
        playView.addSubview(playButton)
        headerContainer.addSubview(bookmarkButton)
        
        view.addSubview(titleContainerView)
        titleContainerView.addSubview(movieTitle)
        
        view.addSubview(detailContainerView)
        detailContainerView.addSubview(valuePairStackView)
        
        view.addSubview(plotContainerView)
        plotContainerView.addSubview(movieOverviewLabel)
    }
    
    private func setupBindings() {
        viewModel?.fetchMovie(withId: String(selectedMovieId))
        viewModel?.item.subscribe(onNext: { [weak self] movie in
            guard let self = self, let movie = movie else { return }
            
            let year = movie.releaseDate.prefix(4)
            self.addValueLabelPair(value: String(year), type: "Year")
            self.addValueLabelPair(value: movie.productionCountries.first!.name, type: "Country")
            
            let hours = movie.runtime / 60
            let minutes = movie.runtime % 60
            let timeString = "\(hours)h \(minutes)m"
            
            self.addValueLabelPair(value: timeString, type: "Time")
            viewModel?.updateBookmarkState(for: movie.id)
            
            self.movieTitle.text = movie.title
            self.movieOverviewLabel.text = movie.overview
            
            Task {
                await self.setHeader(backdropImageUrl: movie.backdropImageURL)
            }
        }).disposed(by: disposeBag)
        
        dominantColor.subscribe(onNext: { [weak self] value in
            guard let self = self else { return }
            self.playButton.tintColor = value
            self.bookmarkButton.tintColor = .white
            self.titleContainerView.backgroundColor = value
            
            self.playView.isHidden = false
        }).disposed(by: disposeBag)
        
        viewModel?.videoURL.subscribe(onNext: { [weak self] videoUrlString in
            guard let self = self else { return }
            
            if let urlString = videoUrlString, let url = URL(string: urlString) {
                self.playVideoWithURL(url)
            } else {
                print("nil video URL")
            }
        }).disposed(by: disposeBag)
        
        viewModel?.bookmarkState
            .subscribe(onNext: { [weak self] isBookmarked in
                print(isBookmarked)
                self?.bookmarkButton.isSelected = isBookmarked
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func playVideo() {
        viewModel?.fetchTrailer(withId: selectedMovieId)
    }
    
    @objc private func toggleBookmark() {
        viewModel?.toggleBookmark(for: selectedMovieId)
    }
    
    func setHeader(backdropImageUrl: URL) async {
        do {
            try await headerImageView.loadImage(backdropImageUrl)
            self.dominantColor.accept(headerImageView.image!.dominantColor()!)
        } catch {
            print("error loading image")
        }
    }
    
    func addValueLabelPair(value: String, type: String) {
        let pair = ValueLabelPair(value: value, type: type)
        valuePairStackView.addArrangedSubview(pair)
    }
    
    func initialBookmarkState() {
        guard let movieId = viewModel?.item.value?.id else { return }
        viewModel?.updateBookmarkState(for: movieId)
    }
    
    func playVideoWithURL(_ url: URL) {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
     
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 11),
            headerContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 11),
            headerContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -11),
            headerContainer.heightAnchor.constraint(equalToConstant: 216),
            
            headerImageView.topAnchor.constraint(equalTo: headerContainer.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -5),
            headerImageView.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 2),
            
            playView.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -24),
            playView.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: -8),
            playView.widthAnchor.constraint(equalToConstant: 45),
            playView.heightAnchor.constraint(equalToConstant: 46),
            
            playButton.topAnchor.constraint(equalTo: playView.topAnchor, constant: 5),
            playButton.leadingAnchor.constraint(equalTo: playView.leadingAnchor, constant: 7),
            playButton.trailingAnchor.constraint(equalTo: playView.trailingAnchor, constant: -7),
            playButton.bottomAnchor.constraint(equalTo: playView.bottomAnchor, constant: -6),
            
            bookmarkButton.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 8),
            bookmarkButton.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -24),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 45),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 46),
            
            titleContainerView.topAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: 8),
            titleContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            titleContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            titleContainerView.heightAnchor.constraint(equalToConstant: 68),
            
            movieTitle.topAnchor.constraint(equalTo: titleContainerView.topAnchor, constant: 14),
            movieTitle.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor, constant: 8),
            movieTitle.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor, constant: -8),
            movieTitle.heightAnchor.constraint(equalToConstant: 40),
            
            detailContainerView.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor, constant: 8),
            detailContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            detailContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            detailContainerView.heightAnchor.constraint(equalToConstant: 114),
            
            valuePairStackView.topAnchor.constraint(equalTo: detailContainerView.topAnchor, constant: 27),
            valuePairStackView.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor, constant: 8),
            valuePairStackView.trailingAnchor.constraint(equalTo: detailContainerView.trailingAnchor, constant: -15),
            valuePairStackView.bottomAnchor.constraint(equalTo: detailContainerView.bottomAnchor, constant: -27),
            
            plotContainerView.topAnchor.constraint(equalTo: detailContainerView.bottomAnchor, constant: 8),
            plotContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            plotContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            plotContainerView.heightAnchor.constraint(equalToConstant: 235),
            
            movieOverviewLabel.heightAnchor.constraint(equalTo: plotContainerView.heightAnchor, constant: -50),
            movieOverviewLabel.topAnchor.constraint(equalTo: plotContainerView.topAnchor, constant: 14),
            movieOverviewLabel.leadingAnchor.constraint(equalTo: plotContainerView.leadingAnchor, constant: 24),
            movieOverviewLabel.trailingAnchor.constraint(equalTo: plotContainerView.trailingAnchor, constant: -24),
        ])
    }
}
