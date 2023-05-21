//
//  ReviewsLegalInfo.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 02.05.22.
//

import Foundation

struct ReviewsLegalInfo: Codable {
    let title: String
    let contents: [ReviewLegalContent]
}

struct ReviewLegalContent: Codable {
    let description: String
    let subTitle: String
}
