//
//  BrandSliderItemCollectionViewModel.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 14.09.22.
//

import Foundation
import UIKit

class BrandSliderItemCollectionViewModel {
    var brandItem: BrandSlider.Brand

    init(item: BrandSlider.Brand) {
        brandItem = item
    }

    var imageURL: URL? {
        URL(string: brandItem.imageUrl)
    }

    var categoryPlaceHolderImage: UIImage? {
        return UIImage(named: "placeholder_image", in: Bundle.main, compatibleWith: nil)
    }
}
