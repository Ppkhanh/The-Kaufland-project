//
//  LogoutCollectionViewCell.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 31.08.21.
//
import UIKit

class LogoutCollectionViewCell: UICollectionViewCell, Reusable {
    @IBOutlet private weak var logoutView: LogoutView!

    var viewModel: LogoutViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            logoutView.viewModel = viewModel
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
}
