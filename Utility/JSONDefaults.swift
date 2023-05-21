//
//  JSONDefaults.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 13.10.21.
//

import Foundation

@propertyWrapper
struct JSONDefaults<T: Codable> {
    let key: String
    let defaults = UserDefaults.standard

    var wrappedValue: T? {
        get {
            guard let string = defaults.string(forKey: key), let data = string.data(using: .utf8) else {
                return nil
            }

            return try? JSONDecoder().decode(T.self, from: data)
        }
        set {
            let data = newValue
                .flatMap { try? JSONEncoder().encode($0) }
                .flatMap { String(data: $0, encoding: .utf8) }

            if let data = data {
                defaults.set(data, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
