//
//  Coordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
}
