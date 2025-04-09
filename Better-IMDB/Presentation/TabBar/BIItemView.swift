//
//  CustomItemView.swift
//  Better-IMDB
//
//  Created by dbug on 4/9/25.
//

import UIKit
import SnapKit

final class BIItemView: UIView {
    
    private let iconImageView = UIImageView()
    private let containerView = UIView()
    let index: Int
    
    var isSelected = false {
        didSet {
            animateItems()
        }
    }
    
    private let item: BITabItem
    
    init(with item: BITabItem, index: Int) {
        self.item = item
        self.index = index
        
        super.init(frame: .zero)
        
        setupHierarchy()
        setupLayout()
        setupProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(containerView)
        let subViews = [iconImageView]
        subViews.forEach { containerView.addSubview($0) }
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
//            $0.height.width.equalTo(55)
        }
        
//        iconImageView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
        
    }
    
    private func setupProperties() {
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = isSelected ? item.selectedIcon : item.icon
    }
    
    private func animateItems() {
        UIView.transition(with: iconImageView,
                          duration: 0.1,
                          options: .transitionCrossDissolve) { [unowned self] in
            self.iconImageView.image = self.isSelected ? self.item.selectedIcon : self.item.icon
        }
    }
}
