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
        
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Functions
    func start() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        tabBarCoordinator.parentCoordinator = self
        children = [tabBarCoordinator]
        tabBarCoordinator.start()
    }
}

