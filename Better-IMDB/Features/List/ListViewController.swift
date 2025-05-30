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

class ListViewController: ViewController, MovieListCollectionProtocol {
    var viewModel: ListViewModelProtocol?
    
    var collectionView: BaseCollectionView = {
        let collectionView = ListCollectionView(layoutProvider: ListLayoutProvider())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var selectedSection: MovieSection!
    
    init(viewModel: ListViewModelProtocol? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        guard let viewModel else { return }
        bind(viewModel: viewModel)
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        view.addSubview(collectionView)
        collectionView.pin(to: view)
    }
    
    private func bind(viewModel: ListViewModelProtocol) {
        viewModel.error
            .subscribe(onNext: { [weak self] error in
                self?.showError(error)
            })
            .disposed(by: disposeBag)
        
        viewModel.items.drive(collectionView.rx.items(cellIdentifier: ListCollectionViewCell.id, cellType: ListCollectionViewCell.self)) { row, item, cell in
            Task {
                await cell.configure(with: ListCollectionViewCellModel(movie: item))
            }
        }.disposed(by: disposeBag)
    }
    
    private func setupCollectionView() {
        setupRefreshControl(for: collectionView, refreshAction: { [weak self] in
            guard let self = self else { return }
            viewModel?.fetchItems(for: self.selectedSection)
        })
        
        guard let items = viewModel?.items else { return }
        
        collectionView.rx.itemSelected
            .asDriver()
            .withLatestFrom(items) { indexPath, items in (indexPath, items) }
            .drive(onNext: { [weak self] indexPath, items in
                guard let self = self else { return }
                guard indexPath.item < items.count else { return }
                
                let movie = items[indexPath.item]
                viewModel?.showDetail(movie, from: self, at: indexPath)
            }).disposed(by: disposeBag)
        
        collectionView.rx.didScroll.subscribe { [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.collectionView.contentOffset.y
            let contentHeight = self.collectionView.contentSize.height
            
            if offSetY > (contentHeight - self.collectionView.frame.size.height - 100) {
                viewModel?.loadMoreItems()
            }
        }.disposed(by: disposeBag)
        
        viewModel?.fetchItems(for: selectedSection)
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
