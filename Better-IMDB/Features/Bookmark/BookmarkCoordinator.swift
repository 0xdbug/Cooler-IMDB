//
//  HomeCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit

protocol BookmarkViewModelDelegate: AnyObject {
    func showDetail(_ movie: MovieDetail, from listViewController: BookmarkViewController, at indexPath: IndexPath)
    func didFinish()
}

class BookmarkCoordinator: Coordinator, BookmarkViewModelDelegate {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
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
        
        movieDetailCoordinator.parentCoordinator = self
        children.append(movieDetailCoordinator)
        
        movieDetailCoordinator.start(with: movie.id, from: listViewController, at: indexPath)
    }
    
    func didFinish() {
        if let index = parentCoordinator?.children.firstIndex(where: { $0 === self }) {
            parentCoordinator?.children.remove(at: index)
        }
    }
    
}
