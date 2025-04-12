//
//  MovieDetailViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import UIKit

class MovieDetailViewController: UIViewController, Storyboarded {
    @IBOutlet weak var movieHeader: UIImageView!
    
    var selectedMovie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            await setup()
        }
    }
    
    func setup() async {
        do {
            try await movieHeader.loadImage(selectedMovie.posterImageURL)
        } catch {
            print("error loading image")
        }
    }

}
