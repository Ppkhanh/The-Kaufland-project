//
//  FBKDelivery.swift
//  KMarketPlaceKit
//
//  Created by Marcus Hopp on 24.06.22.
//

import Foundation

struct FBKDelivery: Codable {
    let delivery: NextDayDelivery?
    let zipCode: String?
}
