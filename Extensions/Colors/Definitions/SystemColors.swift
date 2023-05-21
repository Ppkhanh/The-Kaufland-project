//
//  SystemColors.swift
//  KCommonUIKit
//
//  Created by Felix Zardai on 17.05.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public struct SystemColors {

    // System-Colors
    public static var red: Color {
        return Color(red: 1.0, green: 59.0/255.0, blue: 48.0/255.0, alpha: 1.0)
    }

    public static var orange: Color {
        return Color(red: 1.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }

    public static var yellow: Color {
        return Color(red: 1.0, green: 204.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }

    public static var green: Color {
        return Color(red: 76.0/255.0, green: 217.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    }

    public static var tealBlue: Color {
        return Color(red: 90.0/255.0, green: 200.0/255.0, blue: 250.0/255.0, alpha: 1.0)
    }

    public static var blue: Color {
        return Color(red: 0.0/255.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
    }

    public static var purple: Color {
        return Color(red: 88.0/255.0, green: 86.0/255.0, blue: 214.0/255.0, alpha: 1.0)
    }

    public static var pink: Color {
        return Color(red: 1.0, green: 45.0/255.0, blue: 85.0/255.0, alpha: 1.0)
    }

    // Element-Colors
    public static var barLight: Color {
        return Color(red: 246.0/255.0, green: 246.0/255.0, blue: 246.0/255.0, alpha: 1.0)
    }

    public static var barDark: Color {
        return Color(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
    }

    public static var navBottomLineLight: Color {
        return Color.init(white: 0.4, alpha: 1.0)
    }

    public static var navBottomLineDark: Color {
        return Color.init(white: 0.75, alpha: 1.0)
    }

    public static var barSeparatorLine: Color {
        return Color(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1.0)
    }

    public static var barUnselectedColor: Color {
        return Color(red: 146.0/255.0, green: 146.0/255.0, blue: 146.0/255.0, alpha: 1.0)
    }

    public static var sectionTextColor: Color {
        return Color(red: 109.0/255.0, green: 109.0/255.0, blue: 114.0/255.0, alpha: 1.0)
    }

    public static var rowSelectedColorGray: Color {
        return Color(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1.0)
    }

    public static var dimmedColor: Color {
        return Color(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.5)
    }

    public static var middleDimmedColor: Color {
        return Color(red: 127.5/255.0, green: 127.5/255.0, blue: 127.5/255.0, alpha: 0.5)
    }

    public static var lightDimmenColor: Color {
        return Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
    }

    // SYSTEM BUTTON
    public static var buttonDisabledColor: Color {
        return Color(red: 123.0/255.0, green: 123.0/255.0, blue: 123.0/255.0, alpha: 0.35)
    }

}
