//
//  HomeLayoutProvider.swift
//  Better-IMDB
//
//  Created by dbug on 4/25/25.
//

import UIKit

class HomeLayoutProvider: CollectionViewLayoutProvider {
    func createLayout(for environment: NSCollectionLayoutEnvironment?) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            let actualEnv = environment ?? env
            
            let columns = actualEnv.container.contentSize.width > 500 ? 2 : 1
            
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(columns == 1 ? 1 : 0.5),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(500)
            )
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: columns)
            
            group.interItemSpacing = .flexible(1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 1
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 1
        layout.configuration = config
        
        return layout
    }
}
