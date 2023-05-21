//
//  NameInCircleView.swift
//  KCommonUIKit-iOS
//
//  Created by Martin Vasilev on 17.08.21.
//  Copyright © 2021 Markus Troßbach. All rights reserved.
//

import Foundation
import UIKit

public class NameInCircleView: NibLoadingView {

    @IBOutlet private weak var circleBackgroundView: UIView! {
        didSet {
            circleBackgroundView.backgroundColor = KauflandColors.red
            circleBackgroundView.roundCorners()
        }
    }

    @IBOutlet private weak var initialsLabel: UILabel! {
        didSet {
            initialsLabel.font = Constants.NameInCircleView.font
            initialsLabel.textColor = KauflandColors.white
            initialsLabel.minimumScaleFactor = 0.5
            initialsLabel.adjustsFontSizeToFitWidth = true
        }
    }

    public func setupWith(initials: String?) {
        initialsLabel.text = initials
    }

    public override var bundle: Bundle {
        Bundle.main
    }
}
