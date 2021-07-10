/**
 * Storage
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

public extension Storage {
    
    static func fileSystem(
        baseURL: URL,
        fileName: String,
        encode: @escaping (Value?) -> Data?,
        decode: @escaping (Data) -> Value?
    ) -> Self {
        let fileURL = baseURL.appendingPathComponent(fileName)
        return Storage(
            store: { value in
                guard let data = value.flatMap(encode) else { return }
                try? data.write(to: fileURL)
            },
            restore: {
                guard let data = try? Data(contentsOf: fileURL) else { return nil }
                return decode(data)
            }
        )
    }
}

public extension Storage where Value: Codable {
    
    static func fileSystem(
        baseURL: URL,
        fileName: String,
        decoder: JSONDecoder = .init(),
        encoder: JSONEncoder = .init()
    ) -> Self {
        fileSystem(
            baseURL: baseURL,
            fileName: fileName,
            encode: { value in
                try? encoder.encode(value)
            },
            decode: { data in
                try? decoder.decode(Value.self, from: data)
            }
        )
    }
}
