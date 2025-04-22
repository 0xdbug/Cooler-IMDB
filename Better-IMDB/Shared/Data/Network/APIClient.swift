//
//  APIClient.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import Foundation
import RxSwift
import RxCocoa

// repository pattern
protocol APIClient {
    var baseURL: URL { get set }
    var scheduler: SchedulerType { get set }
}
