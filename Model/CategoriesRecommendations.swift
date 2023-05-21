//
//  CategoriesRecommendations.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 04.04.22.
//

import Foundation

struct CategoriesRecommendations: Codable {
    let grouped: [GroupedCategoryRecommendations]
    let subCategoriesRecommendations: [Int]
}

struct GroupedCategoryRecommendations: Codable {
    let id: Int
    let name: String
    let subCategoriesRecommendations: [Int]
    let title: String
}
