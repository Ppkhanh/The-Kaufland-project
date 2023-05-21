//
//  PIEnergyBadgeView.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 21.10.21.
//

import UIKit

class PIEnergyBadgeView: NibLoadingView {
    private typealias UIConst = Constants.PIEnergyBadgeView

    var didTap: (() -> Void)?

    @IBOutlet private weak var triangleView: UIView!
    @IBOutlet private weak var energyLevelView: UIView!
    @IBOutlet private weak var energyLevelLabel: UILabel! {
        didSet {
            energyLevelLabel.font = UIConst.energyLevelFont
            energyLevelLabel.textColor = KauflandColors.white
        }
    }

    @IBOutlet private weak var energyRangeMaxLabel: UILabel! {
        didSet {
            energyRangeMaxLabel.font = UIConst.energyRangeFont
            energyRangeMaxLabel.textColor = KauflandColors.secondary900
        }
    }

    @IBOutlet private weak var energyRangeMinLabel: UILabel! {
        didSet {
            energyRangeMinLabel.font = UIConst.energyRangeFont
            energyRangeMinLabel.textColor = KauflandColors.secondary900
        }
    }

    var viewModel: PIEnergyBadgeViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            energyLevelLabel.text = viewModel.level
            energyRangeMaxLabel.text = viewModel.maxRange
            energyRangeMinLabel.text = viewModel.minRange
            energyLevelView.backgroundColor = viewModel.color
            triangleView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            triangleView.addTriangle(color: viewModel.color)
        }
    }

    @IBAction private func didTapBadge(_ sender: UITapGestureRecognizer) {
        didTap?()
    }

    override var bundle: Bundle {
        return Bundle.main
    }
}


extension UIView {
    func addTriangle(color: UIColor) {
        let width = frame.size.width
        let height = frame.size.height

        let path = CGMutablePath()
        path.move(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: 0, y: height / 2))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: width, y: 0))

        let shape = CAShapeLayer()
        shape.path = path
        shape.fillColor = color.cgColor

        layer.addSublayer(shape)
    }
}
