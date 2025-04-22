//
//  BITabBarController.swift
//  Better-IMDB
//
//  Created by dbug on 4/9/25.
//

import UIKit
import RxSwift

class BITabBarController: UITabBarController {
    weak var coordinator: AppCoordinator?
    
    let biTabBar = BITabBar()
    private let disposeBag = DisposeBag()
    let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupProperties()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupHierarchy() {
        view.addSubview(visualEffectView)
        view.addSubview(biTabBar)
    }
    
    private func setupLayout() {
        biTabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            biTabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            biTabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            biTabBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            biTabBar.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            visualEffectView.topAnchor.constraint(equalTo: biTabBar.topAnchor),
            visualEffectView.bottomAnchor.constraint(equalTo: biTabBar.bottomAnchor),
            visualEffectView.leadingAnchor.constraint(equalTo: biTabBar.leadingAnchor),
            visualEffectView.trailingAnchor.constraint(equalTo: biTabBar.trailingAnchor)
        ])
    }
    
    private func setupProperties() {
        tabBar.isHidden = true
                
        visualEffectView.clipsToBounds = true
        visualEffectView.layer.cornerRadius = 30
        
        view.bringSubviewToFront(biTabBar)
        
    }
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
    }
    
    private func selectTabWith(index: Int) {
        self.selectedIndex = index
    }
    
    private func bind() {
        biTabBar.itemTapped
            .bind { [weak self] in self?.selectTabWith(index: $0) }
            .disposed(by: disposeBag)
    }
}
