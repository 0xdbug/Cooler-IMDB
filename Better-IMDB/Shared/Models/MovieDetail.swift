//
//  MovieDetail.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import UIKit

struct MovieDetail: Codable {
    let adult: Bool
    let backdropPath: String?
    let budget: Double
    let homepage: String
    let id: Int
    let imdbId: String
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let productionCountries: [MovieProduction]
    let releaseDate: String
    let revenue: Int
    let runtime: Int
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var posterImageURL: URL {
        URL(string: TMDBAPI.imagesURLString + posterPath) ?? URL(string: "")!
    }
    var backdropImageURL: URL {
        guard let backdropPath = backdropPath else { return posterImageURL }
        return URL(string: TMDBAPI.backdropURLString + backdropPath) ?? URL(string: "")!
    }
}

struct MovieVideoResponse: Codable {
    let id: Int
    let results: [VideoResult]
}

struct VideoResult: Codable {
    let iso639_1: String
    let iso3166_1: String
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case key
        case site
        case size
        case type
        case official
        case publishedAt = "published_at"
        case id
    }
}

struct MovieGenre: Codable {
    let id: Int
    let name: String
}

struct MovieProduction: Codable {
    let iso3166_1: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

extension MovieDetail: Equatable {
    static func == (lhs: MovieDetail, rhs: MovieDetail) -> Bool {
        return lhs.id == rhs.id
    }
}
