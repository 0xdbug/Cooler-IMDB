//
//  BookmarkViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

class BookmarkViewModel {
    let networkService: TMDBNetworkServiceProtocol
    
    private let disposeBag = DisposeBag()
    var items: BehaviorRelay<[HomeCards]> = .init(value: [])
    
    init(networkService: TMDBNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
}
