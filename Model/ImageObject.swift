//
//  ImageObject.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 13.04.21.
//

import Foundation

struct ImageObject: Codable {
    var baseUrl: String
    var bucket: String
    var sizes: [String]
    var hashes: [String]
    var ext: String
}
