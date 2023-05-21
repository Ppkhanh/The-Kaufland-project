//
//  Rating.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 13.04.21.
//

import Foundation

struct Rating: Codable {
    var count: Int
    var average: Double

    enum CodingKeys: String, CodingKey {
        case count = "cnt"
        case average = "avg"
    }
}
