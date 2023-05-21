//
//  CustomerReview.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 09.09.21.
//
import Foundation

struct CustomerReview: Codable {
    typealias UIConst = Constants.CustomerReviewDetail

    var total: Int
    var reviews: [Review]
    var summary: [ReviewSummary]?

    struct Review: Codable {
        var id: String
        var title: String
        var text: String?
        var rating: Int
        var isVerifiedPurchase: Bool
        var variants: [Variant]
        var createdAt: String

        var formattedCreatedDate: Date? {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter.date(from: createdAt)
        }
    }

    struct Variant: Codable {
        var title: String
        var value: String?
    }
}

struct ReviewSummary: Codable {
    var rating: Int
    var percentage: Int
}
