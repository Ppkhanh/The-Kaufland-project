//
//  NextDayDelivery.swift
//  KMarketPlaceKit
//
//  Created by Marcus Hopp on 13.06.22.
//

import Foundation

struct NextDayDelivery: Codable {
    let min: Int?
    let max: Int?
    let cutOffTime: String?
    let text: String?

    var cutOffTimeDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        guard let cutOffTime = cutOffTime else {
            return nil
        }
        return dateFormatter.date(from: cutOffTime)
    }

    var isNextDayDelivery: Bool {
        guard
            let min = min,
            let max = max else { return false }
        return min == 1 && max == 1
    }
}
