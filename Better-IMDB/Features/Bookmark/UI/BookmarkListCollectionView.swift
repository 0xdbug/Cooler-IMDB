//
//  BookmarkListCollectionView.swift
//  Better-IMDB
//
//  Created by dbug on 4/11/25.
//

import UIKit

class BookmarkListCollectionView: UICollectionView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewLayout = createLayout()
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment ->
            NSCollectionLayoutSection? in
            
            let width = environment.container.contentSize.width
            var columns = 2
            
            if width < 500 {
                columns = 2
            } else if width < 800 {
                columns = 3
            } else {
                columns = 4
            }
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0/CGFloat(columns)),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)
            

            let availableWidth = width
            let itemWidth = (availableWidth / CGFloat(columns)) - 16
            let itemHeight = itemWidth * 1.5
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(itemHeight + 16)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 0
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 10
        layout.configuration = config
        
        return layout
    }
}
