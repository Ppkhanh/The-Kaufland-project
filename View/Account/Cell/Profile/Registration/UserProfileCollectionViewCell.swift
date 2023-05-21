//
//  UserProfileCollectionViewCell.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 31.08.21.
//
import UIKit

class UserProfileCollectionViewCell: UICollectionViewCell, Reusable {
    @IBOutlet private weak var userProfileView: UserProfileView!

    var viewModel: UserProfileViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            userProfileView.viewModel = viewModel
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
}
