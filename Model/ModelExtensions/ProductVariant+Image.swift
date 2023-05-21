//
//  ProductVariant+Image.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 07.05.21.
//

import Foundation

extension ProductVariant {

    var imageUrl: URL? {
        return image?.brandImageUrl
    }
}
