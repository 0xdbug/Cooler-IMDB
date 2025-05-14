//
//  ListCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 5/4/25.
//

import UIKit

protocol ListViewModelDelegate: AnyObject {
    func showDetail(_ movie: Movie, from listViewController: ListViewController, at indexPath: IndexPath)
}

class ListCoordinator: Coordinator, ListViewModelDelegate {
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
    
    func start(with section: MovieSection) {
        let viewModel = ListViewModel(repository: container.get())
        viewModel.delegate = self
        let vc = ListViewController(viewModel: viewModel)
        vc.selectedSection = section
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetail(_ movie: Movie, from listViewController: ListViewController, at indexPath: IndexPath) {
        
        let movieDetailCoordinator = MovieDetailCoordintaor(
            navigationController: navigationController,
            container: container
        )
                
        movieDetailCoordinator.start(with: movie.id, from: listViewController, at: indexPath)
    }
    
}
