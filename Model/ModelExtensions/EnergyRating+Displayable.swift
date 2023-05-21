//
//  EnergyRating+Displayable.swift
//  KMarketPlaceKit
//
//  Created by Jonas Heid on 31.05.21.
//

import Foundation

extension EnergyRating {
    var rangeDisplayable: String {
        String(format: Strings.mpPdpEnergySpectrum.localized, range.max, range.min)
    }

    var isOldRating: Bool {
        return range.max != "A" && range.min != "G"
    }
}
