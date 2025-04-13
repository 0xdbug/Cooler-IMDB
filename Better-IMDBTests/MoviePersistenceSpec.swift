//
//  MoviePersistenceSpec.swift
//  Better-IMDB
//
//  Created by dbug on 4/14/25.
//

import XCTest
import Quick
import Nimble
import RxTest
import RxCocoa
import RxSwift
import SwiftyMocky
@testable import Better_IMDB

class MoviePersistenceSpec: QuickSpec {
    
    override class func spec() {
        describe("MoviePersistence") {
            let bookmarkKey = "bookmarks"
            var mockUserDefaults: UserDefaultsProtocolMock!
            var sut: MoviePersistence!
            
            beforeEach {
                mockUserDefaults = UserDefaultsProtocolMock()
                Given(mockUserDefaults, .array(forKey: .any, willReturn: nil))
            }
            
            describe("toggleBookmark") {
                context("when movie isnt bookmarked") {
                    beforeEach {
                        sut = MoviePersistence(movieId: 111, userDefaults: mockUserDefaults)
                        Given(mockUserDefaults, .array(forKey: .value(bookmarkKey), willReturn: []))
                    }
                    
                    it("should add its id to bookmarks and return true") {
                        let result = sut.toggleBookmark()
                        
                        expect(result).to(beTrue())
                        Verify(mockUserDefaults, 1, .set(.any, forKey: .value(bookmarkKey)))

                    }
                }
                
                context("when movie is bookmarked") {
                    beforeEach {
                        sut = MoviePersistence(movieId: 111, userDefaults: mockUserDefaults)
                        Given(mockUserDefaults, .array(forKey: .value(bookmarkKey), willReturn: [111]))
                    }
                    
                    it("should remove movieId from bookmarks and return false") {
                        let result = sut.toggleBookmark()
                        
                        expect(result).to(beFalse())
                        Verify(mockUserDefaults, 1, .set(.any, forKey: .value(bookmarkKey)))
                    }
                }
                
            }
            
            describe("isBookmarked") {
                context("when movie is not bookmarked") {
                    beforeEach {
                        sut = MoviePersistence(movieId: 111, userDefaults: mockUserDefaults)
                        Given(mockUserDefaults, .array(forKey: .value(bookmarkKey), willReturn: [222, 333]))
                    }
                    
                    it("should return false") {
                        expect(sut.isBookmarked()).to(beFalse())
                    }
                }
                
                context("when movie is bookmarked") {
                    beforeEach {
                        sut = MoviePersistence(movieId: 123, userDefaults: mockUserDefaults)
                        Given(mockUserDefaults, .array(forKey: .value(bookmarkKey), willReturn: [123, 456]))
                    }
                    
                    it("should return true") {
                        expect(sut.isBookmarked()).to(beTrue())
                    }
                }
            }
            
            describe("getAllBookmarks") {
                context("when bookmarks exist") {
                    beforeEach {
                        Given(mockUserDefaults, .array(forKey: .value(bookmarkKey), willReturn: [123, 456, 789]))
                    }
                    
                    it("should return all bookmarked movie ids") {
                        let bookmarks = MoviePersistence.getAllBookmarks(userDefaults: mockUserDefaults)
                        
                        expect(bookmarks).to(equal([123, 456, 789]))
                    }
                }
                
                context("when no bookmarks exist") {
                    beforeEach {
                        Given(mockUserDefaults, .array(forKey: .value(bookmarkKey), willReturn: nil))
                    }
                    
                    it("should return an empty array") {
                        let bookmarks = MoviePersistence.getAllBookmarks(userDefaults: mockUserDefaults)
                        
                        expect(bookmarks).to(beEmpty())
                    }
                }
            }
        }
    }
}
