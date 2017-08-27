//
//  Router.swift
//  TypedRouter
//
//  Created by SaitoYuta on 2017/08/27.
//  Copyright © 2017年 bangohan. All rights reserved.
//

import Foundation

public protocol Router {
    typealias Identifier = String
    var routes: [Identifier: Routing.Type] { get set }
    var handlers: [Identifier: ((Routing) -> Void)] { get set }
    mutating func register<R: Routing>(routing: R.Type, handler: @escaping (R) -> Void)
    mutating func run(with url: URL) -> Bool
}

public extension Router {
    mutating func register<R: Routing>(routing: R.Type, handler: @escaping (R) -> Void) {
        routes[routing.identifier] = routing
        handlers[routing.identifier] = { r in
            handler(r as! R)
        }
    }

    mutating func run(with url: URL) -> Bool {
        guard let (key, route) = routes.first(where: { $1.isMatch(with: url) }) else { return false }
        guard let parameters = route.matchedParameters(with: url) else { return false }
        handlers[key]?(route.init(matched: parameters))
        return true
    }
}
