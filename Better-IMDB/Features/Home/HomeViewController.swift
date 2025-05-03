//
//  HomeViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: CollectionViewController {
    
//    viewModel is the delegate
//    weak var delegate: HomeViewControllerDelegate?
    
    private lazy var mainCollectionView: HomeCollectionView = {
        let collectionView = HomeCollectionView(layoutProvider: HomeLayoutProvider())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.addSubview(mainCollectionView)
        mainCollectionView.pin(to: view)
    }
    
    func setupCollectionView() {
        guard let viewModel = viewModel as? HomeViewModelProtocol else { return }
        
        setupRefreshControl(for: mainCollectionView) { [weak viewModel] in
            viewModel?.fetchItems()
        }
        
        disposeBag.insert(
            viewModel.items
                .drive(mainCollectionView.rx.items(cellIdentifier: HomeCollectionViewCell.id, cellType: HomeCollectionViewCell.self))
            { row, item, cell in
                Task { await cell.configure(with: HomeCollectionViewCellModel(item: item)) }
            },
            
            mainCollectionView
                .rx
                .modelSelected(HomeCards.self)
                .subscribe(onNext: { [weak viewModel] selected in
                    viewModel?.showList(selected.section)
                })
        )
        
        viewModel.fetchItems()
    }
}
