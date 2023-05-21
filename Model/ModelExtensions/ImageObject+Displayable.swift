//
//  ImageObject+Displayable.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 28.04.21.
//

import Foundation

extension ImageObject {

    var brandImageUrl: URL? {
        guard let size = sizes.first, let hash = hashes.first else { return nil }

        let urlString = imageUrlString(size: size, hash: hash)
        return URL(string: urlString)
    }

    var pdpImageSize: String? {
        let preferredSizeString = Constants.PDP.preferredImageSizeString
        return sizes.contains(preferredSizeString) ? preferredSizeString : sizes.first
    }

    private var pdpRecommendationImageSize: String? {
        let preferredSizeString = Constants.PDP.recommendationPreferredImageSizeString
        return sizes.contains(preferredSizeString) ? preferredSizeString : sizes.first
    }

    func categoryImageUrl() -> URL? {
        guard let size = sizes.first else { return nil }
        return imageUrlsForSize(size: size).first
    }

    func pdpImageUrls() -> [URL] {
        guard let size = pdpImageSize else { return [] }
        return imageUrlsForSize(size: size)
    }

    func pdpRecommendationImageUrl() -> URL? {
        guard let size = pdpRecommendationImageSize else { return nil }
        return imageUrlsForSize(size: size).first
    }

    private func imageUrlsForSize(size: String) -> [URL] {
        var urls: [URL] = []
        for hash in hashes {
            let urlString = imageUrlString(size: size, hash: hash)
            if let url = URL(string: urlString) {
                urls.append(url)
            }
        }

        return urls
    }

    private func imageUrlString(size: String, hash: String) -> String {
        return "\(baseUrl)/\(bucket)/\(size)/\(hash).\(ext)"
    }
}
