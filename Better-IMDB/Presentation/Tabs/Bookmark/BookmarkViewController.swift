//
//  BookmarkViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

class BookmarkViewController: UIViewController, Storyboarded {
    weak var coordinator: BookmarkCoordinator?

    let viewModel: HomeViewModel = HomeViewModel(networkService: TMDBService())
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var mainCollectionView: HomeCollectionView!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewModel.fetchItems()
        setupCollectionView()

    }

    func setupCollectionView() {
    
    }
    
}

