//
//  tmdb.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit

struct HomeCards {
    let cardName: String
    let cardType: MovieSection
    let movies: [Movie]
    
}

struct TMDBMovies: Codable {
    var page: Int
    var results: [Movie]
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var posterImageURL: URL {
        URL(string: TMDBAPI.imagesURLString + posterPath) ?? URL(string: "")!
    }
    var backdropImageURL: URL {
        guard let backdropPath = backdropPath else { return URL(string: "")! }
        return URL(string: TMDBAPI.backdropURLString + backdropPath) ?? URL(string: "")!
    }
}


extension Movie: Equatable {
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
