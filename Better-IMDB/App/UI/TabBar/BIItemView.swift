//
//  CustomItemView.swift
//  Better-IMDB
//
//  Created by dbug on 4/9/25.
//

import UIKit

final class BIItemView: UIView {
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    let index: Int
    private let item: BITabItem
    
    var isSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
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
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(titleLabel)
        addSubview(stackView)
    }
    
    private func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setupProperties() {
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        titleLabel.text = item.name
        titleLabel.textColor = .white.withAlphaComponent(0.4)
        titleLabel.textAlignment = .center
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = item.icon
        
        // Adding debug color to see the frames
        // backgroundColor = .red.withAlphaComponent(0.3)
        
        updateAppearance()
    }
    
    private func updateAppearance() {
        iconImageView.image = isSelected ? item.selectedIcon : item.icon
        titleLabel.textColor = isSelected ? .white : .white.withAlphaComponent(0.4)
        
        UIView.animate(withDuration: 0.3) {
            self.transform = self.isSelected ? CGAffineTransform(scaleX: 1.1, y: 1.1) : .identity
        }
    }
}
