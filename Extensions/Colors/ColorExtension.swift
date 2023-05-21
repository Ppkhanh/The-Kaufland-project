//
//  ColorExtension.swift
//  KCommonUIKit
//
//  Created by Felix Zardai on 17.05.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import UIKit

public extension Color {

    func coloredImageWithSize(size: CGSize) -> UIImage? {

        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)

        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(self.cgColor)
        context?.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }

    convenience init(hex: String?) {
        guard let hex = hex else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
            return
        }

        var newHex = hex

        if hex.hasPrefix("#") {
            newHex = String(hex.dropFirst())
        }

        let scanner = Scanner(string: newHex)

        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let red = (rgbValue & 0xff0000) >> 16
        let green = (rgbValue & 0xff00) >> 8
        let blue = rgbValue & 0xff

        self.init(
            red: CGFloat(red) / 0xff,
            green: CGFloat(green) / 0xff,
            blue: CGFloat(blue) / 0xff, alpha: 1
        )
    }

}
