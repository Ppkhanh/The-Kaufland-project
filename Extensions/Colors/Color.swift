//
//  Color.swift
//  KCommonUIKit
//
//  Created by Markus Troßbach on 12/05/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
public typealias Color = UIColor

public extension UIColor {
    var hexString: String {
        if let colorRef = cgColor.components {
            let red: CGFloat = colorRef[0]
            let green: CGFloat = colorRef[1]
            let blue: CGFloat = colorRef[2]
            return String(format: "#%02lX%02lX%02lX", arguments: [lroundf(Float(red * 255)), lroundf(Float(green * 255)), lroundf(Float(blue * 255))])
        } else {
            return "#000000"
        }
    }

    static func from(hexString: String?) -> UIColor {
        if let hexString = hexString {
            var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

            if cString.hasPrefix("#") {
                cString.remove(at: cString.startIndex)
            }

            if (cString.count) != 6 {
                return UIColor.black
            }

            var rgbValue: UInt64 = 0
            Scanner(string: cString).scanHexInt64(&rgbValue)

             return UIColor(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(1.0)
            )
        } else {
            return UIColor.black
        }
    }
}

// - MARK: SwiftUI

public extension UIColor {
    var swiftUI: SwiftUI.Color {
        SwiftUI.Color(self)
    }
}
