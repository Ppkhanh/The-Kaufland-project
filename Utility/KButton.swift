//
//  KButton.swift
//  KCommonUIKit-iOS
//
//  Created by Denislava Shentova on 25.01.21.
//  Copyright © 2021 Markus Troßbach. All rights reserved.
//

import UIKit

///
/// A simple class providing frequently used styling options
/// - Important:
/// Set your button type as 'Custom' in the storyboard or .xib or init method otherwise the highlight logic will NOT work
///
open class KButton: UIButton {
    private typealias UIConst = Constants.KButton

    public enum ButtonState {
        case normal
        case inactive
        case active
    }

    public enum ButtonStyle {
        case primary(state: ButtonState = .normal, hasShadow: Bool = false)
        case secondary(state: ButtonState = .normal, hasShadow: Bool = false)
        case textOnly(state: ButtonState = .normal)
    }

    private(set) var style: ButtonStyle = .primary(state: .active, hasShadow: false)

    public func style(as style: ButtonStyle, font: UIFont = UIFont.preferredFont(for: .callout, weight: .bold)) {

        self.style = style
        switch style {
        case .primary(let state, let hasShadow):
            switch state {
            case .active, .normal:
                backgroundColor = KauflandColors.primary
                setTitleColor(normalColor: KauflandColors.white, highlightedColor: KauflandColors.white)
            case .inactive:
                backgroundColor = KauflandColors.secondary400
                setTitleColor(normalColor: KauflandColors.secondary700, highlightedColor: KauflandColors.secondary700)
            }
            if hasShadow { addShadow() }
            layer.cornerRadius = frame.size.height/2.0
        case .secondary(let state, let hasShadow):
            switch state {
            case .active:
                backgroundColor = KauflandColors.statesSuccess
                setTitleColor(normalColor: KauflandColors.white, highlightedColor: KauflandColors.white)
                imageView?.tintColor = KauflandColors.white
                if hasShadow { addShadow() }
            case .normal, .inactive:
                backgroundColor = KauflandColors.white
                setTitleColor(KauflandColors.secondary900, for: .normal)
                imageView?.tintColor = KauflandColors.secondary900
                if hasShadow {
                    addShadow()
                } else {
                    layer.borderColor = KauflandColors.secondary900.cgColor
                    layer.borderWidth = 1.0
                }
            }
            layer.cornerRadius = frame.size.height/2.0
        case .textOnly:
            backgroundColor = UIColor.clear
            setTitleColor(normalColor: KauflandColors.secondary900, highlightedColor: KauflandColors.black)
        }

        // no title - no need for insets
        if title(for: .normal)?.count == 0 || title(for: .normal) == nil  {
            contentEdgeInsets = UIEdgeInsets.zero
        } else {
            contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        }

        titleLabel?.font = font
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.lineBreakMode = .byClipping
        adjustsImageWhenHighlighted = false
    }

    public override var isHighlighted: Bool {
        didSet {
            switch style {
            case .primary(let state, _):
                if state == .active || state == .normal {
                    backgroundColor = isHighlighted ? KauflandColors.primary900 : KauflandColors.primary
                }
            case .secondary(let state, _):
                if state == .active {
                    backgroundColor = isHighlighted ? KauflandColors.successDark : KauflandColors.statesSuccess
                } else {
                    backgroundColor = isHighlighted ? KauflandColors.secondary200 : KauflandColors.white
                }
            default: break
            }
        }
    }

    private func addShadow() {
        layer.shadowRadius = UIConst.shadowRadius
        layer.shadowOpacity = UIConst.shadowOpacity
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.black.cgColor
    }
}
