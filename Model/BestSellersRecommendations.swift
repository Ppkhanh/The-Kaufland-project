//
//  BestSellersRecommendations.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 06.04.22.
//

import Foundation

struct BestSellersRecommendations: Codable {
    let items: [BestSellerRecommendation]?
    let total: Int?

    enum CodingKeys: String, CodingKey {
        case items = "bestSellersRecommendations"
        case total
    }
}

struct BestSellerRecommendation: Codable {
    let category: Category?
    let recommendations: [Recommendation]?
}
