//
//  HomeViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController, Storyboarded {
    weak var coordinator: AppCoordinator?

    let viewModel: HomeViewModel = HomeViewModel(networkService: TMDBService())
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var mainCollectionView: HomeCollectionView!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchItems()
        setupCollectionView()
        let sampleImages = [
            UIImage(named: "minecraft")!,
            UIImage(named: "minecraft")!,
        ]
        
        let posterStackView = MultiplePosterView(frame: .zero, posters: sampleImages)
        view.addSubview(posterStackView)
        
        posterStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    func setupCollectionView() {
        viewModel.items
            .bind(to: mainCollectionView
                .rx.items(cellIdentifier: HomeCollectionViewCell.id, cellType: HomeCollectionViewCell.self)) { row, item, cell in
                    Task {
                        await cell.configureWithItem(item)
                    }
                }
                .disposed(by: disposeBag)
    }
    
}

