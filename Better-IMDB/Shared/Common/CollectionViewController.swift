//
//  CollectionViewController.swift
//  Better-IMDB
//
//  Created by dbug on 4/25/25.
//

import UIKit
import RxSwift
import RxCocoa

class CollectionViewController: ViewController {
    let headerRefreshTrigger = PublishSubject<Void>()
    
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
