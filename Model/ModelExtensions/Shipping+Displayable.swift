//
//  Shipping+Displayable.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 13.04.21.
//

import Foundation

extension Shipping {
    var displayable: String {
        if price.amount == 0 {
            return Strings.mpProductFreeDelivery.localized
        } else {
            return "+ \(price.displayable) \(Strings.mpPdpShippingCosts.localized)"
        }
    }
}
