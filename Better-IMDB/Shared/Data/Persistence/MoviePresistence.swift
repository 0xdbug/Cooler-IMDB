//
//  MoviePresistence.swift
//  Better-IMDB
//
//  Created by dbug on 4/13/25.
//

import UIKit

class MoviePersistence {
    private let key: String = "bookmarks"
    private let movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    func toggleBookmark() -> Bool {
        var bookmarks = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
        
        if let index = bookmarks.firstIndex(of: movieId) {
            bookmarks.remove(at: index)
            UserDefaults.standard.set(bookmarks, forKey: key)
            return false
        } else {
            bookmarks.append(movieId)
            UserDefaults.standard.set(bookmarks, forKey: key)
            return true
        }
    }
    
    func isBookmarked() -> Bool {
        let bookmarks = UserDefaults.standard.array(forKey: key) as? [Int] ?? []
        return bookmarks.contains(movieId)
    }
    
    static func getAllBookmarks() -> [String] {
        return UserDefaults.standard.stringArray(forKey: "bookmarks") ?? []
    }
}
