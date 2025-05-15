//
//  HomeViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: ViewController {
    var viewModel: HomeViewModelProtocol?
    
    private lazy var mainCollectionView: HomeCollectionView = {
        let collectionView = HomeCollectionView(layoutProvider: HomeLayoutProvider())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    init(viewModel: HomeViewModelProtocol? = nil) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        setupRefreshControl(for: mainCollectionView) { [weak viewModel] in
            viewModel?.fetchItems()
        }
        
        viewModel?.items
            .drive(mainCollectionView.rx.items(cellIdentifier: HomeCollectionViewCell.id, cellType: HomeCollectionViewCell.self))
        { row, item, cell in
            Task { await cell.configure(with: HomeCollectionViewCellModel(item: item)) }
        }.disposed(by: disposeBag)
        
        mainCollectionView
            .rx
            .modelSelected(HomeCards.self)
            .subscribe(onNext: { [weak viewModel] selected in
                viewModel?.showList(selected.section)
            })
            .disposed(by: disposeBag)
        
        viewModel?.error
            .subscribe(onNext: { [weak self] error in
                self?.showError(error)
            })
            .disposed(by: disposeBag)
        
        viewModel?.fetchItems()
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
