//
//  CustomerHistoryEvent.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 04.04.22.
//

import Foundation

enum CustomerHistoryEventType: String, Codable {
    case pdpViewed = "PDP_VIEWED"
    case productAddedToCart = "PRODUCT_ADDED_TO_CART"
    case productPurchased = "PRODUCT_PURCHASED"
}

struct CustomerHistory: Codable {
    var events: [CustomerHistoryEvent]?
}

struct CustomerHistoryEvent: Codable {
    let categoryId: Int
    let eventType: CustomerHistoryEventType
    let timestamp: Int
}
