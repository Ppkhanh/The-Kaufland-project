//
//  UIView+Extension.swift
//  KMarketPlaceKit
//
//  Created by Marcus Hopp on 17.02.22.
//

import UIKit

extension UIView {
    public func addTopHairlineView() {
        borders(for: [.top], color: KauflandColors.lightGray)
    }

    public func borders(for edges: [UIRectEdge], width: CGFloat = 1, color: UIColor = .black) {

        if edges.contains(.all) {
            layer.borderWidth = width
            layer.borderColor = color.cgColor
        } else {
            let allSpecificBorders: [UIRectEdge] = [.top, .bottom, .left, .right]

            for edge in allSpecificBorders {
                if let view = viewWithTag(Int(edge.rawValue)) {
                    view.removeFromSuperview()
                }

                if edges.contains(edge) {
                    let view = UIView()
                    view.tag = Int(edge.rawValue)
                    view.backgroundColor = color
                    view.translatesAutoresizingMaskIntoConstraints = false
                    addSubview(view)

                    var horizontalVisualFormat = "H:"
                    var verticalVisualFormat = "V:"
                    let visualFormatValue = "|-(0)-[v]-(0)-|"

                    switch edge {
                    case UIRectEdge.bottom:
                        horizontalVisualFormat += visualFormatValue
                        verticalVisualFormat += "[v(\(width))]-(0)-|"
                    case UIRectEdge.top:
                        horizontalVisualFormat += visualFormatValue
                        verticalVisualFormat += "|-(0)-[v(\(width))]"
                    case UIRectEdge.left:
                        horizontalVisualFormat += "|-(0)-[v(\(width))]"
                        verticalVisualFormat += visualFormatValue
                    case UIRectEdge.right:
                        horizontalVisualFormat += "[v(\(width))]-(0)-|"
                        verticalVisualFormat += visualFormatValue
                    default:
                        break
                    }

                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": view]))
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": view]))
                }
            }
        }
    }
}
