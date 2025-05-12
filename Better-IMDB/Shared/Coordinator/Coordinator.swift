//
//  Coordinator.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}
