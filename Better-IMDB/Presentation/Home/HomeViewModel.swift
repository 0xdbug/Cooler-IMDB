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
    var items: PublishRelay<Discover> = .init()
    
    init(networkService: HomeNetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchItems() {
        networkService.discover().subscribe(
            onNext: { e in
                self.items.accept(e)
            }, onError: { err in
                print(err)
            }
        ).disposed(by: disposeBag)
    }    
}
