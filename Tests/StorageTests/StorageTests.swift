/**
 * Storage
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import XCTest
@testable import Storage

extension Storage {
    
    static func testing(_: Value.Type) -> Self {
        var value: Value?
        return Storage(
            store: { value = $0 },
            restore: { value }
        )
    }
}

final class StorageTests: XCTestCase {
    
    func testValue() {
        let storage = Storage.testing(Int.self)
        XCTAssertNil(storage.value)
        storage.value = 42
        XCTAssertEqual(storage.value, 42)
        storage.value = nil
        XCTAssertNil(storage.value)
    }
    
    func testRestoreWithDefaultValue() {
        let storage = Storage.testing(Int.self)
        XCTAssertNil(storage.value)
        let value = storage.restore(defaultValue: 42)
        XCTAssertEqual(value, 42)
    }
    
    func testConditionalStore() {
        let storage = Storage.testing(Int.self).withConditionalStore { $0 != 42 }
        storage.store(42)
        XCTAssertNil(storage.value)
    }
    
    func testConditionalRestore() {
        let storage = Storage.testing(Int.self).withConditionalRestore { $0 != 42 }
        storage.store(42)
        XCTAssertNil(storage.value)
    }
}
