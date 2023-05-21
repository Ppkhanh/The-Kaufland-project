//
//  Category.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 27.08.21.
//

import Foundation

struct Category: Codable {
    let id: String
    let level: Int?
    let name: String
    let parentId: String?
    let title: String
}
