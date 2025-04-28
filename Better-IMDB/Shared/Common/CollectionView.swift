//
//  CollectionView.swift
//  Better-IMDB
//
//  Created by dbug on 4/25/25.
//

import UIKit

protocol CollectionViewLayoutProvider {
    func createLayout(for environment: NSCollectionLayoutEnvironment?) -> UICollectionViewLayout
}

class BaseCollectionView: UICollectionView {
    private var layoutProvider: CollectionViewLayoutProvider?
    
    init() {
        super.init(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        makeUI()
    }
    
    init(frame: CGRect = .zero, layoutProvider: CollectionViewLayoutProvider) {
        self.layoutProvider = layoutProvider
        super.init(frame: frame, collectionViewLayout: layoutProvider.createLayout(for: nil))
        makeUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    func makeUI() {
        self.layer.masksToBounds = true
        updateUI()
    }
    
    func updateUI() {
        setNeedsDisplay()
    }
    
    func updateLayout(with provider: CollectionViewLayoutProvider, environment: NSCollectionLayoutEnvironment? = nil) {
        self.layoutProvider = provider
        self.collectionViewLayout = provider.createLayout(for: environment)
    }
}

