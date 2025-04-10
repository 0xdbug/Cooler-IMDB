//
//  CustomTabItem.swift
//  Better-IMDB
//
//  Created by dbug on 4/8/25.
//

import UIKit

enum BITabItem: String, CaseIterable {
    case home
    case bookmark
}

extension BITabItem {
    var icon: UIImage? {
        switch self {
            case .home:
                return UIImage(systemName: "house")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
            case .bookmark:
                return UIImage(systemName: "bookmark")?.withTintColor(.white.withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
            case .home:
                return UIImage(systemName: "house.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
            case .bookmark:
                return UIImage(systemName: "bookmark.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        }
    }
    
    var name: String {
        return self.rawValue.capitalized
    }
}
