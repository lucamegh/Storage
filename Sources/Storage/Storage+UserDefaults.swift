/**
 * Storage
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

public extension Storage {
    
    static func userDefaults(
        key: String,
        encode: @escaping (Value) -> Data?,
        decode: @escaping (Data) -> Value?,
        userDefaults: UserDefaults = .standard
    ) -> Self {
        Storage(
            store: { value in
                guard let data = value.flatMap(encode) else { return }
                userDefaults.setValue(data, forKey: key)
            },
            restore: {
                guard let data = userDefaults.data(forKey: key) else { return nil }
                return decode(data)
            }
        )
    }
}

public extension Storage where Value: Codable {
    
    static func userDefaults(
        key: String,
        decoder: JSONDecoder = .init(),
        encoder: JSONEncoder = .init(),
        userDefaults: UserDefaults = .standard
    ) -> Self {
        .userDefaults(
            key: key,
            encode: { value in
                try? encoder.encode(value)
            },
            decode: { data in
                try? decoder.decode(Value.self, from: data)
            },
            userDefaults: userDefaults
        )
    }
}
