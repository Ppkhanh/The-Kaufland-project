//
//  PIEnergyBadgeViewModel.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 21.10.21.
//

import UIKit

class PIEnergyBadgeViewModel {
    private let energyRating: EnergyRating
    let alignment: EnergyBadgeAlignment
    let showOnlyBadge: Bool

    var range: String {
        energyRating.rangeDisplayable
    }

    var minRange: String {
        energyRating.range.min
    }

    var maxRange: String {
        energyRating.range.max
    }

    var level: String {
        energyRating.level
    }

    var color: UIColor {
        energyRating.color
    }

    init(energyRating: EnergyRating, badgeAlignment: EnergyBadgeAlignment, showOnlyBadge: Bool = false) {
        self.energyRating = energyRating
        self.alignment = badgeAlignment
        self.showOnlyBadge = showOnlyBadge
    }
}
