//
//  HomeViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

// error handling
class HomeViewController: UIViewController, Storyboarded {
    weak var coordinator: HomeCoordinator?

    let viewModel: HomeViewModel = HomeViewModel(networkService: TMDBService()) // initialize in coordinator
    private let disposeBag = DisposeBag()
    
    private lazy var mainCollectionView: HomeCollectionView = {
        let collectionView = HomeCollectionView(layoutProvider: HomeLayoutProvider())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.fetchItems()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.addSubview(mainCollectionView)
        mainCollectionView.pin(to: view)
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
        
        mainCollectionView
            .rx
            .modelSelected(HomeCards.self)
            .subscribe(onNext: { selected in
                self.coordinator?.list(selected)
            })
            .disposed(by: disposeBag)
        
        
//        disposeBag.insert(
//            viewModel.items
//                .drive(mainCollectionView.rx.items(cellIdentifier: HomeCollectionViewCell.id, cellType: HomeCollectionViewCell.self))
//            { row, item, cell in
//                Task { await cell.configureWithItem(item) }
//            },
//
//            mainCollectionView
//                .rx
//                .modelSelected(HomeCards.self)
//                .subscribe(onNext: { selected in
//                    self.coordinator?.list(selected)
//                })
//        )
    }
    
}

