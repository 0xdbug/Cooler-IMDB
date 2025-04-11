//
//  ListViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController, Storyboarded {
    weak var coordinator: HomeCoordinator?
    
    @IBOutlet weak var collectionView: ListCollectionView!
    private let disposeBag = DisposeBag()
    
    var selectedCard: HomeCards!
    
    let viewModel = ListViewModel(networkService: TMDBService())
    
    override func viewDidLoad() {
        viewModel.fetchItems(for: selectedCard.cardType)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        viewModel.items
            .bind(to: collectionView
                .rx.items(cellIdentifier: ListCollectionViewCell.id, cellType: ListCollectionViewCell.self)) { row, item, cell in
                    Task {
                        await cell.configureWithMovie(item)
                    }
                }
                .disposed(by: disposeBag)
        
        collectionView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.collectionView.contentOffset.y
            let contentHeight = self.collectionView.contentSize.height
            
            if offSetY > (contentHeight - self.collectionView.frame.size.height - 100) {
                self.viewModel.loadMoreItems()
            }
        }
        .disposed(by: disposeBag)
    }
    
    // i brute forced this dont know if it should be done like this tbh
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            if let tabBarController = navigationController?.tabBarController as? BITabBarController {
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
