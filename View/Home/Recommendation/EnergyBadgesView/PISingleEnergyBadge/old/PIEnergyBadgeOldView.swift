//
//  PIEnergyBadgeOldView.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 21.10.21.
//

import UIKit

// Only required until the end of 2021, should be deleted afterwards

class PIEnergyBadgeOldView: NibLoadingView {
    private typealias UIConst = Constants.EnergyBadgeOldView

    var didTap: (() -> Void)?

    @IBOutlet private weak var triangleView: UIView!
    @IBOutlet private weak var energyLevelView: UIView!
    @IBOutlet private weak var energyLevelLabel: UILabel! {
        didSet {
            energyLevelLabel.font = UIConst.energyLevelPIFont
            energyLevelLabel.textColor = UIColor.white
        }
    }

    @IBOutlet private weak var energyLevelAdditionLabel: UILabel! {
        didSet {
            energyLevelAdditionLabel.font = UIConst.energyLevelAdditionFont
            energyLevelAdditionLabel.textColor = UIColor.white
        }
    }

    @IBOutlet private weak var energyRangeLabel: UILabel! {
        didSet {
            energyRangeLabel.font = UIConst.energyRangeFont
            energyRangeLabel.textColor = KauflandColors.secondary700
        }
    }

    @IBOutlet private weak var stackView: UIStackView!

    var viewModel: PIEnergyBadgeViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            energyLevelView.backgroundColor = viewModel.color
            triangleView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            triangleView.addTriangle(color: viewModel.color)

            let level = viewModel.level
            guard level.count > 0 else { return }

            energyLevelLabel.text = String(level.prefix(UIConst.energyLevelFirstCharPosition))
            energyRangeLabel.text = viewModel.range
            energyLevelAdditionLabel.text = String(level.suffix(level.count - UIConst.energyLevelFirstCharPosition))
            energyRangeLabel.isHidden = viewModel.showOnlyBadge
            stackView.alignment = .trailing
        }
    }

    @IBAction private func didTapBadge(_ sender: UITapGestureRecognizer) {
        didTap?()
    }

    override var bundle: Bundle {
        return Bundle.main
    }
}
