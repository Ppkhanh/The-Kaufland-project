//
//  BrandSlider.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 12.09.22.
//

import Foundation

struct BrandSlider: Codable {
    var total: Int
    var brands: [Brand]

    struct Brand: Codable {
        var key: String
        var name: String
        var imageUrl: String
    }
}
