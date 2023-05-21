//
//  FontExtension+FontFamily.swift
//  KCommonUIKit
//
//  Created by Felix Zardai on 11.08.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import UIKit

extension UIFont {

    /* --------------------
     PAYBACK
     ------------------- */

    public static var paybackFontName: String {
        return "Payback"
    }

    public static var regularPaybackFontName: String {
        return "\(paybackFontName)"
    }

    /* --------------------
     KAUFLAND
     ------------------- */

    public static var kauflandFontName: String {
        return "Kaufland"
    }

    public static var italicPostfix: String {
        return "Italic"
    }

    /* REGULAR */

    public static var regularKauflandFontName: String {
        return "\(kauflandFontName)-Regular"
    }

    public static var regularItalicKauflandFontName: String {
        return "\(kauflandFontName)-RegularItalic"
    }

    /* MEDIUM */

    public static var mediumKauflandFontName: String {
        return "\(kauflandFontName)-Medium"
    }

    public static var mediumItalicKauflandFontName: String {
        return "\(kauflandFontName)-Medium\(italicPostfix)"
    }

    /* BOLD */

    public static var boldKauflandFontName: String {
        return "\(kauflandFontName)-Bold"
    }

    public static var boldItalicKauflandFontName: String {
        return "\(kauflandFontName)-Bold\(italicPostfix)"
    }

    /* BOLD PLUS */

    public static var boldPlusKauflandFontName: String {
        return "\(kauflandFontName)-Bold+"
    }

    public static var boldPlusItalicKauflandFontName: String {
        return "\(kauflandFontName)-Bold+\(italicPostfix)"
    }

    /* HEAVY */

    public static var heavyKauflandFontName: String {
        return "\(kauflandFontName)-Heavy"
    }

    public static var heavyItalicKauflandFontName: String {
        return "\(kauflandFontName)-Heavy\(italicPostfix)"
    }

    /* LIGHT */

    public static var lightKauflandFontName: String {
        return "\(kauflandFontName)-Light"
    }

    public static var lightItalicKauflandFontName: String {
        return "\(kauflandFontName)-Light\(italicPostfix)"
    }

    /* ICON */

    public static var kauflandIconFontName: String {
        return "\(kauflandFontName)-Icon"
    }

    /* --------------------
     CREDITCARD
     ------------------- */

    public static var creditCardFontName: String {
        return "RobotoMono"
    }

    public static var regularCreditCardFontName: String {
        return "\(creditCardFontName)-Light"
    }
}
