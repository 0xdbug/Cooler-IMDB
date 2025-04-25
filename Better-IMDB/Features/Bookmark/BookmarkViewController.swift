//
//  BookmarkViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

class BookmarkViewController: CollectionViewController {
    weak var coordinator: BookmarkCoordinator?
    
    var collectionView: BookmarkListCollectionView = {
        let collectionView = BookmarkListCollectionView(layoutProvider: BookmarkLayoutProvider())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
        
    override func viewDidLoad() {
        
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.pin(to: view)
    }
    
    func setupCollectionView() {
        guard let viewModel = viewModel as? BookmarkViewModel else { return }
        
        setupRefreshControl(for: collectionView) {
            viewModel.fetchMovies(withIds: MoviePersistence.getAllBookmarks())
        }

        viewModel.items
            .bind(to: collectionView
                .rx.items(cellIdentifier: BookmarkListCollectionViewCell.id, cellType: BookmarkListCollectionViewCell.self)) { row, item, cell in
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
                
                self.coordinator?.showDetail(movie, from: self, at: indexPath)
            })
            .disposed(by: disposeBag)
        
        viewModel.fetchMovies(withIds: MoviePersistence.getAllBookmarks())
    }
}

