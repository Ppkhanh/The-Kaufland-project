//
//  FBK.swift
//  KMarketPlaceKit
//
//  Created by Marcus Hopp on 13.06.22.
//

import Foundation

struct FBK: Codable {
    let isFbkOffer: Bool?
    let deliveryGroupId: String?
    var fbkDelivery: NextDayDelivery?
}
