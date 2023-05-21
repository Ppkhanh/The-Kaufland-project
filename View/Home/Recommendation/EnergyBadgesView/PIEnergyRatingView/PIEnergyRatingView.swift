//
//  EnergyRatingView.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 19.10.21.
//

import UIKit

class PIEnergyRatingView: NibLoadingView {
    private typealias UIConst = Constants.PIEnergyRatings

    @IBOutlet private weak var energyBadgeView: PIEnergyBadgeView!
    @IBOutlet private weak var energyBadgeOldView: PIEnergyBadgeOldView!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var energyRatingsStackViewHeight: NSLayoutConstraint!

    var viewModel: PIEnergyRatingViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                energyBadgeView.isHidden = true
                energyBadgeView.viewModel = nil

                energyBadgeOldView.isHidden = true
                energyBadgeOldView.viewModel = nil
                return
            }

            energyRatingsStackViewHeight.constant = viewModel.isForPDP ? UIConst.contentHeightPDP : UIConst.contentHeight

            let energyBadgeViewModel = viewModel.energyBadgeViewModel

            if viewModel.showOldRating {
                energyBadgeView.isHidden = true
                energyBadgeView.viewModel = nil

                energyBadgeOldView.isHidden = false
                energyBadgeOldView.viewModel = energyBadgeViewModel
                energyBadgeOldView.didTap = didTap
            } else {
                energyBadgeOldView.isHidden = true
                energyBadgeOldView.viewModel = nil

                energyBadgeView.isHidden = false
                energyBadgeView.viewModel = energyBadgeViewModel
                energyBadgeView.didTap = didTap
            }

            stackView.alignment = viewModel.badgeAlignment == .right ? .trailing : .leading
        }
    }

    private func didTap() {
 //       guard let energyLabel = viewModel?.energyRating.label else { return }

//        let imagePresenterViewModel = ImagePresenterViewModel(imageObject: energyLabel)
//        let vc = MarketPlaceRouter.instantiateImagePresenterViewController(withViewModel: imagePresenterViewModel)
//        let topMost = Facade.delegate.topMostViewController
//        topMost?.navigationController?.pushViewController(vc, animated: true)
    }

    override var bundle: Bundle {
        return Bundle.main
    }
}
