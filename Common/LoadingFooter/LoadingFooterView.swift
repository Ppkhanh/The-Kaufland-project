//
//  LoadingFooterView.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 21.07.21.
//

import Foundation
import Combine
import UIKit

class LoadingFooterView: UICollectionReusableView, Reusable {
    private typealias UIConst = Constants.LoadingFooterView

    @IBOutlet private weak var loadingView: UIView!

    @IBOutlet private weak var loadingLabel: UILabel! {
        didSet {
            loadingLabel.textColor = KauflandColors.secondary700
            loadingLabel.font = UIConst.messageLabelFont
        }
    }
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.color = KauflandColors.secondary700
        }
    }

    private var subscribers = Set<AnyCancellable>()

    var viewModel: LoadingFooterViewModel? {
        didSet {
            loadingLabel.text = viewModel?.message
            bindViewModel()
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
}

// MARK: BindViewModel
extension LoadingFooterView {
    private func bindViewModel() {
        viewModel?.$shouldShowLoadingView
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] showLoadingView in
                self?.loadingView.isHidden = !showLoadingView
            })
            .store(in: &subscribers)
    }
}
