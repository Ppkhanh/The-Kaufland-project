//
//  ViewExtension.swift
//  KCommonUIKit
//
//  Created by Felix Zardai on 29.12.17.
//  Copyright © 2017 Felix Zardai. All rights reserved.
//

import UIKit

public extension UIView {

    var safeTopAnchor: NSLayoutYAxisAnchor {
        return self.safeAreaLayoutGuide.topAnchor
    }

    var safeLeadingAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.leadingAnchor
    }

    var safeTrailingAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.trailingAnchor
    }

    var safeLeftAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.leftAnchor
    }

    var safeRightAnchor: NSLayoutXAxisAnchor {
        return self.safeAreaLayoutGuide.rightAnchor
    }

    var safeBottomAnchor: NSLayoutYAxisAnchor {
        return self.safeAreaLayoutGuide.bottomAnchor
    }

}

public extension UIView {

    func withPadding(padding: UIEdgeInsets) -> UIView {
        let container = UIView()
        self.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)

        NSLayoutConstraint.activate([
            self.leftAnchor.constraint(equalTo: container.leftAnchor, constant: padding.left),
            self.rightAnchor.constraint(equalTo: container.rightAnchor, constant: padding.right),
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: padding.top),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: padding.bottom)
        ])

        return container
    }

    func addFullSizedSubview(view: UIView?, withInsets insets: UIEdgeInsets = .zero) {
        guard let view = view else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: insets.right),
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: insets.bottom)
        ])

    }

    func addCenteredSubview(view: UIView?, width: CGFloat, height: CGFloat) {
        guard let view = view else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            view.widthAnchor.constraint(equalToConstant: width),
            view.heightAnchor.constraint(equalToConstant: height)
        ])

    }

    // @DOC - Got it from - https://www.hackingwithswift.com/example-code/calayer/how-to-change-a-views-anchor-point-without-moving-it
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y)

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }

    func toImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: bounds.size)
        let image = renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
        return image
    }

    func roundCorners() {
        self.layer.cornerRadius = self.bounds.height / 2
    }

    @objc func toPDF(filename: String) -> URL? {
        let pdfData = NSMutableData()

        UIGraphicsBeginPDFContextToData(pdfData, bounds, nil)
        UIGraphicsBeginPDFPageWithInfo(bounds, nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()

        guard let cachesDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
            return nil
        }

        let filePath = cachesDir + "/" + filename + ".pdf"
        pdfData.write(toFile: filePath, atomically: true)

        return URL(fileURLWithPath: filePath)
    }
}

public extension UIView {
    static func addGradient(on view: UIView, colors: [CGColor], frame: CGRect,
                            startPoint: CGPoint = CGPoint(x: 0.0, y: 0.5),
                            endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5)) -> CAGradientLayer {
        let gradientColors = colors

        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = gradientColors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        view.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}

public extension UIScrollView {
    /// @DOC: https://medium.com/@bermaniastudios/generating-a-pdf-from-a-uiscrollview-7dff2045bc31
    /// Slightly adjusted the original solution to zero out the content offset for multiple pages pdfs (The original doesn't work correctly without it)
    override func toPDF(filename: String) -> URL? {
        let savedContentOffset = contentOffset
        let savedContentInset = contentInset
        contentOffset = .zero
        contentInset = .zero

        let pageDimensions = bounds
        let pageSize = pageDimensions.size
        let totalSize = contentSize

        let numberOfPagesThatFitHorizontally = Int(ceil(totalSize.width / pageSize.width))
        let numberOfPagesThatFitVertically = Int(ceil(totalSize.height / pageSize.height))
        let pdfData = NSMutableData()

        UIGraphicsBeginPDFContextToData(pdfData, pageDimensions, nil)

        UIGraphicsBeginPDFPageWithInfo(CGRect(x: 0, y: 0, width: totalSize.width, height: totalSize.height), nil)

        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        for indexHorizontal in 0 ..< numberOfPagesThatFitHorizontally {
            for indexVertical in 0 ..< numberOfPagesThatFitVertically {
                let offsetHorizontal = CGFloat(indexHorizontal) * pageSize.width
                let offsetVertical = CGFloat(indexVertical) * pageSize.height

                contentOffset = CGPoint(x: offsetHorizontal, y: offsetVertical)

                layer.render(in: context)
            }
        }

        UIGraphicsEndPDFContext()

        contentInset = savedContentInset
        contentOffset = savedContentOffset

        if let cachesDir = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first {
            let documentsFileName = cachesDir + "/" + filename + ".pdf"
            pdfData.write(toFile: documentsFileName, atomically: true)

            return URL(fileURLWithPath: documentsFileName)
        }

        return nil
    }
}

