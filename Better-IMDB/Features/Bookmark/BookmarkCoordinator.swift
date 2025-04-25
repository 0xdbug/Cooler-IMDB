//
//  HomeCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit

class BookmarkCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BookmarkViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetail(_ movie: MovieDetail, from listViewController: BookmarkViewController, at indexPath: IndexPath) {
        let vc = MovieDetailViewController()
        vc.selectedMovieId = movie.id
        
        vc.preferredTransition = .zoom(sourceViewProvider: { [weak listViewController] _ in
            guard let sourceVC = listViewController else {
                print("BookmarkViewController is nil.")
                return nil
            }
            
            let collectionView = sourceVC.collectionView
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? BookmarkListCollectionViewCell else {
                return nil
            }
            
            return cell.posterImage
        })
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
