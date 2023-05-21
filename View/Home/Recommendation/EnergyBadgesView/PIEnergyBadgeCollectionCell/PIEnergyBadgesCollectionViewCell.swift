//
//  EnergyBadgesCollectionViewCell.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 05.07.21.
//

import UIKit

class PIEnergyBadgesCollectionViewCell: UICollectionViewCell, Reusable {
    @IBOutlet private weak var energyRatingView: PIEnergyRatingView!

    var viewModel: PIEnergyBadgesCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            energyRatingView.viewModel = viewModel.energyRatingViewModel()
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }

    override func prepareForReuse() {
        energyRatingView.viewModel = nil
    }
}
