//
//  Variant+Displayable.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 10.05.21.
//

import Foundation
import UIKit

extension Variant {
    private typealias UIConst = Constants.Variant

    var titleText: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: title + ": ", attributes: [.font: UIConst.titleFont])
        guard let values = values else { return attributedString }

        let selectedProductVariant = values.first { $0.match == true }
        if let productTitle = selectedProductVariant?.title {
            let selectedProductAttributedString = NSMutableAttributedString(string: productTitle, attributes: [.font: UIConst.selectedValueFont])
            attributedString.append(selectedProductAttributedString)
        }

        return attributedString
    }

    var titleTextCart: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: title + ": ", attributes: [.font: UIConst.cartTitleFont, .foregroundColor: KauflandColors.secondary700])
        guard let values = values else { return attributedString }

        let selectedProductVariant = values.first { $0.match == true }
        if let productTitle = selectedProductVariant?.title {
            let selectedProductAttributedString = NSMutableAttributedString(string: productTitle, attributes: [.font: UIConst.cartselectedValueFont])
            attributedString.append(selectedProductAttributedString)
        }

        return attributedString
    }
}
