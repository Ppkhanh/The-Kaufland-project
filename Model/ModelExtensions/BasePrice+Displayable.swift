//
//  BasePrice+Displayable.swift
//  KMarketPlaceKit
//
//  Created by Jonas Heid on 04.05.21.
//

import Foundation

extension BasePrice {
    var displayable: String {
        "(\(price.displayable) / \(unit))"
    }
}
