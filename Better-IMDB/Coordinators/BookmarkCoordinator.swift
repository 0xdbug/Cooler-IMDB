//
//  HomeCoordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/10/25.
//

import UIKit

class BookmarkCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = BookmarkViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func list() {
    }
    
}
