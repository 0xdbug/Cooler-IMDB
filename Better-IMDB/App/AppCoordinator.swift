//
//  AppCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let container: DependencyContainer
    
    init(navigationController : UINavigationController, container: DependencyContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    // MARK: - Functions
    func start() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController, container: container)
        tabBarCoordinator.parentCoordinator = self
        children = [tabBarCoordinator]
        tabBarCoordinator.start()
    }
}

