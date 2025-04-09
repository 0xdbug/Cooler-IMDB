//
//  tmdb.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit

struct Discover: Codable {
    var page: Int
    var results: [DiscoverResult]
    var total_pages: Int
    var total_results: Int
}

struct DiscoverResult: Codable {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    
    var posterImageURL: URL {
        URL(string: TMDBAPI.imagesURLString + poster_path) ?? URL(string: "")!
    }
    var backdropImageURL: URL {
        URL(string: TMDBAPI.imagesURLString + backdrop_path) ?? URL(string: "")!
    }
}
