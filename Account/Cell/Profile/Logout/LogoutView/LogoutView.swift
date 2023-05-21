//
//  LogoutView.swift
//  KCommonUIKit-iOS
//
//  Created by Zuhaib Rasheed on 31.08.21.
//  Copyright © 2021 Markus Troßbach. All rights reserved.
//

import Foundation
import UIKit

public class LogoutView: NibLoadingView {
    private typealias UIConst = Constants.LogoutView

    @IBOutlet private weak var logoutLabel: UILabel! {
        didSet {
            logoutLabel.font = UIConst.logoutFont
            logoutLabel.textColor = KauflandColors.secondary900
        }
    }

    public var viewModel: LogoutViewModel? {
        didSet {
            setupUI()
        }
    }

    private func setupUI() {
        guard let viewModel = viewModel else { return }

        logoutLabel.text = viewModel.logout
    }

    public override var bundle: Bundle {
        Bundle.main
    }
}
