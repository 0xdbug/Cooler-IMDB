//
//  TabBarCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit

class TabBarCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    private let tabBarController = BITabBarController()
    private let container: DependencyContainer
    
    init(navigationController: UINavigationController, container: DependencyContainer) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let homeNavController = UINavigationController()
        let bookmarkNavController = UINavigationController()
        
        let home = HomeCoordinator(
            navigationController: homeNavController,
            container: container
        )
        home.parentCoordinator = self
        
        let bookmark = BookmarkCoordinator(
            navigationController: bookmarkNavController,
            container: container
        )
        bookmark.parentCoordinator = self
        
        children = [home, bookmark]
        children.forEach { $0.start() }
        
        tabBarController.setViewControllers([
            homeNavController,
            bookmarkNavController
        ], animated: true)
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
