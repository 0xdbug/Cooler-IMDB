//
//  TabBarCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit

class TabBarCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    private let tabBarController = BITabBarController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeNavController = UINavigationController()
        let bookmarkNavController = UINavigationController()
        
        DependencyContainer.register()
        
        let home = HomeCoordinator(
            navigationController: homeNavController,
            container: DependencyContainer.shared
        )
        
        let bookmark = BookmarkCoordinator(
            navigationController: bookmarkNavController,
            container: DependencyContainer.shared
        )
        
        home.start()
        bookmark.start()
        
        tabBarController.setViewControllers([
            homeNavController,
            bookmarkNavController
        ], animated: true)
        
        navigationController.setViewControllers([tabBarController], animated: false)
    }
}
