//
//  RecoHelper.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 27.01.22.
//

import Foundation
import UIKit

class RecoHelper {
    typealias UIConst = Constants.RecoHelper

    static func recommendationContainerHeight(_ recoItems: [Recommendation]?) -> CGFloat {
        let hasDataSheet = recoItems?.first(where: { $0.product?.productDatasheet != nil }) != nil
        let hasEnergyRange = recoItems?.first { $0.product?.energyRatings?.count == 1 && $0.product?.energyRatings?.contains { $0.isOldRating } ?? false } != nil
        let hasFBKInfo = recoItems?.first { $0.offer?.fbkInformation?.isFbkOffer == true } != nil

        return heightForContainer(hasItemWithEnergyRange: hasEnergyRange,
                                  hasItemWithDataSheet: hasDataSheet,
                                  hasFBKInfo: hasFBKInfo)
    }

    static func heightForContainer(hasItemWithEnergyRange: Bool,
                                   hasItemWithDataSheet: Bool,
                                   hasFBKInfo: Bool) -> CGFloat {
        var height: CGFloat
        switch (hasItemWithEnergyRange, hasItemWithDataSheet) {
        case (true, true):
            height = UIConst.heightWithEnergyRangeAndDataSheet
        case (false, false):
            height = hasFBKInfo ? UIConst.normalHeightWithFBKInfo : UIConst.normalHeight
        default:
            height = UIConst.heightWithEnergyRangeOrDataSheet
        }
        return height
    }
}
