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
    
    private let container: DependencyContainer
    
    init(navigationController: UINavigationController, container: DependencyContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let viewModel = BookmarkViewModel(networkService: container.get())
        viewModel.coordinator = self
        let vc = BookmarkViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetail(_ movie: MovieDetail, from listViewController: BookmarkViewController, at indexPath: IndexPath) {
        let viewModel = MovieDetailViewModel(networkService: container.get())
        let vc = MovieDetailViewController(viewModel: viewModel)
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
