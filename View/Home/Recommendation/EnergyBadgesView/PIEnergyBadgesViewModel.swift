//
//  PIEnergyBadgesViewModel.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 18.10.21.
//

import Foundation
import UIKit

struct PIEnergyBadgesViewModel {
    let energyRatings: [EnergyRating]?
    var productDataSheet: ImageObject?
    var showOnlyBadge: Bool?

    var numberOfItems: Int {
        return energyRatings?.count ?? 0
    }

    var hasOldEnergyRatings: Bool {
        return energyRatings?.contains(where: { $0.isOldRating }) ?? false
    }

    var showDataSheet: Bool {
        productDataSheet != nil
    }

    func cellViewModelAtIndexPath(_ indexPath: IndexPath) -> PIEnergyBadgesCellViewModel? {
        guard let energyRating = energyRatings?.safeRef(indexPath.row) else { return nil }

        let alignment: EnergyBadgeAlignment = .right
        return PIEnergyBadgesCellViewModel(energyRating: energyRating,
                                           badgeAlignment: alignment,
                                           showOnlyBadge: showOnlyBadge ?? !isSingleOldEnergyBadge)
    }

    var isSingleNewEnergyRating: Bool {
        energyRatings?.count == 1 && !hasOldEnergyRatings
    }

    // This flag is needed to know if only energy badge is needed in case of old badges
    // e.g Recommenders only show badges but Search/Cart shows old badge with label
    // Only old badge show energy Range label along with badge
    // In case of new energy badges we just show badge
    var isSingleOldEnergyBadge: Bool {
        energyRatings?.count == 1 && hasOldEnergyRatings
    }

    var stackViewAxis: NSLayoutConstraint.Axis {
        // Only in case of single new energy rating
        // Badge and Product data sheet needs to be horizontally stacked
        if energyRatings?.count == 1 && !hasOldEnergyRatings && showDataSheet {
            return .horizontal
        }
        return .vertical
    }

    var stackViewAlignment: UIStackView.Alignment {
        stackViewAxis == .horizontal ? .center : .leading
    }

//    func viewModelForImagePresenter() -> ImagePresenterViewModel? {
//        guard let dataSheet = productDataSheet else { return nil }
//        return ImagePresenterViewModel(imageObject: dataSheet, title: Strings.mpProductDataSheet.localized)
//    }
}
