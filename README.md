# TypedRouter

[![Build Status](https://travis-ci.org/kateinoigakukun/TypedRouter.svg?branch=master)](https://travis-ci.org/kateinoigakukun/TypedRouter)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/kateinoigakukun/TypedRouter)


TypedRouter provides Type safe router for custom URLScheme or UniversalLink in iOS project.

## Usage

Example for `custom-urlscheme://users/123`

### Routing
Define `Routing` struct for each routing.
- `scheme`
  - custom url scheme or UniversalLink scheme(ex. https)
- `pattern` is URL path pattern. 
  - Use `String.parameter`, `Int.parameter` or string literal. 
  - And combine them with `/+/` operator.
- `init(matched: [MatchedType])`
  - Maps pattern matched parameter.
  
```swift
struct UserRouting: Routing {
    static var scheme: String { return "custom-urlscheme" }
    static var pattern: RoutingFormat { return "users"/+/Int.parameter }

    let id: Int

    init(matched: [MatchedType]) {
        id = matched[0].integer
    }
}
```

### Router

Define `Router` struct.
- `register(routing:handler:)` 
  - register `Routing` and handle mapped url.
```swift
struct URLRouter: Router {
    var handlers: [Router.Identifier : ((Routing) -> Void)] = [:]
    var routes: [Router.Identifier : Routing.Type] = [:]
}

let router = URLRouter()
router.register(routing: UserRouting.self) { (route: UserRouting) in
    print(route.id) // 123
}

let url = URL(string: "custom-urlscheme://users/123")!
router.run(with: url)
```

## TODO

 - [ ] Query parameter

## Installation

### Carthage
```
github "kateinoigakukun/TypedRouter" "master"
```
