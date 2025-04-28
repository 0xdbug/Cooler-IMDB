//
//  HomeCollectionView.swift
//  Better-IMDB
//
//  Created by dbug on 4/9/25.
//

import UIKit

class HomeCollectionView: BaseCollectionView {
    
    init(layoutProvider: CollectionViewLayoutProvider) {
        super.init(frame: .zero, layoutProvider: layoutProvider)
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func registerCells() {
        register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.id)
    }
}
