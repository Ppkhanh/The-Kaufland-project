//
//  SearchItem.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 29.03.21.
//

import Foundation

struct Product: Codable {
    var id: String
    var name: String
    var images: ImageObject?
    var adultImageContent: Bool
    var energyRatings: [EnergyRating]?
    var variants: [Variant]?
    var brand: Brand?
    var rating: Rating?
    var packaging: String?
    var categories: [Category]?
    var productDatasheet: ImageObject?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case images
        case adultImageContent
        case energyRatings = "energy"
        case variants
        case brand
        case rating
        case packaging
        case categories
        case productDatasheet
    }
}
