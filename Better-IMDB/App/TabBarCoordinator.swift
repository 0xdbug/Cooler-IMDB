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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeNavController = UINavigationController()
        let bookmarkNavController = UINavigationController()
        
//        let container = DependencyContainer.shared
//        container.register(TMDBNetworkServiceProtocol.self) { TMDBService() }
//        container.register(MovieDetailNetworkServiceProtocol.self) { MovieDetailService() }
        
        DependencyContainer.register()
        
        let home = HomeCoordinator(
            navigationController: homeNavController,
            container: DependencyContainer.shared
        )
        home.parentCoordinator = self
        
        let bookmark = BookmarkCoordinator(
            navigationController: bookmarkNavController,
            container: DependencyContainer.shared
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
