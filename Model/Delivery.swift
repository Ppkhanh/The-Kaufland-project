//
//  Delivery.swift
//  KMarketPlaceKit
//
//  Created by Bisma Saeed on 10.05.21.
//

import Foundation

struct Delivery: Codable {
    var text: String
    var origin: String
    var min: Int?
    var max: Int?
    var latest: String?
    var earliest: String?
}

extension Delivery {
    var earliestDate: Date {
        guard let earliestDateString = earliest else { return Date() }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: earliestDateString) ?? Date()
    }

    var isNextDayDelivery: Bool {
        return min == 1 && max == 1
    }
}
