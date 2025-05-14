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

protocol MovieDetailViewModelDelegate: AnyObject {
    func start(with movieId: Int, from listViewController: UIViewController, at indexPath: IndexPath)
}

class MovieDetailCoordintaor: Coordinator, MovieDetailViewModelDelegate {
    func start() {}
    
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
        viewModel.delegate = self
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
    
}
