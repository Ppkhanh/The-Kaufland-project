//
//  Categories.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 03.12.21.
//

import Foundation

struct CategoryItems: Codable {
    var categories: [CurrentCategory]
    var currentCategory: CurrentCategory
    var total: Int
}

struct CurrentCategory: Codable {
    var id: String
    var parentId: String
    var hasChildren: Bool
    var image: ImageObject?
    var level: Int
    var name: String
    var title: String
}
