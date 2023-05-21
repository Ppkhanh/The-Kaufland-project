//
//  PromoSlider.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 15.08.22.
//

import Foundation

struct PromoSlider: Codable {
    var total: Int
    var banners: [Banner]
}

struct Banner: Codable {
    let name: String
    let key: String
    let headline1: String
    let headline2: String
    let imageUrl: String
}
