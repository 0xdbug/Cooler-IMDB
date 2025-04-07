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
    var parameters = [
        "include_adult": "false",
        "include_video": "false",
        "language": "en-US",
        "page": "1",
        "sort_by": "popularity.desc",
    ]
}
