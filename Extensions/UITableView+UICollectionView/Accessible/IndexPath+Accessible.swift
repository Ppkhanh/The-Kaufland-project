//
//  IndexPath+Accessible.swift
//  KCommonUIKit-iOS
//
//  Created by Bisma Saeed on 02.11.21.
//  Copyright © 2021 Markus Troßbach. All rights reserved.
//

import Foundation

public extension IndexPath {
    var pathDescription: String {
        return "\(section)\(row)"
    }
}
