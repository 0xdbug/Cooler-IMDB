//
//  TMDBServiceSpec.swift
//  Better-IMDB
//
//  Created by dbug on 4/7/25.
//

import XCTest
import Quick
import Nimble
import RxTest
import RxCocoa
import RxSwift
@testable import Better_IMDB

class TMDBServiceSpec: QuickSpec {
    override class func spec() {
        describe("TMDBServiceSpec") {
            var sut: TMDBService!
            var viewModel: HomeViewModel!
            var disposeBag: DisposeBag!
            var scheduler: TestScheduler!
            var observer: TestableObserver<[HomeCards]>!
            
            beforeEach {
                disposeBag = DisposeBag()
                scheduler = TestScheduler(initialClock: 0)
                sut = TMDBService()
                viewModel = HomeViewModel(networkService: sut)
                
                observer = scheduler.createObserver([HomeCards].self)
                viewModel.items.bind(to: observer).disposed(by: disposeBag)
            }
            
            it("should fill view model items") {
                viewModel.fetchItems()
                scheduler.start()
                
                expect(observer.events.count).toEventually(equal(5))
            }
        }
    }
}
