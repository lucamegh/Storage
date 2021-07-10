/**
 * Storage
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

public struct Storage<Value> {
    
    public var store: (Value?) -> Void
    
    public var restore: () -> Value?
    
    public init(
        store: @escaping (Value?) -> Void,
        restore: @escaping () -> Value?
    ) {
        self.store = store
        self.restore = restore
    }
}

public extension Storage {
    
    var value: Value? {
        get { restore() }
        set { store(newValue) }
    }
    
    func restore(defaultValue: @autoclosure () -> Value) -> Value {
        value ?? defaultValue()
    }
    
    func withConditionalStore(_ condition: @escaping (Value?) -> Bool) -> Self {
        Storage(
            store: { value in
                if condition(value) {
                    store(value)
                }
            },
            restore: restore
        )
    }
    
    func withConditionalRestore(_ condition: @escaping (Value) -> Bool) -> Self {
        Storage(
            store: store,
            restore: {
                if let value = value, condition(value) {
                    return value
                } else {
                    return nil
                }
            }
        )
    }
}
