//
//  Shipping.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 13.04.21.
//

import Foundation

enum ShippingType: String, Codable {
    case package = "PACKAGE"
    case hauler = "HAULER"

    var title: String {
        switch self {
        case .package:
            return Strings.mpPdpShippingPackage.localized
        case .hauler:
            return Strings.mpPdpShippingHauler.localized
        }
    }

    var info: String? {
        return self == .hauler ? Strings.mpPdpDeliveryInfo.localized : nil
    }
}

struct Shipping: Codable {
    var price: Price
    var type: ShippingType?
}
