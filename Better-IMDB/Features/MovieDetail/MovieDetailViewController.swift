//
//  MovieDetailViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import UIKit

class MovieDetailViewController: UIViewController, Storyboarded {
    
    var selectedMovie: Movie!
    
    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var playButton: UIButton!
    
    let viewModel = MovieDetailViewModel(networkService: MovieDetailService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        viewModel.fetchMovie(withId: "\(selectedMovie.id)")
        
        Task {
            await setHeader()
        }
    }
    
    func setupView() {
        headerImageView.layer.cornerRadius = 20
        headerImageView.clipsToBounds = true
        
        playView.layer.cornerRadius = 15
    }
    
    func setHeader() async {
        do {
            try await headerImageView.loadImage(selectedMovie.backdropImageURL)
            playButton.tintColor = headerImageView.image?.dominantColor()
            playView.isHidden = false
        } catch {
            print("error loading image")
        }
    }

}
