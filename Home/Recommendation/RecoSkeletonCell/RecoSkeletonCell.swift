//
//  RecoSkeletonCell.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 10.12.21.
//

import UIKit

class RecoSkeletonCell: UICollectionViewCell, Reusable {
    typealias UIConst = Constants.PDP

    @IBOutlet private weak var containerView: UIView!

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }

    func addBlinkAnimation() {
        for view in containerView.subviews where view.layer.animation(forKey: Constants.BlinkableAnimation.animation) == nil {
            view.layer.add(.blinkAnimation(), forKey: Constants.BlinkableAnimation.animation)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        addShadow()
    }

    private func addShadow() {
        let shadow = UIConst.recommendationItemCellShadow
        self.layer.applySketchShadow(sketchShadow: shadow)
    }

    private func setupView() {
        contentView.layer.cornerRadius = UIConst.cornerRadius
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true

        layer.masksToBounds = false
    }
}
