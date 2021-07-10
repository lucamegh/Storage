/**
 * Storage
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

public extension Storage {
    
    static func ubiquitousKeyValueStore(
        key: String,
        encode: @escaping (Value) -> Data?,
        decode: @escaping (Data) -> Value?,
        store: NSUbiquitousKeyValueStore = .default
    ) -> Self {
        Storage(
            store: { value in
                guard let data = value.flatMap(encode) else { return }
                store.set(data, forKey: key)
            },
            restore: {
                guard let data = store.data(forKey: key) else { return nil }
                return decode(data)
            }
        )
    }
}

public extension Storage where Value: Codable {
    
    static func ubiquitousKeyValueStore(
        key: String,
        decoder: JSONDecoder = .init(),
        encoder: JSONEncoder = .init(),
        store: NSUbiquitousKeyValueStore = .default
    ) -> Self {
        .ubiquitousKeyValueStore(
            key: key,
            encode: { value in
                try? encoder.encode(value)
            },
            decode: { data in
                try? decoder.decode(Value.self, from: data)
            }
        )
    }
}
