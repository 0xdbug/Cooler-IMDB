//
//  ListViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: CollectionViewController {
    
    var collectionView: ListCollectionView = {
        let collectionView = ListCollectionView(layoutProvider: ListLayoutProvider())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var selectedCard: HomeCards!
    
    override func viewDidLoad() {
        
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.pin(to: view)
    }
    
    func setupCollectionView() {
        guard let viewModel = viewModel as? ListViewModel else { return }
        
        setupRefreshControl(for: collectionView, refreshAction: {
            viewModel.fetchItems(for: self.selectedCard.cardType)
        })
    
        viewModel.items
            .bind(to: collectionView
                .rx.items(cellIdentifier: ListCollectionViewCell.id, cellType: ListCollectionViewCell.self)) { row, item, cell in
                    Task {
                        await cell.configureWithMovie(item)
                    }
                }
                .disposed(by: disposeBag)
        
        
        collectionView
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                guard indexPath.item < viewModel.items.value.count else {
                    return
                }
                let movie = viewModel.items.value[indexPath.item]

                viewModel.showDetail(movie, from: self, at: indexPath)
            })
            .disposed(by: disposeBag)

        
        collectionView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.collectionView.contentOffset.y
            let contentHeight = self.collectionView.contentSize.height
            
            if offSetY > (contentHeight - self.collectionView.frame.size.height - 100) {
                viewModel.loadMoreItems()
            }
        }
        .disposed(by: disposeBag)
        
        viewModel.fetchItems(for: selectedCard.cardType)
    }
    
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
