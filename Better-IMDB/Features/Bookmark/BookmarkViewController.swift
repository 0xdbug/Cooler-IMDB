//
//  BookmarkViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

class BookmarkViewController: CollectionViewController, MovieListCollectionProtocol {
    
    var collectionView: BaseCollectionView = {
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
        guard let viewModel = viewModel as? BookmarkViewModelProtocol else { return }
        
        setupRefreshControl(for: collectionView) { [weak viewModel] in
            viewModel?.fetchMovies(withIds: MoviePersistence.getAllBookmarks())
        }
        
        disposeBag.insert(
            viewModel.items.drive(collectionView.rx.items(cellIdentifier: BookmarkListCollectionViewCell.id, cellType: BookmarkListCollectionViewCell.self)) { row, item, cell in
                    cell.configure(with: BookmarkListCollectionViewCellModel(movieDetail: item))
            },
            
            collectionView
                .rx
                .itemSelected
                .withLatestFrom(viewModel.items) { indexPath, movies -> (IndexPath, MovieDetail) in
                    return (indexPath, movies[indexPath.item])
                }
                .subscribe(onNext: { [weak self, weak viewModel] indexPath, movie in
                    guard let self = self else { return }
                    viewModel?.showDetail(movie, from: self, at: indexPath)
                })
        )
        
        viewModel.fetchMovies(withIds: MoviePersistence.getAllBookmarks())
    }
}

