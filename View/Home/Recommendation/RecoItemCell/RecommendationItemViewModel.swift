//
//  RecommendationItemViewModel.swift
//  KMarketPlaceKit
//
//  Created by Marcus Hopp on 08.11.21.
//

import Foundation
import UIKit

class RecommendationItemViewModel {
    private var product: Product? {
        recommendation.product
    }

    private var offer: Offer? {
        recommendation.offer
    }

    var offerId: String? {
        offer?.id
    }

    var name: String? {
        product?.name
    }

    var price: String? {
        offer?.price.displayable
    }

    var basePrice: String? {
        offer?.basePricesDisplayable
    }

    var referencePrice: String? {
        offer?.referencePriceDisplayable
    }

    var discount: String? {
        offer?.discountDisplayable
    }

    var shipping: String? {
        offer?.shipping.displayable
    }

    var badgeText: String? {
        offer?.badge
    }

    var packagingText: String? {
        product?.packaging
    }

    // MARK: - FBK
    private var isFBKItem: Bool {
        offer?.fbkInformation?.isFbkOffer ?? false
    }

    private var isDirectSeller: Bool {
        offer?.seller?.isDirectSeller == true
    }

    var fbkInfoText: String? {
        guard isFBKItem else { return nil }

        return isDirectSeller ? Strings.mpDirectSaleText.localized : Strings.mpCartWishlistFbkText.localized
    }

    // MARK: Implement actual value
    var depositText: String? {
        nil
    }

    var energyRatings: [EnergyRating]? {
        product?.energyRatings
    }

    var shouldHideAgeVerification: Bool {
        product?.adultImageContent == false
    }

    var shouldHideRangeDataSheet: Bool {
        shouldHideEnergyRange && shouldHideDataSheet
    }

    var shouldHideDataSheet: Bool {
        product?.productDatasheet == nil
    }

    var shouldHideEnergyRange: Bool {
        !hasOldSingleBadge
    }

    var shouldHideBadge: Bool {
        badgeText == nil
    }

    var shouldHidePackaging: Bool {
        packagingText == nil
    }

    var shouldHideBasePrice: Bool {
        basePrice == nil
    }

    var energyRange: String? {
        product?.energyRatings?.first?.rangeDisplayable
    }

    var hasOldSingleBadge: Bool {
        product?.energyRatings?.count == 1 && product?.energyRatings?.first?.isOldRating == true
    }

    var isEnergyBadgesAvailable: Bool {
        return product?.energyRatings?.count ?? 0 > 0
    }

    var numberOfLinesForNameLabel: Int {
        var numberToReturn = 3

        if basePrice != nil {
            numberToReturn = 2
        }
        if basePrice != nil && packagingText != nil {
            numberToReturn = 1
        }
        return numberToReturn
    }

    func energyBadgesViewModel() -> PIEnergyBadgesViewModel? {
        return PIEnergyBadgesViewModel(energyRatings: product?.energyRatings, showOnlyBadge: true)
    }

    private var rating: Double {
        product?.rating?.average ?? 0.0
    }

    private var totalRatings: Int {
        product?.rating?.count ?? 0
    }

    var ratingsViewModel: RatingsViewModel? {
        RatingsViewModel(rating: rating, totalRatings: totalRatings)
    }

    var imageUrl: URL? {
        guard let imageURL = product?.images?.pdpRecommendationImageUrl() else { return nil }
        return imageURL
    }

    private let recommendation: Recommendation

    init(recommendation: Recommendation) {
        self.recommendation = recommendation
    }
}
