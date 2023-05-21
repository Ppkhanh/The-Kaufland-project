//
//  OtherOffers.swift
//  KMarketPlaceKit
//
//  Created by Marcus Hopp on 20.04.22.
//

import Foundation

struct OtherOffers: Codable {
    let new: OtherOffersNew?
    let used: OtherOffersUsed?
}

struct OtherOffersNew: Codable {
    let minPrice: Price?
    let total: Int?
}

struct OtherOffersUsed: Codable {
    let minPrice: Price?
    let total: Int?
}

struct OtherOffersDetail: Codable {
    let offers: [Offer]
}
