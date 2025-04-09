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
        let baseTabBarController = BITabBarController()
        baseTabBarController.coordinator = self
        navigationController.pushViewController(baseTabBarController, animated: true)
    }
    
}
