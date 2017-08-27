//
//  Routing.swift
//  TypedRouter
//
//  Created by SaitoYuta on 2017/08/27.
//  Copyright © 2017年 bangohan. All rights reserved.
//

public protocol Routing {
    static var pattern: RoutingFormat { get }
    static var scheme: String { get }

    init(matched: [MatchedType])
}

public extension Routing {
    static var identifier: String {
        return scheme + pattern.identifier
    }

    static func isMatch(with url: URL) -> Bool {
        return pattern.isMatch(with: url.pathComponents) && scheme == url.scheme

    }

    static func matchedParameters(with url: URL) -> [MatchedType]? {
        return pattern.matchedParameters(with: url.pathComponents)
    }
}
