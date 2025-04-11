//
//  BITabBarController.swift
//  Better-IMDB
//
//  Created by dbug on 4/9/25.
//

import UIKit
import RxSwift
import SnapKit

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
        biTabBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.height.equalTo(70)
        }
        
        visualEffectView.snp.makeConstraints {
            $0.edges.equalTo(biTabBar)
        }
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
