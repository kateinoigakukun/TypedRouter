# TypedRouter

[![Build Status](https://travis-ci.org/kateinoigakukun/TypedRouter.svg?branch=master)](https://travis-ci.org/kateinoigakukun/TypedRouter)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/kateinoigakukun/TypedRouter)


TypedRouter provides Type safe router to use with custom URLScheme or UniversalLink in iOS project.

## Usage

Route for `custom-urlscheme://users/123`

### Routing
Define `Routing` struct for each routing.
- `scheme`
  - should be custom url scheme or UniversalLink scheme(ex. https)
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
    // protocol requirement
    var handlers: [Router.Identifier : ((Routing) -> Void)] = [:]
    var routes: [Router.Identifier : Routing.Type] = [:]

    static var shared: URLRouter = .init()
    private var window: UIWindow!
    private init() {}

    mutating func setup(with window: UIWindow) {
        self.window = window

        register(routing: UserRouting.self) { (route: UserRouting) in
            print(route.id) // 123
            // Initialize your ViewController
        }
    }
}
```

In `AppDelegate.swift`

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {

    ....
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        return URLRouter.shared.run(with: url)
    }
}
```


## Installation

### Carthage
```
github "kateinoigakukun/TypedRouter"
```
