//
//  RoutingFormat.swift
//  TypedRouter
//
//  Created by SaitoYuta on 2017/08/27.
//  Copyright © 2017年 bangohan. All rights reserved.
//

public enum ParameterType {
    case intType
    case stringType
    case string(String)
}

public protocol ParameterTypeCompatible {
    static var parameter: ParameterType { get }
}

extension String: ParameterTypeCompatible {
    public static var parameter: ParameterType { return .stringType }
}

extension Int: ParameterTypeCompatible {
    public static var parameter: ParameterType { return .intType }
}

public enum MatchedType {
    case string(String)
    case int(Int)

    public var string: String {
        switch self {
        case .string(let value): return value
        default: fatalError("\(self) is not String")
        }
    }

    public var integer: Int {
        switch self {
        case .int(let value): return value
        default: fatalError("\(self) is not Int")
        }
    }
}

public class RoutingFormat {

    var matching: [ParameterType] = []
    init(first: ParameterType, second: ParameterType) {
        self.matching.append(first)
        self.matching.append(second)
    }

    func isMatch(with pathComponent: [String]) -> Bool {
        if matching.count != pathComponent.count { return false }

        return (0..<matching.count).contains {
            let expect = matching[$0]
            let actual = pathComponent[$0]
            switch expect {
            case .string(let string):
                return string == actual
            case .intType:
                return Int(actual) != nil
            case .stringType:
                return true
            }
        }
    }

    func matchedParameters(with pathComponent: [String]) -> [MatchedType]? {
        guard isMatch(with: pathComponent) else { return nil }
        return (0..<matching.count).flatMap {
            let expect = matching[$0]
            let actual = pathComponent[$0]
            switch expect {
            case .string( _):
                return nil
            case .intType( _):
                return MatchedType.int(Int(actual)!)
            case .stringType( _):
                return MatchedType.string(actual)
            }
        }
    }

    var identifier: String {
        return self.matching.reduce("") {
            return "\($0)/\($1)"
        }
    }
}
