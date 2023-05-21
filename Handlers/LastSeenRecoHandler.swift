//
//  LastSeenRecoHandler.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 08.12.21.
//

import Foundation
import Combine

protocol LastSeenRecoHandlerProtocol {
    var isLastSeenProductsEmpty: Bool { get }
}

class LastSeenRecoHandler: LastSeenRecoHandlerProtocol {
    static let shared = LastSeenRecoHandler()

    private typealias UIConst = Constants.LastSeenPersistence

    private let maxLastSeenProductsLimit = 12

    @JSONDefaults(key: UIConst.defaultsKey)
    var lastSeen: [LastSeen]?

    init() {
        if lastSeen == nil {
            lastSeen = []
        }
    }

    func addToLastSeenProducts(productId: String, offerId: String) {
        // If Last Seen cached limit exceeded then remove last before saving new
        if isLimitExceeded {
            lastSeen?.removeLast()
        }

        // If productID+offerId is already cached then move to Top
        if lastSeen?.first(where: { $0.productId == productId && $0.offerId == offerId }) != nil {
            moveToTop(productId: productId, offerId: offerId)
        } else {
            // else just insert LastSeen at top
            lastSeen?.insert(LastSeen(productId: productId, offerId: offerId), at: 0)
        }
    }

    private func moveToTop(productId: String, offerId: String) {
        lastSeen?.removeAll(where: { $0.productId == productId && $0.offerId == offerId })

        lastSeen?.insert(LastSeen(productId: productId, offerId: offerId), at: 0)
    }

    func removeAllEntries() {
        lastSeen?.removeAll()
    }

    private var isLimitExceeded: Bool {
        lastSeen?.count == maxLastSeenProductsLimit
    }

    var lastSeenProductIDs: [String]? {
        lastSeen?.map { $0.productId }
    }

    var lastSeenOfferIDs: [String]? {
        lastSeen?.map { $0.offerId }
    }

    var isLastSeenProductsEmpty: Bool {
        lastSeen?.isEmpty ?? true
    }
}
