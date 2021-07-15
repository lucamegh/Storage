/**
 * Storage
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

public extension Storage {
    
    static func ephemeral() -> Self {
        var value: Value?
        return Storage(
            store: { value = $0 },
            restore: { value }
        )
    }
}
