//
//  Offer+Displayable.swift
//  KMarketPlaceKit
//
//  Created by Jonas Heid on 04.05.21.
//

import Foundation
import UIKit

extension Offer {
    private typealias UIConst = Constants.Offer

    var discountDisplayable: String? {
        guard let discount = discount else { return nil }
        return "-\(discount)%"
    }

    var basePricesDisplayable: String? {
        guard let basePrices = basePrices else { return nil }
        return basePrices.map { $0.displayable }.joined(separator: ", ")
    }

    var referencePriceDisplayable: String? {
        guard let referencePrice = referencePrice?.displayable else { return nil }
        return "\(Strings.mpPdpMsrp.localized) \(referencePrice)"
    }

    var stockDisplayable: String {
        let stockOnly = Strings.mpPdpStockOnly.localized
        let piecesAvailable = amount == 1 ? Strings.mpPdpStockAvailableSingular : Strings.mpPdpStockAvailablePlural

        guard let amount = amount, amount > 0 else {
            return Strings.mpPdpNotAvailableSubtitle.localized
        }

        return "\(stockOnly) \(amount) \(piecesAvailable.localized)"
    }

    var conditionAttributedString: NSAttributedString? {
        guard let itemCondition = condition?.title else { return nil }
        return NSAttributedString(string: itemCondition,
                                  attributes: [
                                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                                    .foregroundColor: KauflandColors.secondary900,
                                    .font: UIConst.conditionLabelFont])
    }
}
