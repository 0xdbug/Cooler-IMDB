//
//  MovieDetailRequest.swift
//  Better-IMDB
//
//  Created by dbug on 4/12/25.
//

import Foundation

class MovieDetailRequest: APIRequest {
    var method = RequestType.GET
    var path = TMDBAPI.movieDetail
    var auth = TMDBAPI.auth
    var parameters: [String: String]
    
    init(id: String) {
        self.parameters = [
            "language": "en-US",
        ]
        self.path += "\(id)"
    }
}
