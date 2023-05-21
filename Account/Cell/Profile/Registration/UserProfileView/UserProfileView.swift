//
//  UserProfileView.swift
//  KCommonUIKit-iOS
//
//  Created by Zuhaib Rasheed on 31.08.21.
//  Copyright © 2021 Markus Troßbach. All rights reserved.
//

import Foundation
import UIKit

public class UserProfileView: NibLoadingView {
    private typealias UIConst = Constants.UserProfileView

    @IBOutlet private weak var nameCircleView: NameInCircleView!

    @IBOutlet private weak var containerView: UIView! {
        didSet {
            containerView.layer.cornerRadius = UIConst.cornerRadius
            containerView.layer.applySketchShadow()
        }
    }

    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIConst.titleFont
        }
    }

    @IBOutlet private weak var subTitleLabel: UILabel! {
        didSet {
            subTitleLabel.font = UIConst.subtitleFont
            subTitleLabel.textColor = KauflandColors.secondary700
        }
    }

    public var viewModel: UserProfileViewModel? {
        didSet {
            setupUI()
        }
    }

    private func setupUI() {
        guard let viewModel = viewModel else { return }

        titleLabel.textColor = viewModel.titleColor
        nameCircleView.isHidden = viewModel.hideNameView
        nameCircleView.setupWith(initials: viewModel.nameInitials)
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subtitle
    }

    public override var bundle: Bundle {
        Bundle.main
    }
}
