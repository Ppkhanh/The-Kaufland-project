//
//  CALayerExtension.swift
//  KCommonUIKit-iOS
//
//  Created by Denislava Shentova on 9.07.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

import UIKit

public struct BasicShadow {

    let shadowOpacity: Float
    let shadowOffset: CGSize
    let shadowRadius: CGFloat
    let shadowCornerRadius: CGFloat
    let customPath: UIBezierPath?

    public init(shadowOpacity: Float,
                shadowOffset: CGSize,
                shadowRadius: CGFloat,
                shadowCornerRadius: CGFloat,
                customPath: UIBezierPath? = nil) {
        self.shadowOpacity = shadowOpacity
        self.shadowOffset = shadowOffset
        self.shadowRadius = shadowRadius
        self.shadowCornerRadius = shadowCornerRadius
        self.customPath = customPath
    }

}

// swiftlint:disable identifier_name
public struct SketchShadow {

    let color: Color
    let alpha: Float
    let x: CGFloat
    let y: CGFloat
    let blur: CGFloat
    let spread: CGFloat

    public init(color: Color = KauflandColors.secondary900,
                alpha: Float = 0.25,
                x: CGFloat = 0,
                y: CGFloat = 3,
                blur: CGFloat = 8,
                spread: CGFloat = 0) {
        self.color = color
        self.alpha = alpha
        self.x = x
        self.y = y
        self.blur = blur
        self.spread = spread

    }

}
// swiftlint:enable identifier_name

public extension CALayer {

    func applySketchShadow(sketchShadow: SketchShadow = SketchShadow()) {
        shadowColor = sketchShadow.color.cgColor
        shadowOpacity = sketchShadow.alpha
        shadowOffset = CGSize(width: sketchShadow.x, height: sketchShadow.y)
        shadowRadius = sketchShadow.blur / 2.0
        if sketchShadow.spread == 0 {
            shadowPath = nil
        } else {
            let dx = -sketchShadow.spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }

    func applyBasicShadow(basicShadow: BasicShadow) {
        masksToBounds = false
        shadowOpacity = basicShadow.shadowOpacity
        shadowOffset = basicShadow.shadowOffset
        shadowRadius = basicShadow.shadowRadius

        if let path = basicShadow.customPath {
            shadowPath = path.cgPath
        } else {
            shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: basicShadow.shadowCornerRadius).cgPath
        }
    }

}
