//
//  TMDBAPI.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import Foundation

struct TMDBAPI {
    static let baseURLString = "https://api.themoviedb.org/3"
    static let imagesURLString = "https://image.tmdb.org/t/p/w500"
    static let backdropURLString = "https://image.tmdb.org/t/p/original"
    
    static let discover = "/discover/movie"
    static let movieDetail = "/movie/"
    
    static func moviesForSection(_ section: MovieSection) -> String {
        section == .trending ? "/trending/movie/\(section.rawValue)" : "/movie/\(section.rawValue)"
    }
    
    static func movieVideo(id: Int) -> String {
        return "/movie/\(id)/videos"
    }
    
    static func playMovieVideo(key: String) -> String {
        return "https://www.themoviedb.org/video/play?key=\(key)&width=1920&height=1080"
    }
    
    // remove from source code
    static let auth = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0Y2RjYzZkMmExN2VjNTRkYTc2ZmUyN2M3NjUzYjVkYSIsIm5iZiI6MTc0NDAwNzk0Ny43NjQsInN1YiI6IjY3ZjM3MzBiYTU0NzFhNTFlZTk5NTFiNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1FWok1iINCCMvFdjCKAx_ZM7-OwXvJV5pla651Z301o"
}
