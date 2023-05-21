//
//  ProductAttribute.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 28.04.21.
//

import Foundation

struct ProductAttribute: Codable {
    var general: [AttributeItem]
    var legal: [AttributeItem]?

    enum CodingKeys: String, CodingKey {
        case general = "default"
        case legal
    }
}
