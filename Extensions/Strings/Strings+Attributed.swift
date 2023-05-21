//
//  String+Attributed.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 18.05.22.
//

import Foundation
import UIKit

extension String {
    func underlined(font: UIFont, textColor: UIColor) -> NSMutableAttributedString {
        let underlineStringAttrributes: [NSAttributedString.Key: Any] = [.font: font,
                                                                         .foregroundColor: textColor,
                                                                         .underlineStyle: NSUnderlineStyle.single.rawValue]
        return NSMutableAttributedString(string: self,
                                         attributes: underlineStringAttrributes)
    }
}
