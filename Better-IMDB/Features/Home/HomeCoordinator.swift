//
//  HomeCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit

// separate coordinator (specific)
class HomeCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func list(_ card: HomeCards) {
        let vc = ListViewController.instantiate()
        vc.coordinator = self
        vc.selectedCard = card
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetail(_ movie: Movie, from listViewController: ListViewController, at indexPath: IndexPath) {
        let vc = MovieDetailViewController.instantiate()
        vc.selectedMovieId = movie.id
        
        vc.preferredTransition = .zoom(sourceViewProvider: { [weak listViewController] _ in
            
            guard let sourceVC = listViewController else {
                print("ListViewController is nil.")
                return nil
            }
            
            guard let collectionView = sourceVC.collectionView else {
                print("CollectionView is nil.")
                return nil
            }
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? ListCollectionViewCell else {
                return nil
            }

            return cell.posterImage
        })
        
        navigationController.pushViewController(vc, animated: true)
    }
}
