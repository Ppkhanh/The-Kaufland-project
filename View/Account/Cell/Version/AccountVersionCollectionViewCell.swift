//
//  AccountVersionCollectionViewCell.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 02.06.21.
//
import UIKit

class AccountVersionCollectionViewCell: UICollectionViewCell, Reusable {

    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = Constants.AccountVersion.titleFont
            titleLabel.textColor = UIColor.gray
            titleLabel.text = "3.18"
            backgroundColor = UIColor.white
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
}
