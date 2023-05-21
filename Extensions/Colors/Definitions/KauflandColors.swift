//
//  KauflandColors.swift
//  KCoreKit
//
//  Created by Markus Troßbach on 11/05/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public struct KauflandColors {

    public static var primary: Color {
        red
    }

    public static var secondary: Color {
        darkGray
    }

    public static var third: Color {
        green
    }

    // Primary-Colors
    public static var red: Color {
        Color(hex: "#e10915") // Color(red: 225.0/255.0, green: 9.0/255.0, blue: 21.0/255.0, alpha: 1.0)
    }

    public static var darkRed: Color {
        Color(hex: "#76050b") // Color(red: 148.0/255.0, green: 3.0/255.0, blue: 11.0/255.0, alpha: 1.0)
    }

    public static var green: Color {
        Color(red: 90.0/255.0, green: 180.0/255.0, blue: 70.0/255.0, alpha: 1.0)
    }

    public static var white: Color {
        Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    public static var black: Color {
        Color(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }

    public static var purple: Color {
        Color(red: 128.0/255.0, green: 0.0/255.0, blue: 128.0/255.0, alpha: 1.0)
    }

    public static var yellow: Color {
        Color(red: 251.0/255.0, green: 244.0/255.0, blue: 43.0/255.0, alpha: 1.0)
    }

    public static var blue: Color {
        Color(red: 33.0/255.0, green: 150.0/255.0, blue: 243.0/255.0, alpha: 1.0)
    }

    public static var lightBlue: Color {
        Color(red: 224.0/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
    }

    public static var cornflowerBlue: Color {
        Color(red: 150.0/255.0, green: 202.0/255.0, blue: 235.0/255.0, alpha: 1.0)
    }

    public static var orange: Color {
        Color(red: 241.0/255.0, green: 108.0/255.0, blue: 042.0/255.0, alpha: 1.0)
    }

    // Secondary-Colors

    public static var darkestGray: Color {
        Color(hex: "#363636")// Color(red: 54.0/255.0, green: 54.0/255.0, blue: 54.0/255.0, alpha: 1.0)
    }

    public static var almostBlack: Color {
        Color(hex: "#00061D")// Color(red: 0.0, green: 6.0/255.0, blue: 29.0/255.0, alpha: 1.0)
    }

    public static var darkGray: Color {
        Color(hex: "#424242")// Color(red: 66.0/255.0, green: 66.0/255.0, blue: 66.0/255.0, alpha: 1.0)
    }

    public static var gray: Color {
        Color(hex: "#7a7a7a") // Color(red: 122.0/255.0, green: 122.0/255.0, blue: 122.0/255.0, alpha: 1.0)
    }

    public static var lightGray: Color {
        Color(hex: "#c4c4c4") // Color(red: 196.0/255.0, green: 196.0/255.0, blue: 196.0/255.0, alpha: 1.0)
    }

    public static var lighterGray: Color {
        Color(hex: "#e5e5e5") // Color(red: 231.0/255.0, green: 231.0/255.0, blue: 231.0/255.0, alpha: 1.0)
    }

    public static var almostWhite: Color {
        Color(hex: "#f5f5f5") // Color(red: 249.0/255.0, green: 249.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    }

    public static var fbkBlue: Color {
        Color(hex: "#095CCD") // Color(red: 9.0/255.0, green: 92.0/255.0, blue: 205.0/255.0, alpha: 1.0)
    }

    public static var skyBlue: Color {
        Color(red: 0.0/255.0, green: 165.0/255.0, blue: 223.0/255.0, alpha: 1.0)
    }

    public static var lightGreen: Color {
        Color(red: 241.0/255.0, green: 251.0/255.0, blue: 237.0/255.0, alpha: 1.0)
    }

    public static var warningSecondary: Color {
        ageRestriction
    }

    public static var shadow: Color {
        Color(hex: "00071C")
    }

    public static let darkPastelGreen: Color = Color(red: 9/255.0, green: 191/255.0, blue: 64/255.0, alpha: 1.0)

    public static let silverGray: Color = Color(red: 194/255.0, green: 194/255.0, blue: 194/255.0, alpha: 1.0)

    public static let secondary900: Color = Color(red: 60/255.0, green: 60/255.0, blue: 60/255.0, alpha: 1.0)

    public static let secondary700: Color = Color(red: 129/255.0, green: 129/255.0, blue: 129/255.0, alpha: 1.0)

    public static let azure: Color = Color(red: 237/255.0, green: 248/255.0, blue: 251/255.0, alpha: 1.0)

    // MARK: - Loyalty-Colors

    public static var loyaltyPrimary: Color {
        Color(red: 93.0/255.0, green: 154.0/255.0, blue: 211.0/255.0, alpha: 1.0)
    }

    public static var loyaltyBackground: Color {
        Color(red: 232.0/255.0, green: 240.0/255.0, blue: 249.0/255.0, alpha: 1.0)
    }

    public static var loyaltyPrimaryGradient: Color {
        Color(red: 163/255, green: 196/255, blue: 233/255, alpha: 1)
    }

    public static var freshGreen: Color {
        Color(red: 112.0/255.0, green: 209.0/255.0, blue: 89.0/255.0, alpha: 1.0)
    }

    public static var categoryClub: Color {
        Color(red: 232.0/255.0, green: 64.0/255.0, blue: 42.0/255.0, alpha: 1.0)
    }

    public static var categoryBonus: Color {
        Color(red: 253.0/255.0, green: 196.0/255.0, blue: 4.0/255.0, alpha: 1.0)
    }

    public static var categoryCoupons: Color {
        Color(red: 58.0/255.0, green: 93.0/255.0, blue: 171.0/255.0, alpha: 1.0)
    }

    public static var primary100: Color {
        Color(red: 253.0/255.0, green: 68.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    }

    public static var primary100darker: Color {
        Color(red: 226.0/255.0, green: 41.0/255.0, blue: 33.0/255.0, alpha: 1.0)
    }

    public static var primary900: Color {
        Color(red: 199.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }

    public static var partnerGradientWhite = Color(red: 243/255.0, green: 121/255.0, blue: 121/255.0, alpha: 1.0)

    public static var partnerGradientRed = Color(red: 213/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0)

    public static var partnerGradientDarkRed = Color(red: 160/255.0, green: 7/255.0, blue: 7/255.0, alpha: 1.0)

    public static let whiteSmoke: Color = Color(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)

    public static let secondary200 = Color(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)

    public static let secondary400 = Color(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 1.0)

    public static let secondary500 = Color(red: 194/255.0, green: 194/255.0, blue: 194/255.0, alpha: 1.0)

    public static let couponLightGold = Color(red: 251/255.0, green: 189/255.0, blue: 73/255.0, alpha: 1.0)

    public static let couponDarkGold = Color(red: 245/255.0, green: 165/255.0, blue: 35/255.0, alpha: 1.0)

    // Additional-Colors

    // MARK: - Cart
    public static let primary700 = Color(red: 225.0/255.0, green: 9.0/255.0, blue: 21.0/255.0, alpha: 1.0)

    // MARK: - Assortment
    public static let empress = Color(red: 116/255.0, green: 116/255.0, blue: 116/255.0, alpha: 1.0)

    public static let primary200 = Color(red: 250.0/255.0, green: 149.0/255.0, blue: 145.0/255.0, alpha: 1.0)

    public static let lightRed = Color(red: 1.0, green: 244.0/255.0, blue: 236.0/255.0, alpha: 1.0)

    // Store-Colors
    public static var storeOpen: Color {
        Color(red: 127.0/255.0, green: 186.0/255.0, blue: 78.0/255.0, alpha: 1.0)
    }

    public static var storeClosed: Color {
        red
    }

    // Flash-Color
    public static var flash: Color {
        yellow
    }

    // Tab-Colors
    public static var tabBar: Color {
        Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    // Recipe-Colors
    public static var recipeItemDimmedColor: Color {
        Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.85)
    }

    // Payback-Colors
    public static var paybackBlue: Color {
        Color(red: 0.0/255.0, green: 70.0/255.0, blue: 170.0/255.0, alpha: 1.0)
    }

    // Video-Colors
    public static var playVideoButtonDimmedColor: Color {
        Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.75)
    }

    // CoachMark-Colors
    public static var coachMarkOverlayDimmedColor: Color {
        Color(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.72)
    }

    // Alarm-Colors
    public static var activeBorderedButtonColor: Color {
        Color(red: 112.0/255.0, green: 209.0/255.0, blue: 89.0/255.0, alpha: 1.0)
    }

    // Coupons-Colors

    public static var statesSuccess: Color {
        Color(red: 9.0/255.0, green: 191.0/255.0, blue: 64.0/255.0, alpha: 1.0)
    }

    public static var successLight: Color {
        Color(red: 238.0/255.0, green: 255/255.0, blue: 236/255.0, alpha: 1.0)
    }

    public static var successDark: Color {
        Color(red: 45.0/255.0, green: 183.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    }

    public static var alwaysActive: Color {
        Color(red: 223.0/255.0, green: 244.0/255.0, blue: 227.0/255.0, alpha: 1.0)
    }

    public static var warning: Color {
        Color(red: 1.0, green: 181.0/255.0, blue: 0/255.0, alpha: 1.0)
    }

    public static let tahunaSands: Color = Color(red: 214/255, green: 198/255, blue: 148/255, alpha: 1.0)
    public static let validityYellow: Color = Color(red: 1.0, green: 218/255, blue: 127/255, alpha: 1.0)

    // FlagView-Colors

    public static var guardsmanRed: Color {
        Color(red: 199.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
    }

    public static var crimson: Color {
        Color(red: 225.0/255.0, green: 15.0/255.0, blue: 34.0/255.0, alpha: 1.0)
    }

    public static var redRibbon: Color {
        Color(red: 242.0/255.0, green: 14.0/255.0, blue: 32.0/255.0, alpha: 1.0)
    }

    public static var monza: Color {
        Color(red: 212.0/255.0, green: 0.0/255.0, blue: 11.0/255.0, alpha: 1.0)
    }

    // MSS colors
    public static var deleteArticle: Color {
        Color(hex: "#ff2200") // Color(red: 1.0, green: 34.0/255.0, blue: 0.0, alpha: 1.0)
    }

    public static var ageRestriction: Color {
        Color(hex: "#fff9e4") // Color(red: 1.0, green: 249.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    }

    public static var selectedColor: Color {
        Color(hex: "#2bce13") // Color(red: 43.0/255.0, green: 206.0/255.0, blue: 19.0/255.0, alpha: 1.0)
    }

    public static var highlightedColor: Color {
        Color(hex: "#2db719") // Color(red: 45.0/255.0, green: 183.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    }

    // StoreKit colors
    public static let lightGray245 = Color(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
    public static let green43 = Color(red: 43/255.0, green: 206/255.0, blue: 19/255.0, alpha: 1.0)
    public static let gray216 = Color(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 1.0)

    // ShoppingList Colors
    public static let lightInfo = Color(red: 234/255.0, green: 251/255.0, blue: 1.0, alpha: 1.0)
    public static let cancelGray = Color(red: 142/255.0, green: 142/255.0, blue: 147/255.0, alpha: 1.0)

    // Home Teaser Colors
    public static let recipeTeaserGradientStart = Color(red: 224/255.0, green: 219/255.0, blue: 210/255.0, alpha: 1.0)
    public static let recipeTeaserGradientEnd = Color(red: 240/255.0, green: 236/255.0, blue: 233/255.0, alpha: 1.0)

    public static let leafletTeaserGradientStart = Color(red: 184/255.0, green: 173/255.0, blue: 152/255.0, alpha: 1.0)
    public static let leafletTeaserGradientEnd = Color(red: 219/255.0, green: 206/255.0, blue: 185/255.0, alpha: 1.0)

    public static let magazineTeaserGradientStart = Color(red: 145/255.0, green: 141/255.0, blue: 133/255.0, alpha: 1.0)
    public static let magazineTeaserGradientEnd = Color(red: 198/255.0, green: 190/255.0, blue: 178/255.0, alpha: 1.0)

    public static let loyaltyRegistrationTeaserGradientEnd = Color(red: 163.0/255.0, green: 196.0/255.0, blue: 233.0/255.0, alpha: 1.0)

    public static let partnerBenefitsTeaserGradientStart = Color(red: 198/255.0, green: 148/255.0, blue: 53/255.0, alpha: 1.0)
    public static let partnerBenefitsTeaserGradientEnd = Color(red: 240/255.0, green: 219/255.0, blue: 140/255.0, alpha: 1.0)

    // MSS Checkout gradient colors
    public static let mssCheckoutGradientStart = Color(red: 199/255.0, green: 8/255.0, blue: 18/255.0, alpha: 1.0)
    public static let mssCheckoutGradientEnd = Color(red: 161/255.0, green: 6/255.0, blue: 14/255.0, alpha: 1.0)

    // Marketplace
    public static let energyRating1 = Color(hex: "#009641")
    public static let energyRating2 = Color(hex: "#52AE32")
    public static let energyRating3 = Color(hex: "#C8D300")
    public static let energyRating4 = Color(hex: "#FFED00")
    public static let energyRating5 = Color(hex: "#FBBA00")
    public static let energyRating6 = Color(hex: "#EC6608")
    public static let energyRating7 = Color(hex: "#E30613")
    public static let energyRating8 = Color(hex: "#C00202")
    public static let energyRating9 = Color(hex: "#A00202")
    public static let defaultEnergyRating = Color(hex: "#E30613")
}
