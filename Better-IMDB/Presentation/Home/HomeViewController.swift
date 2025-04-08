//
//  HomeViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController, Storyboarded {
    weak var coordinator: AppCoordinator?

    let viewModel: HomeViewModel = HomeViewModel(networkService: TMDBService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchItems()        
    }


}

