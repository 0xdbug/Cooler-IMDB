//
//  HomeViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import UIKit
import RxSwift
import RxCocoa

protocol HomeNetworkServiceProtocol {
    func discover() -> Observable<Discover>
}

class HomeViewModel {
    let networkService: HomeNetworkServiceProtocol
    
    private let disposeBag = DisposeBag()
    var discover: PublishRelay<Discover> = .init()
    var items: PublishRelay<[DiscoverResult]> = .init()
    
    init(networkService: HomeNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchItems() {
        networkService.discover().subscribe(
            onNext: { e in
                self.discover.accept(e)
                self.items.accept(e.results)
            }, onError: { err in
                print(err)
            }
        ).disposed(by: disposeBag)
    }    
}
