//
//  HomeCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit

class HomeCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let container: DependencyContainer

    init(
        navigationController: UINavigationController,
        container: DependencyContainer
    ) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let viewModel = HomeViewModel(networkService: container.tmdbService)
        viewModel.coordinator = self
        let vc = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func list(_ card: HomeCards) {
        let viewModel = ListViewModel(networkService: container.tmdbService)
        viewModel.coordinator = self
        let vc = ListViewController(viewModel: viewModel)
        vc.selectedCard = card
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetail(_ movie: Movie, from listViewController: ListViewController, at indexPath: IndexPath) {
        let viewModel = MovieDetailViewModel(networkService: container.movieDetailService)
        let vc = MovieDetailViewController(viewModel: viewModel)
        vc.selectedMovieId = movie.id
        
        vc.preferredTransition = .zoom(sourceViewProvider: { [weak listViewController] _ in
            
            guard let sourceVC = listViewController else {
                print("ListViewController is nil.")
                return nil
            }
            
            let collectionView = sourceVC.collectionView
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? ListCollectionViewCell else {
                return nil
            }

            return cell.posterImage
        })
        
        navigationController.pushViewController(vc, animated: true)
    }
}
