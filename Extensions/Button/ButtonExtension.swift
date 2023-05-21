//
//  ButtonExtension.swift
//  KCommonUIKit
//
//  Created by Felix Zardai on 27.07.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import UIKit

public enum VerticalAlignment: String {
    case center, top, bottom, unset
}

public enum HorizontalAlignment: String {
    case center, left, right, unset
}

public extension UIButton {

    func setAttributedTitleColor(_ color: Color?, for state: UIControl.State) {
        if let attributedTitle = attributedTitle(for: state) {
            let color = color ?? Color.black
            let range = NSRange(location: 0, length: attributedTitle.length)
            let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)

            mutableAttributedTitle.removeAttribute(NSAttributedString.Key.foregroundColor, range: range)
            mutableAttributedTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }

    private func setVerticalAlignment(imageVerticalAlignment: VerticalAlignment,
                                      textHeight: CGFloat,
                                      imageHeight: CGFloat) {
        switch imageVerticalAlignment {
        case .center:
            contentVerticalAlignment = .center
        case .top:
            /// @DOC: Image over text
            imageEdgeInsets.top = -textHeight
            titleEdgeInsets.top = imageHeight
        case .bottom:
            /// @DOC: Image under text
            imageEdgeInsets.bottom = -textHeight
            titleEdgeInsets.top = -imageHeight
        case .unset:
            break
        }
    }

    private func setHorizontalAlignment(imageHorizontalAlignment: HorizontalAlignment,
                                        imageVerticalAlignment: VerticalAlignment,
                                        textWidth: CGFloat,
                                        imageWidth: CGFloat) {
        switch imageHorizontalAlignment {
        case .center:
            if imageVerticalAlignment == .top || imageVerticalAlignment == .bottom {
                imageEdgeInsets.right = -textWidth // + 4.0
                titleEdgeInsets.left = -imageWidth // + 2.0
            } else {
                contentHorizontalAlignment = .center

                titleEdgeInsets.left = 4.0
                titleEdgeInsets.right = -4.0
            }
        case .left:
            if imageVerticalAlignment == .top || imageVerticalAlignment == .bottom {
                titleEdgeInsets.left = -(imageWidth * 2)
            } else {
                titleEdgeInsets.left = 4.0
                titleEdgeInsets.right = -4.0
            }
        case .right:
            if imageVerticalAlignment == .top || imageVerticalAlignment == .bottom {
                imageEdgeInsets.right = -(textWidth + (imageWidth * 2)) // + 6.0
            } else {
                imageEdgeInsets.right = -(textWidth + (imageWidth * 2))
                titleEdgeInsets.left = -(imageWidth * 2) - 8.0
            }
        case .unset:
            break
        }
    }

    func align(vertical imageVerticalAlignment: VerticalAlignment,
               horizontal imageHorizontalAlignment: HorizontalAlignment,
               spacing: CGFloat = 0.0) {
        guard let imageSize = imageView?.image?.size,
            let text = currentTitle,
            let font = titleLabel?.font
            else { return }

        let titleSize = text.size(withAttributes: [NSAttributedString.Key.font: font])

        let imageWidth = imageSize.width
        let imageHeight = imageSize.height + spacing

        let textWidth = titleSize.width
        let textHeight = titleSize.height + spacing

        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

        setVerticalAlignment(imageVerticalAlignment: imageVerticalAlignment, textHeight: textHeight, imageHeight: imageHeight)
        setHorizontalAlignment(imageHorizontalAlignment: imageHorizontalAlignment, imageVerticalAlignment: imageVerticalAlignment, textWidth: textWidth, imageWidth: imageWidth)

        if imageVerticalAlignment == .top || imageVerticalAlignment == .bottom {
            if let _ = titleLabel?.bounds,
                let _ = imageView?.bounds {
                let edgeOffset = abs(titleSize.height - imageSize.height) / 2
                let contentOffset = abs(titleSize.width - imageSize.width) / 2

                contentEdgeInsets.top = edgeOffset
                contentEdgeInsets.bottom = edgeOffset

                contentEdgeInsets.left = -contentOffset
                contentEdgeInsets.right = -contentOffset
            }
        } else {
            contentEdgeInsets.left = 0.0
            contentEdgeInsets.right = 4.0
        }

        sizeToFit()
    }

    static func withImage(_ image: UIImage?, andText text: String?) -> UIButton {
        let button = UIButton(type: .system)

        button.setImage(image, for: .normal)
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = UIFont.kauflandFont(ofSize: 11)
        button.titleLabel?.textAlignment = .center

        return button
    }

    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping() -> Void) {
        @objc class ClosureSleeve: NSObject {
            let closure: () -> Void
            init(_ closure: @escaping() -> Void) { self.closure = closure }
            @objc func invoke() { closure() }
        }
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }

    func setTitleColor(normalColor: UIColor?, highlightedColor: UIColor?) {
        setTitleColor(normalColor, for: .normal)
        setTitleColor(highlightedColor, for: .highlighted)
    }
}
