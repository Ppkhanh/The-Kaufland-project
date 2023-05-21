//
//  Date+milli.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 04.04.22.
//

import Foundation

extension Date {
    var millisecondsSince1970: Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
