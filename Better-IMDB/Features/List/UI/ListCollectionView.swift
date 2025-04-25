//
//  ListCollectionView.swift
//  Better-IMDB
//
//  Created by dbug on 4/11/25.
//

import UIKit

class ListCollectionView: BaseCollectionView {
    
    init(layoutProvider: CollectionViewLayoutProvider) {
        super.init(frame: .zero, layoutProvider: layoutProvider)
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func registerCells() {
        register(ListCollectionViewCell.self, forCellWithReuseIdentifier: ListCollectionViewCell.id)
    }
}
