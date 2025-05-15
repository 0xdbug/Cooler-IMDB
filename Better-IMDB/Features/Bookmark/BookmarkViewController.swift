//
//  BookmarkViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

class BookmarkViewController: ViewController, MovieListCollectionProtocol {
    var viewModel: BookmarkViewModelProtocol?
    
    var collectionView: BaseCollectionView = {
        let collectionView = BookmarkListCollectionView(layoutProvider: BookmarkLayoutProvider())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: BookmarkViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.pin(to: view)
    }
    
    func setupCollectionView() {
        
        setupRefreshControl(for: collectionView) { [weak viewModel] in
            viewModel?.fetchMovies(withIds: MoviePersistence.getAllBookmarks())
        }
        
        viewModel?.items.drive(collectionView.rx.items(cellIdentifier: BookmarkListCollectionViewCell.id, cellType: BookmarkListCollectionViewCell.self)) { row, item, cell in
            cell.configure(with: BookmarkListCollectionViewCellModel(movieDetail: item))
        }.disposed(by: disposeBag)
        
        guard let items = viewModel?.items else { return }
        
        collectionView
            .rx
            .itemSelected
            .withLatestFrom(items) { indexPath, movies -> (IndexPath, MovieDetail) in
                return (indexPath, movies[indexPath.item])
            }
            .subscribe(onNext: { [weak self, weak viewModel] indexPath, movie in
                guard let self = self else { return }
                viewModel?.showDetail(movie, from: self, at: indexPath)
            }).disposed(by: disposeBag)
        
        viewModel?.error
            .subscribe(onNext: { [weak self] error in
                self?.showError(error)
            })
            .disposed(by: disposeBag)
        
        viewModel?.fetchMovies(withIds: MoviePersistence.getAllBookmarks())
    }
    
    func setupRefreshControl(for collectionView: UICollectionView, refreshAction: @escaping () -> Void) {
        let refreshControl = UIRefreshControl()
        collectionView.refreshControl = refreshControl
        
        refreshControl.rx.controlEvent(.valueChanged)
            .do(onNext: { _ in
                refreshAction()
            })
            .bind(to: headerRefreshTrigger)
            .disposed(by: disposeBag)
        
        viewModel?.isLoading
            .drive(onNext: { [weak refreshControl] isLoading in
                if !isLoading {
                    refreshControl?.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
}

