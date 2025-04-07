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
        let home = HomeViewController.instantiate()
        home.coordinator = self
        navigationController.pushViewController(home, animated: true)
    }
    
//    func viewDetail(_ item: NivlItem) {
//        let detailViewModel = DetailViewModel(item: item)
//        let detail = DetailViewController.instantiate()
//        detail.viewModel = detailViewModel
//        navigationController.pushViewController(detail, animated: true)
//    }
    
}
