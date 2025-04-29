//
//  TMDBError.swift
//  Better-IMDB
//
//  Created by dbug on 4/28/25.
//

import UIKit

struct TMDBErrorResponse: Decodable {
    let statusCode: Int?
    let statusMessage: String?
    let success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}

enum TMDBError: Error, LocalizedError {
    case apiError(statusCode: Int, message: String)
    case decodingError(Error)
//    case network(Error)
    case unknown
    
    var errorDescription: String? {
        switch self {
            case .apiError(_, let message):
                return message
            case .decodingError(let error):
                return "Failed to decode response: \(error.localizedDescription)"
            case .unknown:
                return "Unknown error occurred please try again later"
//            case 
        }
    }
}
