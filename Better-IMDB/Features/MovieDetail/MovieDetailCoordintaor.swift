//
//  MovieDetailCoordintaor.swift
//  Better-IMDB
//
//  Created by dbug on 5/4/25.
//

import UIKit

protocol PosterImageProvider {
    var posterImage: UIImageView { get }
}

class MovieDetailCoordintaor: Coordinator {
    func start() {}
    
    var parentCoordinator: (any Coordinator)?
    var children: [any Coordinator] = []
    var navigationController: UINavigationController
    
    private let container: DependencyContainer
    
    init(
        navigationController: UINavigationController,
        container: DependencyContainer
    ) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start(with movieId: Int, from listViewController: UIViewController, at indexPath: IndexPath) {
        let viewModel = MovieDetailViewModel(repository: container.get())
        viewModel.coordinator = self
        let vc = MovieDetailViewController(viewModel: viewModel)
        vc.selectedMovieId = movieId
        
        vc.preferredTransition = .zoom(sourceViewProvider: { [weak listViewController] _ in
            
            guard let sourceVC = listViewController as? MovieListCollectionProtocol else {
                print("ListViewController is nil")
                return nil
            }
            
            let collectionView = sourceVC.collectionView
            
            guard let cell = collectionView.cellForItem(at: indexPath) as? PosterImageProvider else {
                return nil
            }
            
            return cell.posterImage
        })
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func didFinish() {
        if let index = parentCoordinator?.children.firstIndex(where: { $0 === self }) {
            parentCoordinator?.children.remove(at: index)
        }
    }
}
