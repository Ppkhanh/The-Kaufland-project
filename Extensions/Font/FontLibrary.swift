//
//  FontLibrary.swift
//  KCommonUIKit-iOS
//
//  Created by Bisma Saeed on 11.07.22.
//  Copyright © 2022 Markus Troßbach. All rights reserved.
//

import UIKit

public extension UIFont {

    /// DISPLAY 1
    static var display1: UIFont {
        UIFont.boldKauflandFont(ofSize: 60)
    }

    /// DISPLAY 2
    static var display2: UIFont {
        UIFont.mediumKauflandFont(ofSize: 36)
    }

    /// DISPLAY 3
    static var display3: UIFont {
        UIFont.mediumKauflandFont(ofSize: 28)
    }

    /// TOPBAR TITLE
    static var topbarTitle: UIFont {
        UIFont.mediumKauflandFont(ofSize: 17)
    }

    /// TITLE 1
    static var title1: UIFont {
        UIFont.mediumKauflandFont(ofSize: 20)
    }

    /// TITLE 2
    static var title2: UIFont {
        UIFont.boldKauflandFont(ofSize: 16)
    }

    /// TITLE 3
    static var title3: UIFont {
        UIFont.mediumSystemFont(ofSize: 14)
    }

    /// TITLE 4
    static var title4: UIFont {
        UIFont.mediumSystemFont(ofSize: 12)
    }

    /// BODY 1.0
    static var body10: UIFont {
        UIFont.boldSystemFont(ofSize: 16)
    }

    /// BODY 1.1
    static var body11: UIFont {
        UIFont.mediumSystemFont(ofSize: 16)
    }

    /// BODY 1.2
    static var body12: UIFont {
        UIFont.systemFont(ofSize: 16)
    }

    /// BODY 2.0
    static var body20: UIFont {
        UIFont.boldSystemFont(ofSize: 14)
    }

    /// BODY 2.1
    static var body21: UIFont {
        UIFont.mediumSystemFont(ofSize: 14)
    }

    /// BODY 2.2
    static var body22: UIFont {
        UIFont.systemFont(ofSize: 14)
    }

    /// CAPTION 1
    static var caption1: UIFont {
        UIFont.systemFont(ofSize: 12)
    }

    /// CAPTION 2
    static var caption2: UIFont {
        UIFont.boldSystemFont(ofSize: 12)
    }

    /// CAPTION 3
    static var caption3: UIFont {
        UIFont.boldSystemFont(ofSize: 10)
    }

    /// PRICE 1
    static var price1: UIFont {
        UIFont.heavyKauflandFont(ofSize: 32)
    }

    /// PRICE 2
    static var price2: UIFont {
        UIFont.heavyKauflandFont(ofSize: 24)
    }

    /// PRICE 3
    static var price3: UIFont {
        UIFont.heavyKauflandFont(ofSize: 16)
    }

    /// CROSSED-OUT PRICE 1
    static var crossedOutPrice1: UIFont {
        UIFont.kauflandFont(ofSize: 16)
    }

    /// LABEL 1
    static var label1: UIFont {
        UIFont.mediumKauflandFont(ofSize: 16)
    }

    /// LABEL 2
    static var label2: UIFont {
        UIFont.mediumKauflandFont(ofSize: 12)
    }
}
