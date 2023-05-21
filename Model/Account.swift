//
//  Account.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 02.08.21.
//

import Foundation

struct Account: Codable {
    let accountNumber: String
    let refund: Price

    enum CodingKeys: String, CodingKey {
        case refund = "saldo"
        case accountNumber = "number"
    }
}
