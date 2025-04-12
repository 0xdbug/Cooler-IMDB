//
//  MovieDetailViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import UIKit
import RxSwift
import RxCocoa

class MovieDetailViewController: UIViewController, Storyboarded {
    
    var selectedMovie: Movie!
    
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var titleContainerView: UIView!
    @IBOutlet weak var detailContainerView: UIView!
    @IBOutlet weak var plotContainerView: UIView!
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var valuePairStackView: UIStackView!
    
    let viewModel = MovieDetailViewModel(networkService: MovieDetailService())
    
    var dominantColor: BehaviorRelay<UIColor> = .init(value: .secondarySystemBackground)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupBindings()
        viewModel.fetchMovie(withId: "\(selectedMovie.id)")
        Task {
            await setHeader()
        }
    }
    
    func setupView() {
        movieTitle.text = selectedMovie.title
        headerImageView.layer.cornerRadius = 25
        headerImageView.clipsToBounds = true
        
        playView.layer.cornerRadius = 15
        
        titleContainerView.layer.cornerRadius = 25
        detailContainerView.layer.cornerRadius = 25
        plotContainerView.layer.cornerRadius = 25
        
        movieOverviewLabel.text = selectedMovie.overview
        
        addValueLabelPair(value: "2024", type: "Year")
        addValueLabelPair(value: "USA", type: "Country")
        addValueLabelPair(value: "2h 18m", type: "Time")
    }
    
    func setupBindings() {
        dominantColor.subscribe(onNext: { [weak self] value in
            self!.playButton.tintColor = value
            self!.titleContainerView.backgroundColor = value
            
            self!.playView.isHidden = false
        }).disposed(by: disposeBag)
    }
    
    func setHeader() async {
        do {
            try await headerImageView.loadImage(selectedMovie.backdropImageURL)
            self.dominantColor.accept(headerImageView.image!.dominantColor()!)
            
        } catch {
            print("error loading image")
        }
    }
    
    func addValueLabelPair(value: String, type: String) {
        let pair = ValueLabelPair(value: value, type: type)
        valuePairStackView.addArrangedSubview(pair)
    }

}
