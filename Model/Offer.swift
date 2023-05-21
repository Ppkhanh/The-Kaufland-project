//
//  Offer.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 13.04.21.
//

import Foundation

enum Status: String, Codable {
    case available = "AVAILABLE"
    case onHold = "ON_HOLD"
    case hidden = "HIDDEN"
    case unknown = "UNKNOWN"
    case soldOut = "SOLD_OUT"
}

enum ProductCondition: String, Codable {
    case new = "NEW"
    case usedAsNew = "USED_AS_NEW"
    case usedVeryGood = "USED_VERY_GOOD"
    case usedGood = "USED_GOOD"
    case usedAcceptable = "USED_ACCEPTABLE"

    var title: String {
        switch self {
        case .new:
            return Strings.mpPdpConditionNew.localized
        case .usedAsNew:
            return Strings.mpPdpConditionAsNew.localized
        case .usedVeryGood:
            return Strings.mpPdpConditionVeryGood.localized
        case .usedGood:
            return Strings.mpPdpConditionGood.localized
        case .usedAcceptable:
            return Strings.mpPdpConditionAcceptable.localized
        }
    }

    var generalNote: String {
        switch self {
        case .usedAsNew:
            return Strings.mpPdpNoteAsNew.localized
        case .usedVeryGood:
            return Strings.mpPdpNoteVeryGood.localized
        case .usedGood:
            return Strings.mpPdpNoteGood.localized
        default:
            return Strings.mpPdpNoteAcceptable.localized
        }
    }
}

struct Offer: Codable {
    var id: String
    var shipping: Shipping
    var freeReturnPeriod: FreeReturn?
    var price: Price
    var referencePrice: Price?
    var basePrices: [BasePrice]?
    var discount: Int?
    var amount: Int?
    var seller: Seller?
    var delivery: Delivery?
    var badge: String?
    var condition: ProductCondition?
    var note: String?
    var status: Status?
    var fbkInformation: FBK?
    var deliveryGroupId: String?

    enum CodingKeys: String, CodingKey {
        case fbkInformation = "fbk"
        case id
        case shipping
        case freeReturnPeriod
        case price
        case referencePrice
        case basePrices
        case discount
        case amount
        case seller
        case delivery
        case badge
        case condition
        case note
        case status
        case deliveryGroupId
    }
}

extension Offer {
    var isNDDAvailable: Bool {
        fbkInformation?.fbkDelivery?.isNextDayDelivery ?? false || delivery?.isNextDayDelivery ?? false
    }
}
