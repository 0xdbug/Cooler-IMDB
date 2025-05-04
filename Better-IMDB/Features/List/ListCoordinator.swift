//
//  ListCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 5/4/25.
//

import UIKit

class ListCoordinator: Coordinator {
    func start() {}
    
    weak var parentCoordinator: (any Coordinator)?
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
    
    func start(with section: MovieSection) {
        let viewModel = ListViewModel(repository: container.get())
        viewModel.coordinator = self
        let vc = ListViewController(viewModel: viewModel)
        vc.selectedSection = section
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetail(_ movie: Movie, from listViewController: ListViewController, at indexPath: IndexPath) {
        
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
