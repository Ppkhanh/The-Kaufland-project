//
//  RatingsView.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 12.04.21.
//

import UIKit

class RatingsView: NibLoadingView {

    private typealias UIConstants = Constants.Rating

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var totalRatingsLabel: UILabel! {
        didSet {
            totalRatingsLabel.textColor = KauflandColors.secondary700
            totalRatingsLabel.font = UIFont.mediumSystemFont(ofSize: UIConstants.ratingsFontSize)
        }
    }

    var viewModel: RatingsViewModel? {
        didSet {
            fillStars()
            switchTotalRatings()
        }
    }

    override var bundle: Bundle {
        return Bundle.main
    }

    private func imageName(rating: Int) -> String {
        guard let viewModel = viewModel else { return "" }

        var imageName: String

        switch rating {
        case _ where 1...viewModel.rating ~= Double(rating + 1):
            imageName = "star_filled"
        case _ where 0..<1 ~= Double(rating + 1) - viewModel.rating:
            imageName = "star_half"
        default:
            imageName = "star_outlined"
        }

        return imageName
    }

    private func fillStars() {
        guard  let viewModel = viewModel, viewModel.rating != 0 else {
            stackView.isHidden = true
            return
        }

        for rating in 0..<UIConstants.maxRatingCount {
            guard let imageView = stackView.subviews[rating] as? UIImageView else { break }

            stackView.isHidden = false
            let name = imageName(rating: rating)
            imageView.image = UIImage(named: name, in: Bundle.main, compatibleWith: nil)
        }
    }

    private func switchTotalRatings() {
        guard let viewModel = viewModel,
              let totalRatings = viewModel.totalRatings, totalRatings > 0 else {
            totalRatingsLabel.isHidden = true
            return
        }

        totalRatingsLabel.isHidden = false

        guard let ratingText = viewModel.ratingText else {
            totalRatingsLabel.text = String(totalRatings)
            return
        }

        totalRatingsLabel.font = Constants.CustomerReview.reviewCountFont
        totalRatingsLabel.textColor = KauflandColors.secondary900
        totalRatingsLabel.text = ratingText
    }

    // MARK: - Actions
    @IBAction func showRatings(_ sender: Any) {
        viewModel?.onRatingsSelection?()
    }
}
