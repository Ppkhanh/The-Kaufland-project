//
//  CAAnimation+Blink.swift
//  MarketplaceKit
//
//  Created by Zuhaib Rasheed on 27.09.21.
//  Copyright © 2021 Markus Troßbach. All rights reserved.
//

import UIKit

extension CAAnimation {
    static func blinkAnimation() -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.isRemovedOnCompletion = false
        animation.fromValue = 0.3
        animation.toValue = 1
        animation.duration = 1
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        return animation
    }
}
