//
//  BookmarkListCollectionView.swift
//  Better-IMDB
//
//  Created by dbug on 4/11/25.
//

import UIKit

class BookmarkListCollectionView: BaseCollectionView {
    
    init(layoutProvider: CollectionViewLayoutProvider) {
        super.init(frame: .zero, layoutProvider: layoutProvider)
        registerCells()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func registerCells() {
        register(BookmarkListCollectionViewCell.self, forCellWithReuseIdentifier: BookmarkListCollectionViewCell.id)
    }
}
