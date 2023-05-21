//
//  FontExtension.swift
//  KCommonUIKit
//
//  Created by Markus Troßbach on 16/05/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import UIKit
import SwiftUI

public extension UIFont {

    var shouldSubstituteFont: Bool {
        return fontName.range(of: UIFont.kauflandIconFontName) == nil
            && fontName.range(of: UIFont.regularPaybackFontName) == nil
            && fontName.range(of: UIFont.regularCreditCardFontName) == nil
    }

    class func ultraLightSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.ultraLight)
    }

    class func thinSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.thin)
    }

    class func lightSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.light)
    }

    class func mediumSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
    }

    class func semiboldSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.semibold)
    }

    class func heavySystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.heavy)
    }

    class func blackSystemFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.black)
    }

    /* --------------------
     PAYBACK
     ------------------- */

    class func paybackFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: UIFont.regularPaybackFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.regular)
    }

    /* --------------------
     KAUFLAND
     ------------------- */

    class func kauflandFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: UIFont.regularKauflandFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.regular)
    }

    class func heavyKauflandFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: UIFont.heavyKauflandFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.heavy)
    }

    class func boldPlusKauflandFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: UIFont.boldPlusKauflandFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.black)
    }

    class func boldKauflandFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: UIFont.boldKauflandFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.bold)
    }

    class func heavyItalicKauflandFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: UIFont.heavyItalicKauflandFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.heavy)
    }

    class func mediumKauflandFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: UIFont.mediumKauflandFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
    }

    class func lightKauflandFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: UIFont.lightKauflandFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.light)
    }

    /* --------------------
     CREDITCARD
     ------------------- */

    class func creditCardFont(ofSize fontSize: CGFloat) -> UIFont {
        return UIFont(name: UIFont.regularCreditCardFontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.regular)
    }
}

/// @DOC: Will be useful in the future
public extension UIFont {

    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
}

// - MARK: SwiftUI

public extension UIFont {
    var swiftUI: Font {
        Font(self)
    }
}
