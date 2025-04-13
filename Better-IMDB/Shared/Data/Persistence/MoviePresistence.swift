//
//  MoviePresistence.swift
//  Better-IMDB
//
//  Created by dbug on 4/13/25.
//

import UIKit

// sourcery: AutoMockable
protocol UserDefaultsProtocol {
    func array(forKey defaultName: String) -> [Any]?
    func set(_ value: Any?, forKey defaultName: String)
}

extension UserDefaults: UserDefaultsProtocol {}

class MoviePersistence {
    private let key: String = "bookmarks"
    private let movieId: Int
    private let userDefaults: UserDefaultsProtocol
    
    init(movieId: Int, userDefaults: UserDefaultsProtocol = UserDefaults.standard) {
        self.movieId = movieId
        self.userDefaults = userDefaults
    }
    
    func toggleBookmark() -> Bool {
        var bookmarks = userDefaults.array(forKey: key) as? [Int] ?? []
        
        if let index = bookmarks.firstIndex(of: movieId) {
            bookmarks.remove(at: index)
            userDefaults.set(bookmarks, forKey: key)
            return false
        } else {
            bookmarks.append(movieId)
            userDefaults.set(bookmarks, forKey: key)
            return true
        }
    }
    
    func isBookmarked() -> Bool {
        let bookmarks = userDefaults.array(forKey: key) as? [Int] ?? []
        return bookmarks.contains(movieId)
    }
    
    static func getAllBookmarks(userDefaults: UserDefaultsProtocol = UserDefaults.standard) -> [Int] {
        return (userDefaults.array(forKey: "bookmarks") ?? []) as? [Int] ?? []
    }
}
