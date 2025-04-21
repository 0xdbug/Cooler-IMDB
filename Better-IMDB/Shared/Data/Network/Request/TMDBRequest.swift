//
//  TMDBRequest.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import Foundation

class DiscoverRequest: APIRequest {
    var method = RequestType.GET
    var path = TMDBAPI.discover
    var auth = TMDBAPI.auth
    var parameters: [String: String]
    
    init(page: Int = 1) {
        self.parameters = [
            "include_adult": "false",
            "include_video": "false",
            "language": "en-US",
            "page": "\(page)",
            "sort_by": "popularity.desc",
        ]
    }
}

class SectionRequest: APIRequest {
    var path: String
    var method = RequestType.GET
    var auth = TMDBAPI.auth
    var parameters: [String: String]
    
    init(path: String, page: Int = 1) {
        self.parameters = [
            "include_adult": "false",
            "include_video": "false",
            "language": "en-US",
            "sort_by": "popularity.desc",
        ]
        self.path = path
    }
}

