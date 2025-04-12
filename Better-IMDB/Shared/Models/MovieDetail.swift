//
//  MovieDetail.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import UIKit

struct MovieDetail: Codable {
    let adult: Bool
    let backdrop_path: String
    let budget: Double
    let homepage: String
    let id: Int
    let imdb_id: String
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let production_countries: [MovieProduction]
    let release_date: String
    let revenue: Int
    let runtime: Int
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    
    var posterImageURL: URL {
        URL(string: TMDBAPI.imagesURLString + poster_path) ?? URL(string: "")!
    }
    var backdropImageURL: URL {
        URL(string: TMDBAPI.backdropURLString + backdrop_path) ?? URL(string: "")!
    }
}

struct MovieVideoResponse: Codable {
    let id: Int
    let results: [VideoResult]
}

struct VideoResult: Codable {
    let iso_639_1: String
    let iso_3166_1: String
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let published_at: String
    let id: String
}


struct MovieGenre: Codable {
    let id: Int
    let name: String
}

struct MovieProduction: Codable {
    let iso_3166_1: String
    let name: String
}

extension MovieDetail: Equatable {
    static func == (lhs: MovieDetail, rhs: MovieDetail) -> Bool {
        return lhs.id == rhs.id
    }
}
