# Storage 🧳

When it comes to persisting data in our apps, we have plenty of choice: `UserDefaults`, `NSUbiquitousKeyValueStore`, Core Data, disk, you name it. What we are often missing is a common abstraction layer between all these storage types. Enter Storage, the functional storage abstraction layer.

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

## Usage

Storage comes with different built-in storages to cover the most common use cases.

To store a value in `UserDefaults.standard` create a storage using the `Stoarge.userDefaults` static factory method:

```swift
let storage = Storage<User>.userDefaults(key: "logged-user-key")
storage.store(loggedUser)
```

You can optionally provide your own `UserDefaults`, or customize how your models gets encoded and decoded.

Other default storages include `disk` and `ubiquitousKeyValueStore`.

Use high-order storages to adjust storing/restoring behavior.

```swift
var weatherStorage: Storage<WeatherReport> = ...
weatherStorage = storage.withConditionalRestore { report in
    let oneHourAgo = Calendar.current.date(byAdding: .hour, value: -1, to: Date())!
    return report.timestamp > oneHourAgo
}
weatherStorage.restore() // nil if weather report is older than an hour
```

Storage comes with a convenient property wrapper to simplify working with storages even further:
```swift
@Stored(storage: .userDefaults(key: "isFirstLaunch") var isFirstLaunch = true
```

Since every storage is an instance of the very same `Storage<Value>` type, you can swap storages in-line to make your tests easier to write:

```swift
let viewModel = UserViewModel(
    userStorage: Storage(
        restore: { User(firstName: "John", lastName: "Appleseed") },
        store: { _ in fatalError() }
    )
)
XCTAssertEqual(viewModel.fullName, "John Appleseed")
```
