//
//  ViewModel.swift
//  Better-IMDB
//
//  Created by dbug on 4/23/25.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel: NSObject {
    let disposeBag = DisposeBag()
    
    private let loadingRelay = BehaviorRelay<Bool>(value: false)
    var isLoading: Driver<Bool> {
        return loadingRelay.asDriver()
    }
    
    private let errorRelay = PublishRelay<Error>()
    var error: Observable<Error> {
        return errorRelay.asObservable()
    }
    
    func startLoading() {
        loadingRelay.accept(true)
    }
    
    func stopLoading() {
        loadingRelay.accept(false)
    }
    
    func handleError(_ error: Error) {
        errorRelay.accept(error)
    }
}
