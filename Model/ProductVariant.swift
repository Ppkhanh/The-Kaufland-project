//
//  ProductVariant.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 28.04.21.
//

import Foundation

struct ProductVariant: Codable {
    var idProduct: String
    var title: String
    var image: ImageObject?
    var price: Price?
    var available: Bool
    var match: Bool
}
