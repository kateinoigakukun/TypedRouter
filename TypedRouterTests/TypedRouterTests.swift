//
//  TypedRouterTests.swift
//  TypedRouterTests
//
//  Created by SaitoYuta on 2017/08/27.
//  Copyright © 2017年 bangohan. All rights reserved.
//

import XCTest
@testable import TypedRouter

struct URLSchemeRouter: Router {
    var routes: [Router.Identifier : Routing.Type] = [:]
    var handlers: [Router.Identifier : ((Routing) -> Void)] = [:]
}

struct TweetRouting: Routing {
    static var scheme: String {
        return "twitter"
    }
    static var pattern: RoutingFormat {
        return "status"/+/Int.parameter
    }

    let id: Int

    init(matched: [MatchedType]) {
        id = matched[0].integer
    }
}

class TweetDetailViewController: UIViewController {
//    init(statusId: Int)
}

class TypedRouterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMatch() {
        let url = URL(string: "twitter://status/1234")!
        XCTAssertTrue(TweetRouting.isMatch(with: url))
        let params = TweetRouting.matchedParameters(with: url)!
        XCTAssertEqual(params.first?.integer, 1234)
    }

    func testRoute() {

        let routeExpectation = expectation(description: "Route url")
        var router = URLSchemeRouter()
        router.register(routing: TweetRouting.self) { (route) in
            XCTAssertEqual(route.id, 1234)
            routeExpectation.fulfill()
        }

        let url = URL(string: "twitter://status/1234")!
        let delegateReturn = router.run(with: url)

        XCTAssertTrue(delegateReturn)
        waitForExpectations(timeout: 0.5, handler: nil)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
