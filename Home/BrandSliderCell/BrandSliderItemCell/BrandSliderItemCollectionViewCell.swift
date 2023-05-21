//
//  BrandSliderItemCollectionViewCell.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 14.09.22.
//

import Nuke
import NukeWebPPlugin
import UIKit

class BrandSliderItemCollectionViewCell: UICollectionViewCell, Reusable {
    typealias UIConst = Constants.BrandSliderView

    @IBOutlet private weak var brandImage: UIImageView!

    var viewModel: BrandSliderItemCollectionViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            guard let imageURL = viewModel.imageURL else { return }
            Nuke.loadImage(with: imageURL, options: ImageLoadingOptions(failureImage: viewModel.categoryPlaceHolderImage), into: brandImage)
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8.0
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = false
        addShadow()
    }

    private func addShadow() {
        let shadow = UIConst.parentViewItemCellShadow
        layer.applySketchShadow(sketchShadow: shadow)
    }
}
