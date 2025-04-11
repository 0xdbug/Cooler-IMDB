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

class PopularRequest: APIRequest {
    var method = RequestType.GET
    var path = TMDBAPI.popular
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

class TrendingRequest: APIRequest {
    var method = RequestType.GET
    var path = TMDBAPI.trending
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

class TopRatedRequest: APIRequest {
    var method = RequestType.GET
    var path = TMDBAPI.topRated
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

class UpcomingRequest: APIRequest {
    var method = RequestType.GET
    var path = TMDBAPI.upcoming
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
