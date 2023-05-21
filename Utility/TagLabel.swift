//
//  TagLabel.swift
//  KCommonUIKit
//
//  Created by Felix Zardai on 03.08.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import UIKit

/// @DOC: ONLY USABLE FOR SINGEL LINE UILABLE
open class TagLabel: UILabel {

    public var topInset: CGFloat = 0 // Constants.TagLabel.inset
    public var bottomInset: CGFloat = 0 // Constants.TagLabel.inset
    public var leftInset: CGFloat = Constants.TagLabel.inset
    public var rightInset: CGFloat = Constants.TagLabel.inset

    private var insets: UIEdgeInsets {
        get {
            return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        }
        set {
            topInset = newValue.top
            leftInset = newValue.left
            bottomInset = newValue.bottom
            rightInset = newValue.right
        }
    }

    public func resetInsets() {
        insets = UIEdgeInsets(top: 0, left: Constants.TagLabel.inset, bottom: 0, right: Constants.TagLabel.inset)
        invalidateIntrinsicContentSize()
    }

    public func removeInsets() {
        insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        invalidateIntrinsicContentSize()
    }

    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }

    public override var intrinsicContentSize: CGSize {
        let contentSize = super.intrinsicContentSize
        return CGSize(width: contentSize.width + leftInset + rightInset,
                      height: contentSize.height + topInset + bottomInset)
    }

    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        let contentSize = super.sizeThatFits(size)
        return CGSize(width: contentSize.width + leftInset + rightInset,
                      height: contentSize.height + topInset + bottomInset)
    }

}
