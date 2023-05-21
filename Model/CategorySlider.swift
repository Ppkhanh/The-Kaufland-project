//
//  CategorySlider.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 14.07.22.
//

import Foundation

struct CategorySlider: Codable {
    var total: Int
    var categories: [HomeCategory]
    var categoriesTree: [Category]
}

struct HomeCategory: Codable {
    let id: Int
    let imageUrl: String
    let name: String
    let title: String
}
