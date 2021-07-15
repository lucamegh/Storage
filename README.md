# Storage 🧳

Functional storage abstraction layer.

```swift
struct Storage<Value> {
    
    var store: (Value?) -> Void
    
    var restore: () -> Value?
}
```

## Installation

Storage is distributed using [Swift Package Manager](https://swift.org/package-manager). To install it into a project, simply add it as a dependency within your Package.swift manifest:
```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/lucamegh/Storage", from: "1.0.0")
    ],
    ...
)
```
