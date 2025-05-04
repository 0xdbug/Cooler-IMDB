//
//  ListViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit
import RxSwift
import RxCocoa

protocol MovieListCollectionProtocol: AnyObject {
    var collectionView: BaseCollectionView { get }
}

class ListViewController: CollectionViewController, MovieListCollectionProtocol {
    
    var collectionView: BaseCollectionView = {
        let collectionView = ListCollectionView(layoutProvider: ListLayoutProvider())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var selectedSection: MovieSection!
    
    var listViewModel: ListViewModelProtocol!
    
    override func viewDidLoad() {
        guard let viewModel = viewModel as? ListViewModelProtocol else { return }
        listViewModel = viewModel
        
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.pin(to: view)
    }
    
    func setupCollectionView() {
        setupRefreshControl(for: collectionView, refreshAction: { [weak self] in
            
            guard let self = self else { return }
            
            self.listViewModel.fetchItems(for: self.selectedSection)
        })
        
        disposeBag.insert(
            self.listViewModel.items.drive(collectionView.rx.items(cellIdentifier: ListCollectionViewCell.id, cellType: ListCollectionViewCell.self)) { row, item, cell in
                Task {
                    await cell.configure(with: ListCollectionViewCellModel(movie: item))
                }
            },
            
            collectionView.rx.itemSelected
                .asDriver()
                .withLatestFrom(self.listViewModel.items) { indexPath, items in (indexPath, items) }
                .drive(onNext: { [weak self] indexPath, items in
                    guard let self = self else { return }
                    guard indexPath.item < items.count else { return }
                    
                    let movie = items[indexPath.item]
                    self.listViewModel.showDetail(movie, from: self, at: indexPath)
                }),
            
            collectionView.rx.didScroll.subscribe { [weak self] _ in
                guard let self = self else { return }
                let offSetY = self.collectionView.contentOffset.y
                let contentHeight = self.collectionView.contentSize.height
                
                if offSetY > (contentHeight - self.collectionView.frame.size.height - 100) {
                    self.listViewModel.loadMoreItems()
                }
            }
        )
        
        listViewModel.fetchItems(for: selectedSection)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent {
            listViewModel.coordinatorDidFinish()
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
