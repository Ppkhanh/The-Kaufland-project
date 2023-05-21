//
//  PromoSliderItemCollectionViewCell.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 16.08.22.
//

import Nuke
import NukeWebPPlugin
import UIKit

class PromoSliderItemCollectionViewCell: UICollectionViewCell, Reusable {
    typealias UIConst = Constants.PromoSliderView

    @IBOutlet private weak var headingLabel: UILabel! {
        didSet {
            headingLabel.font = Fonts.boldKauflandFont18
            headingLabel.textColor = KauflandColors.secondary900
        }
    }

    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = Fonts.boldKauflandFont14
            descriptionLabel.textColor = KauflandColors.red
        }
    }

    @IBOutlet private weak var promoImage: UIImageView!

    var viewModel: PromoSliderItemCollectionViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            headingLabel.text = viewModel.promoHeading
            descriptionLabel.text = viewModel.promoDescription

            guard let imageURL = viewModel.imageURL else { return }
            Nuke.loadImage(with: imageURL, options: ImageLoadingOptions(failureImage: viewModel.promoPlaceHolderImage), into: promoImage)
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
}
