//
//  JSONParser.swift
//  KMarketPlaceKitTests
//
//  Created by Priyanka Saroha on 14.07.22.
//

import Foundation

class JSONParser {
    static func decode<T: Codable>(_ file: String) -> T {
        guard let url = Bundle(for: Self.self).url(forResource: file, withExtension: "") else {
            fatalError("Failed to locate \(file) in bundle")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle")
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file)")
        }
        return loaded
    }
}
