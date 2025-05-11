//
//  HomeCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit

protocol HomeViewModelDelegate: AnyObject {
    func list(_ section: MovieSection)
}

class HomeCoordinator: Coordinator, HomeViewModelDelegate {
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
        let viewModel = HomeViewModel(repository: container.get())
        viewModel.delegate = self
        let vc = HomeViewController(viewModel: viewModel)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func list(_ section: MovieSection) {
        let listCoordinator = ListCoordinator(
            navigationController: navigationController,
            container: container
        )
        
        listCoordinator.parentCoordinator = self
        children.append(listCoordinator)
        
        listCoordinator.start(with: section)
    }
}
