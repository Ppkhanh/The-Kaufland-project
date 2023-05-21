//
//  Price+Displayable.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 13.04.21.
//

import Foundation

extension Price {
    var displayable: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currencyAccounting
        formatter.locale = Locale.current
        formatter.currencyCode = currency
        let amountDisplayable = formatter.string(from: amount as NSNumber) ?? ""
        return amountDisplayable
    }

    var currencySymbol: String {
        return currency == "EUR" ? "€" : currency
    }
}
