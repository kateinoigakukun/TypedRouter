//
//  Operator.swift
//  TypedRouter
//
//  Created by SaitoYuta on 2017/08/27.
//  Copyright © 2017年 bangohan. All rights reserved.
//

precedencegroup Composition { associativity: left }
infix operator /+/ : Composition

public func /+/(rhs: RoutingFormat, lhs: String) -> RoutingFormat {
    rhs.matching.append(.string(lhs))
    return rhs
}

public func /+/(rhs: RoutingFormat, lhs: ParameterType) -> RoutingFormat {
    rhs.matching.append(lhs)
    return rhs
}

public func /+/(rhs: String, lhs: ParameterType) -> RoutingFormat {
    return RoutingFormat(first: .string(rhs), second: lhs)
}

public func /+/(rhs: ParameterType, lhs: ParameterType) -> RoutingFormat {
    return RoutingFormat(first: rhs, second: lhs)
}

public func /+/(rhs: ParameterType, lhs: String) -> RoutingFormat {
    return RoutingFormat(first: rhs, second: .string(lhs))
}
