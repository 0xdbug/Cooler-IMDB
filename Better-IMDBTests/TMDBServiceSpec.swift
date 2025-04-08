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
        // TMDBServiceSpec should returned expected discover
        describe("TMDBServiceSpec") {
            var sut: TMDBService!
            var viewModel: HomeViewModel!
            var disposeBag: DisposeBag!
            var scheduler: TestScheduler!
            var discoverObserver: TestableObserver<Discover>!
            
            beforeEach {
                disposeBag = DisposeBag()
                scheduler = TestScheduler(initialClock: 0)
                sut = TMDBService()
                viewModel = HomeViewModel(networkService: sut)
                
                discoverObserver = scheduler.createObserver(Discover.self)
                viewModel.items.bind(to: discoverObserver).disposed(by: disposeBag)
            }
            
            it("should return expected result") {
                viewModel.fetchItems()
                scheduler.start()
                
                expect(discoverObserver.events.count).toEventually(equal(1))
            }
        }
    }
}
