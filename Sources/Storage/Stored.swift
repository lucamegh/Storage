/**
 * Storage
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

@propertyWrapper
public struct Stored<Value> {
    
    public var wrappedValue: Value {
        get { storage.value ?? defaultValue }
        set { storage.value = newValue }
    }
        
    private let defaultValue: Value
    
    private var storage: Storage<Value>
    
    public init(wrappedValue defaultValue: Value, storage: Storage<Value>) {
        self.defaultValue = defaultValue
        self.storage = storage
    }
}
