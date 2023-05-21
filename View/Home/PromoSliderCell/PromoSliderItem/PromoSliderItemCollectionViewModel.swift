//
//  PromoSliderItemCollectionViewModel.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 16.08.22.
//

import UIKit
import Combine

class PromoSliderItemCollectionViewModel {
    var banner: Banner

    init(item: Banner) {
        banner = item
    }

    var promoHeading: String {
        banner.headline1
    }

    var promoDescription: String {
        banner.headline2
    }

    var imageURL: URL? {
        URL(string: banner.imageUrl)
    }

    var promoPlaceHolderImage: UIImage? {
        return UIImage(named: "placeholder_image", in: Bundle.main, compatibleWith: nil)
    }
}
