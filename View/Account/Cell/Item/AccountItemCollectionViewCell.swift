//
//  AccountItemCollectionViewCell.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 01.06.21.
//
import UIKit

class AccountItemCollectionViewCell: UICollectionViewCell, Reusable {
    private typealias UIConst = Constants.AccountItem

    @IBOutlet private weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = KauflandColors.secondary400
        }
    }

    @IBOutlet private weak var separatorViewBottom: UIView! {
        didSet {
            separatorViewBottom.backgroundColor = KauflandColors.secondary400
        }
    }

    @IBOutlet private weak var decorationImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = UIConst.titleFont
            titleLabel.textColor = KauflandColors.secondary900
        }
    }

    var viewModel: AccountItemViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            tintColor = KauflandColors.secondary700
            backgroundColor = viewModel.backgroundColor
            separatorView.isHidden = viewModel.isSeparatorViewHidden
            separatorViewBottom.isHidden = viewModel.isSeparatorViewBottomHidden

            titleLabel.text = viewModel.title

            if let imageName = viewModel.imageName {
                decorationImageView.isHidden = false
                decorationImageView.image = UIImage(named: imageName, in: Bundle.main, with: nil)
            } else {
                decorationImageView.isHidden = true
            }
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
}
