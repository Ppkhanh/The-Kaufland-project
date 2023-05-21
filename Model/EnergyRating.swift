//
//  EnergyRating.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 29.03.21.
//

import Foundation
import UIKit

struct EnergyRating: Codable {
    var level: String
    var range: EnergyRange
    var efficiencyNr: Int
    var label: ImageObject?
    var productName: String?

    enum CodingKeys: String, CodingKey {
        case level = "class"
        case range
        case efficiencyNr
        case label
        case productName
    }
}

extension EnergyRating {
    var color: UIColor {
        switch efficiencyNr {
        case 1:
            return KauflandColors.energyRating1
        case 2:
            return KauflandColors.energyRating2
        case 3:
            return KauflandColors.energyRating3
        case 4:
            return KauflandColors.energyRating4
        case 5:
            return KauflandColors.energyRating5
        case 6:
            return KauflandColors.energyRating6
        case 7:
            return KauflandColors.energyRating7
        case 8:
            return KauflandColors.energyRating8
        case 9:
            return KauflandColors.energyRating9
        default:
            return KauflandColors.defaultEnergyRating
        }
    }
}
