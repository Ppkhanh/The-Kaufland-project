//
//  Recommendations.swift
//  KMarketPlaceKit
//
//  Created by Marcus Hopp on 04.11.21.
//

import Foundation

enum RecommendationType: String {
    case similar
    case sponsored
    case bestSeller = "best-seller"
    case lastSeen = "last-seen"
    case personalized
    case associate
    case careco
}

struct Recommendation: Codable {
    var product: Product?
    var offer: Offer?
    var trackingData: [TrackingDataMabaya]?
}

struct Recommendations: Codable {
    var items: [Recommendation]?
    var trackingData: [TrackingDataMabaya]?
    var total: Int?

    enum CodingKeys: String, CodingKey {
        case items = "recommendations"
        case total
    }
}
