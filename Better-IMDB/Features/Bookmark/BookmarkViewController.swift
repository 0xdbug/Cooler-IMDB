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

    let viewModel = BookmarkViewModel(networkService: TMDBService())
    private let disposeBag = DisposeBag()
    
    var collectionView: BookmarkListCollectionView = {
        let collectionView = BookmarkListCollectionView(layoutProvider: BookmarkLayoutProvider())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
        
    override func viewDidLoad() {
        
        setupUI()
        setupCollectionView()
        viewModel.fetchMovies(withIds: MoviePersistence.getAllBookmarks())
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.pin(to: view)
    }
    
    func setupCollectionView() {
        collectionView.refreshControl = UIRefreshControl()
        
//        disposeBag.insert(
//            viewModel.items.
//        )
        
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
                
                guard indexPath.item < self.viewModel.items.value.count else {
                    return
                }
                let movie = self.viewModel.items.value[indexPath.item]
                
                self.coordinator?.showDetail(movie, from: self, at: indexPath)
            })
            .disposed(by: disposeBag)
        
        collectionView.refreshControl?.rx.controlEvent(.valueChanged).subscribe(onNext: {
            self.viewModel.fetchMovies(withIds: MoviePersistence.getAllBookmarks())
            self.collectionView.refreshControl?.endRefreshing()
        }).disposed(by: disposeBag)
    }
}

