//
//  RatingsViewModel.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 12.04.21.
//

import Foundation

struct RatingsViewModel {
    var rating: Double
    var totalRatings: Int?
    var ratingText: String?

    var onRatingsSelection: (() -> Void)?
}
