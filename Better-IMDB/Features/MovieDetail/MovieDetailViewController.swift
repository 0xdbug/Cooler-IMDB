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

class MovieDetailViewController: UIViewController, Storyboarded {
    
    var selectedMovieId: Int!
    
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var detailContainerView: UIView!
    @IBOutlet weak var plotContainerView: UIView!
    
    @IBOutlet weak var bookmarkView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var valuePairStackView: UIStackView!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    
    let viewModel = MovieDetailViewModel(networkService: MovieDetailService())
    
    var dominantColor: BehaviorRelay<UIColor> = .init(value: .secondarySystemBackground)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        initialBookmarkState()
        viewModel.fetchMovie(withId: String(selectedMovieId))
    }
    
    func setupView() {
        headerImageView.layer.cornerRadius = 25
        headerImageView.clipsToBounds = true
        
        playView.layer.cornerRadius = 15
        
        titleContainerView.layer.cornerRadius = 25
        detailContainerView.layer.cornerRadius = 25
        plotContainerView.layer.cornerRadius = 25
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
    }
    
    func setupBindings() {
        viewModel.item.subscribe(onNext: { [weak self] movie in
            guard let self = self, let movie = movie else { return }
            
            // i think i can refactor this
            let year = movie.release_date.prefix(4)
            self.addValueLabelPair(value: String(year), type: "Year")
            self.addValueLabelPair(value: movie.production_countries.first!.name, type: "Country")
            
            let hours = movie.runtime / 60
            let minutes = movie.runtime % 60
            let timeString = "\(hours)h \(minutes)m"
            
            self.addValueLabelPair(value: timeString, type: "Time")
            self.viewModel.updateBookmarkState(for: movie.id)
            
            self.movieTitle.text = movie.title
            self.movieOverviewLabel.text = movie.overview
            
            Task {
                await self.setHeader(backdropImageUrl: movie.backdropImageURL)
            }
        }).disposed(by: disposeBag)
        
        
        dominantColor.subscribe(onNext: { [weak self] value in
            self!.playButton.tintColor = value
            self!.bookmarkButton.tintColor = .white
            self!.titleContainerView.backgroundColor = value
            
            self!.bookmarkView.isHidden = false
            self!.playView.isHidden = false
        }).disposed(by: disposeBag)
        
        viewModel.videoURL.subscribe(onNext: { [weak self] videoUrlString in
            guard let self = self else { return }
            
            if let urlString = videoUrlString, let url = URL(string: urlString) {
                self.playVideoWithURL(url)
            } else {
                print("nil video URL")
            }
        }).disposed(by: disposeBag)
        
        
        viewModel.bookmarkState
            .subscribe(onNext: { [weak self] isBookmarked in
                print(isBookmarked)
                self?.bookmarkButton.isSelected = isBookmarked
            })
            .disposed(by: disposeBag)

    }
    
    @IBAction func playVideo(_ sender: Any) {
        viewModel.fetchTrailer(withId: selectedMovieId)
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
    
    @IBAction func toggleBookmark(_ sender: Any) {
        viewModel.toggleBookmark(for: selectedMovieId)
    }
    
    func initialBookmarkState() {
        guard let movieId = viewModel.item.value?.id else { return }
        viewModel.updateBookmarkState(for: movieId)
    }
    
    func playVideoWithURL(_ url: URL) {
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
        
        // this wont do. its a yt video
        //        let player = AVPlayer(url: url)
        //        let playerViewController = AVPlayerViewController()
        //        playerViewController.player = player
        //
        //        present(playerViewController, animated: true) {
        //            player.play()
        //        }
    }
    
    
    // i brute forced this dont know if it should be done like this tbh
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            if let parentVC = navigationController?.viewControllers.last as? BookmarkViewController,
               let tabBarController = navigationController?.tabBarController as? BITabBarController {
                UIView.animate(withDuration: 0.25) {
                    tabBarController.biTabBar.alpha = 1
                    tabBarController.visualEffectView.alpha = 1
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isMovingToParent {
            if let tabBarController = navigationController?.tabBarController as? BITabBarController {
                UIView.animate(withDuration: 0.25) {
                    tabBarController.biTabBar.alpha = 0
                    tabBarController.visualEffectView.alpha = 0
                }
            }
        }
    }
    
}
