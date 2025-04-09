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
    
    private let biTabBar = BITabBar()
    
    private let disposeBag = DisposeBag()
    
    let visualEffectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .systemUltraThinMaterial))


    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()
        setupProperties()
        bind()
        view.layoutIfNeeded()
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
            $0.bottom.equalToSuperview().inset(25)
            $0.height.equalTo(70)
        }
        visualEffectView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(25)
            $0.height.equalTo(70)
        }
    }
    
    private func setupProperties() {
        tabBar.isHidden = true
        
        biTabBar.translatesAutoresizingMaskIntoConstraints = false
        
        visualEffectView.translatesAutoresizingMaskIntoConstraints = false
        visualEffectView.clipsToBounds = true
        visualEffectView.layer.cornerRadius = 30
        
        selectedIndex = 0
        let controllers = BITabItem.allCases.map { $0.viewController }
        setViewControllers(controllers, animated: true)
    }

    private func selectTabWith(index: Int) {
        self.selectedIndex = index
    }
    
    //MARK: - Bindings
    
    private func bind() {
        biTabBar.itemTapped
            .bind { [weak self] in self?.selectTabWith(index: $0) }
            .disposed(by: disposeBag)
    }
}
