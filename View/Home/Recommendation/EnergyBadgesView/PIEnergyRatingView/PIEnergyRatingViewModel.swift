//
//  EnergyRatingViewModel.swift
//  KMarketPlaceKit
//
//  Created by Jonas Heid on 07.05.21.
//

import Foundation

enum EnergyBadgeAlignment {
    case left, right
}

class PIEnergyRatingViewModel {
    let energyRating: EnergyRating
    let badgeAlignment: EnergyBadgeAlignment
    let showOnlyBadge: Bool
    let isForPDP: Bool

    var showOldRating: Bool {
        return energyRating.isOldRating
    }

    init(energyRating: EnergyRating, alignment: EnergyBadgeAlignment, showOnlyBadge: Bool = false, isForPDP: Bool = false) {
        self.energyRating = energyRating
        self.badgeAlignment = alignment
        self.showOnlyBadge = showOnlyBadge
        self.isForPDP = isForPDP
    }

    var energyBadgeViewModel: PIEnergyBadgeViewModel {
        return PIEnergyBadgeViewModel(energyRating: energyRating, badgeAlignment: badgeAlignment, showOnlyBadge: showOnlyBadge)
    }
}
