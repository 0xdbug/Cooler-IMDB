//
//  HomeCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit

protocol BookmarkViewModelDelegate: AnyObject {
    func showDetail(_ movie: MovieDetail, from listViewController: BookmarkViewController, at indexPath: IndexPath)
}

class BookmarkCoordinator: Coordinator, BookmarkViewModelDelegate {
    var navigationController: UINavigationController
    
    private let container: DependencyContainer
    
    init(navigationController: UINavigationController, container: DependencyContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let viewModel = BookmarkViewModel(repository: container.get())
        viewModel.delegate = self
        let vc = BookmarkViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func showDetail(_ movie: MovieDetail, from listViewController: BookmarkViewController, at indexPath: IndexPath) {
        let movieDetailCoordinator = MovieDetailCoordintaor(
            navigationController: navigationController,
            container: container
        )
        
        movieDetailCoordinator.start(with: movie.id, from: listViewController, at: indexPath)
    }
    
}
