//
//  EnergyBadgesCellViewModel.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 05.07.21.
//

import Foundation

struct PIEnergyBadgesCellViewModel {
    let energyRating: EnergyRating
    let badgeAlignment: EnergyBadgeAlignment
    var showOnlyBadge = true

    func energyRatingViewModel() -> PIEnergyRatingViewModel {
        return PIEnergyRatingViewModel(energyRating: energyRating,
                                     alignment: badgeAlignment,
                                     showOnlyBadge: showOnlyBadge)
    }
}
