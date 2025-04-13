// Generated using Sourcery 1.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.6.0


import SwiftyMocky
import XCTest
import RxSwift
import UIKit
@testable import Better_IMDB


// MARK: - MovieDetailNetworkServiceProtocol

open class MovieDetailNetworkServiceProtocolMock: MovieDetailNetworkServiceProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func fetchMovie(withId id: String) -> Observable<MovieDetail> {
        addInvocation(.m_fetchMovie__withId_id(Parameter<String>.value(`id`)))
		let perform = methodPerformValue(.m_fetchMovie__withId_id(Parameter<String>.value(`id`))) as? (String) -> Void
		perform?(`id`)
		var __value: Observable<MovieDetail>
		do {
		    __value = try methodReturnValue(.m_fetchMovie__withId_id(Parameter<String>.value(`id`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchMovie(withId id: String). Use given")
			Failure("Stub return value not specified for fetchMovie(withId id: String). Use given")
		}
		return __value
    }

    open func fetchVideoURLString(withId id: Int) -> Observable<String> {
        addInvocation(.m_fetchVideoURLString__withId_id(Parameter<Int>.value(`id`)))
		let perform = methodPerformValue(.m_fetchVideoURLString__withId_id(Parameter<Int>.value(`id`))) as? (Int) -> Void
		perform?(`id`)
		var __value: Observable<String>
		do {
		    __value = try methodReturnValue(.m_fetchVideoURLString__withId_id(Parameter<Int>.value(`id`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchVideoURLString(withId id: Int). Use given")
			Failure("Stub return value not specified for fetchVideoURLString(withId id: Int). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_fetchMovie__withId_id(Parameter<String>)
        case m_fetchVideoURLString__withId_id(Parameter<Int>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_fetchMovie__withId_id(let lhsId), .m_fetchMovie__withId_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "withId id"))
				return Matcher.ComparisonResult(results)

            case (.m_fetchVideoURLString__withId_id(let lhsId), .m_fetchVideoURLString__withId_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "withId id"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_fetchMovie__withId_id(p0): return p0.intValue
            case let .m_fetchVideoURLString__withId_id(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_fetchMovie__withId_id: return ".fetchMovie(withId:)"
            case .m_fetchVideoURLString__withId_id: return ".fetchVideoURLString(withId:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func fetchMovie(withId id: Parameter<String>, willReturn: Observable<MovieDetail>...) -> MethodStub {
            return Given(method: .m_fetchMovie__withId_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchVideoURLString(withId id: Parameter<Int>, willReturn: Observable<String>...) -> MethodStub {
            return Given(method: .m_fetchVideoURLString__withId_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchMovie(withId id: Parameter<String>, willProduce: (Stubber<Observable<MovieDetail>>) -> Void) -> MethodStub {
            let willReturn: [Observable<MovieDetail>] = []
			let given: Given = { return Given(method: .m_fetchMovie__withId_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<MovieDetail>).self)
			willProduce(stubber)
			return given
        }
        public static func fetchVideoURLString(withId id: Parameter<Int>, willProduce: (Stubber<Observable<String>>) -> Void) -> MethodStub {
            let willReturn: [Observable<String>] = []
			let given: Given = { return Given(method: .m_fetchVideoURLString__withId_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<String>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fetchMovie(withId id: Parameter<String>) -> Verify { return Verify(method: .m_fetchMovie__withId_id(`id`))}
        public static func fetchVideoURLString(withId id: Parameter<Int>) -> Verify { return Verify(method: .m_fetchVideoURLString__withId_id(`id`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fetchMovie(withId id: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_fetchMovie__withId_id(`id`), performs: perform)
        }
        public static func fetchVideoURLString(withId id: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_fetchVideoURLString__withId_id(`id`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - TMDBNetworkServiceProtocol

open class TMDBNetworkServiceProtocolMock: TMDBNetworkServiceProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func popular(page: Int) -> Observable<TMDBMovies> {
        addInvocation(.m_popular__page_page(Parameter<Int>.value(`page`)))
		let perform = methodPerformValue(.m_popular__page_page(Parameter<Int>.value(`page`))) as? (Int) -> Void
		perform?(`page`)
		var __value: Observable<TMDBMovies>
		do {
		    __value = try methodReturnValue(.m_popular__page_page(Parameter<Int>.value(`page`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for popular(page: Int). Use given")
			Failure("Stub return value not specified for popular(page: Int). Use given")
		}
		return __value
    }

    open func trending(page: Int) -> Observable<TMDBMovies> {
        addInvocation(.m_trending__page_page(Parameter<Int>.value(`page`)))
		let perform = methodPerformValue(.m_trending__page_page(Parameter<Int>.value(`page`))) as? (Int) -> Void
		perform?(`page`)
		var __value: Observable<TMDBMovies>
		do {
		    __value = try methodReturnValue(.m_trending__page_page(Parameter<Int>.value(`page`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for trending(page: Int). Use given")
			Failure("Stub return value not specified for trending(page: Int). Use given")
		}
		return __value
    }

    open func topRated(page: Int) -> Observable<TMDBMovies> {
        addInvocation(.m_topRated__page_page(Parameter<Int>.value(`page`)))
		let perform = methodPerformValue(.m_topRated__page_page(Parameter<Int>.value(`page`))) as? (Int) -> Void
		perform?(`page`)
		var __value: Observable<TMDBMovies>
		do {
		    __value = try methodReturnValue(.m_topRated__page_page(Parameter<Int>.value(`page`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for topRated(page: Int). Use given")
			Failure("Stub return value not specified for topRated(page: Int). Use given")
		}
		return __value
    }

    open func upcoming(page: Int) -> Observable<TMDBMovies> {
        addInvocation(.m_upcoming__page_page(Parameter<Int>.value(`page`)))
		let perform = methodPerformValue(.m_upcoming__page_page(Parameter<Int>.value(`page`))) as? (Int) -> Void
		perform?(`page`)
		var __value: Observable<TMDBMovies>
		do {
		    __value = try methodReturnValue(.m_upcoming__page_page(Parameter<Int>.value(`page`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for upcoming(page: Int). Use given")
			Failure("Stub return value not specified for upcoming(page: Int). Use given")
		}
		return __value
    }

    open func fetchMovies(ids: [Int]) -> Observable<[MovieDetail]> {
        addInvocation(.m_fetchMovies__ids_ids(Parameter<[Int]>.value(`ids`)))
		let perform = methodPerformValue(.m_fetchMovies__ids_ids(Parameter<[Int]>.value(`ids`))) as? ([Int]) -> Void
		perform?(`ids`)
		var __value: Observable<[MovieDetail]>
		do {
		    __value = try methodReturnValue(.m_fetchMovies__ids_ids(Parameter<[Int]>.value(`ids`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetchMovies(ids: [Int]). Use given")
			Failure("Stub return value not specified for fetchMovies(ids: [Int]). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_popular__page_page(Parameter<Int>)
        case m_trending__page_page(Parameter<Int>)
        case m_topRated__page_page(Parameter<Int>)
        case m_upcoming__page_page(Parameter<Int>)
        case m_fetchMovies__ids_ids(Parameter<[Int]>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_popular__page_page(let lhsPage), .m_popular__page_page(let rhsPage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPage, rhs: rhsPage, with: matcher), lhsPage, rhsPage, "page"))
				return Matcher.ComparisonResult(results)

            case (.m_trending__page_page(let lhsPage), .m_trending__page_page(let rhsPage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPage, rhs: rhsPage, with: matcher), lhsPage, rhsPage, "page"))
				return Matcher.ComparisonResult(results)

            case (.m_topRated__page_page(let lhsPage), .m_topRated__page_page(let rhsPage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPage, rhs: rhsPage, with: matcher), lhsPage, rhsPage, "page"))
				return Matcher.ComparisonResult(results)

            case (.m_upcoming__page_page(let lhsPage), .m_upcoming__page_page(let rhsPage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPage, rhs: rhsPage, with: matcher), lhsPage, rhsPage, "page"))
				return Matcher.ComparisonResult(results)

            case (.m_fetchMovies__ids_ids(let lhsIds), .m_fetchMovies__ids_ids(let rhsIds)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIds, rhs: rhsIds, with: matcher), lhsIds, rhsIds, "ids"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_popular__page_page(p0): return p0.intValue
            case let .m_trending__page_page(p0): return p0.intValue
            case let .m_topRated__page_page(p0): return p0.intValue
            case let .m_upcoming__page_page(p0): return p0.intValue
            case let .m_fetchMovies__ids_ids(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_popular__page_page: return ".popular(page:)"
            case .m_trending__page_page: return ".trending(page:)"
            case .m_topRated__page_page: return ".topRated(page:)"
            case .m_upcoming__page_page: return ".upcoming(page:)"
            case .m_fetchMovies__ids_ids: return ".fetchMovies(ids:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func popular(page: Parameter<Int>, willReturn: Observable<TMDBMovies>...) -> MethodStub {
            return Given(method: .m_popular__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func trending(page: Parameter<Int>, willReturn: Observable<TMDBMovies>...) -> MethodStub {
            return Given(method: .m_trending__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func topRated(page: Parameter<Int>, willReturn: Observable<TMDBMovies>...) -> MethodStub {
            return Given(method: .m_topRated__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func upcoming(page: Parameter<Int>, willReturn: Observable<TMDBMovies>...) -> MethodStub {
            return Given(method: .m_upcoming__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetchMovies(ids: Parameter<[Int]>, willReturn: Observable<[MovieDetail]>...) -> MethodStub {
            return Given(method: .m_fetchMovies__ids_ids(`ids`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func popular(page: Parameter<Int>, willProduce: (Stubber<Observable<TMDBMovies>>) -> Void) -> MethodStub {
            let willReturn: [Observable<TMDBMovies>] = []
			let given: Given = { return Given(method: .m_popular__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<TMDBMovies>).self)
			willProduce(stubber)
			return given
        }
        public static func trending(page: Parameter<Int>, willProduce: (Stubber<Observable<TMDBMovies>>) -> Void) -> MethodStub {
            let willReturn: [Observable<TMDBMovies>] = []
			let given: Given = { return Given(method: .m_trending__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<TMDBMovies>).self)
			willProduce(stubber)
			return given
        }
        public static func topRated(page: Parameter<Int>, willProduce: (Stubber<Observable<TMDBMovies>>) -> Void) -> MethodStub {
            let willReturn: [Observable<TMDBMovies>] = []
			let given: Given = { return Given(method: .m_topRated__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<TMDBMovies>).self)
			willProduce(stubber)
			return given
        }
        public static func upcoming(page: Parameter<Int>, willProduce: (Stubber<Observable<TMDBMovies>>) -> Void) -> MethodStub {
            let willReturn: [Observable<TMDBMovies>] = []
			let given: Given = { return Given(method: .m_upcoming__page_page(`page`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<TMDBMovies>).self)
			willProduce(stubber)
			return given
        }
        public static func fetchMovies(ids: Parameter<[Int]>, willProduce: (Stubber<Observable<[MovieDetail]>>) -> Void) -> MethodStub {
            let willReturn: [Observable<[MovieDetail]>] = []
			let given: Given = { return Given(method: .m_fetchMovies__ids_ids(`ids`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Observable<[MovieDetail]>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func popular(page: Parameter<Int>) -> Verify { return Verify(method: .m_popular__page_page(`page`))}
        public static func trending(page: Parameter<Int>) -> Verify { return Verify(method: .m_trending__page_page(`page`))}
        public static func topRated(page: Parameter<Int>) -> Verify { return Verify(method: .m_topRated__page_page(`page`))}
        public static func upcoming(page: Parameter<Int>) -> Verify { return Verify(method: .m_upcoming__page_page(`page`))}
        public static func fetchMovies(ids: Parameter<[Int]>) -> Verify { return Verify(method: .m_fetchMovies__ids_ids(`ids`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func popular(page: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_popular__page_page(`page`), performs: perform)
        }
        public static func trending(page: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_trending__page_page(`page`), performs: perform)
        }
        public static func topRated(page: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_topRated__page_page(`page`), performs: perform)
        }
        public static func upcoming(page: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_upcoming__page_page(`page`), performs: perform)
        }
        public static func fetchMovies(ids: Parameter<[Int]>, perform: @escaping ([Int]) -> Void) -> Perform {
            return Perform(method: .m_fetchMovies__ids_ids(`ids`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - UserDefaultsProtocol

open class UserDefaultsProtocolMock: UserDefaultsProtocol, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func array(forKey defaultName: String) -> [Any]? {
        addInvocation(.m_array__forKey_defaultName(Parameter<String>.value(`defaultName`)))
		let perform = methodPerformValue(.m_array__forKey_defaultName(Parameter<String>.value(`defaultName`))) as? (String) -> Void
		perform?(`defaultName`)
		var __value: [Any]? = nil
		do {
		    __value = try methodReturnValue(.m_array__forKey_defaultName(Parameter<String>.value(`defaultName`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func set(_ value: Any?, forKey defaultName: String) {
        addInvocation(.m_set__valueforKey_defaultName(Parameter<Any?>.value(`value`), Parameter<String>.value(`defaultName`)))
		let perform = methodPerformValue(.m_set__valueforKey_defaultName(Parameter<Any?>.value(`value`), Parameter<String>.value(`defaultName`))) as? (Any?, String) -> Void
		perform?(`value`, `defaultName`)
    }


    fileprivate enum MethodType {
        case m_array__forKey_defaultName(Parameter<String>)
        case m_set__valueforKey_defaultName(Parameter<Any?>, Parameter<String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_array__forKey_defaultName(let lhsDefaultname), .m_array__forKey_defaultName(let rhsDefaultname)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDefaultname, rhs: rhsDefaultname, with: matcher), lhsDefaultname, rhsDefaultname, "forKey defaultName"))
				return Matcher.ComparisonResult(results)

            case (.m_set__valueforKey_defaultName(let lhsValue, let lhsDefaultname), .m_set__valueforKey_defaultName(let rhsValue, let rhsDefaultname)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsValue, rhs: rhsValue, with: matcher), lhsValue, rhsValue, "_ value"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDefaultname, rhs: rhsDefaultname, with: matcher), lhsDefaultname, rhsDefaultname, "forKey defaultName"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_array__forKey_defaultName(p0): return p0.intValue
            case let .m_set__valueforKey_defaultName(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_array__forKey_defaultName: return ".array(forKey:)"
            case .m_set__valueforKey_defaultName: return ".set(_:forKey:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func array(forKey defaultName: Parameter<String>, willReturn: [Any]?...) -> MethodStub {
            return Given(method: .m_array__forKey_defaultName(`defaultName`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func array(forKey defaultName: Parameter<String>, willProduce: (Stubber<[Any]?>) -> Void) -> MethodStub {
            let willReturn: [[Any]?] = []
			let given: Given = { return Given(method: .m_array__forKey_defaultName(`defaultName`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: ([Any]?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func array(forKey defaultName: Parameter<String>) -> Verify { return Verify(method: .m_array__forKey_defaultName(`defaultName`))}
        public static func set(_ value: Parameter<Any?>, forKey defaultName: Parameter<String>) -> Verify { return Verify(method: .m_set__valueforKey_defaultName(`value`, `defaultName`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func array(forKey defaultName: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_array__forKey_defaultName(`defaultName`), performs: perform)
        }
        public static func set(_ value: Parameter<Any?>, forKey defaultName: Parameter<String>, perform: @escaping (Any?, String) -> Void) -> Perform {
            return Perform(method: .m_set__valueforKey_defaultName(`value`, `defaultName`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

