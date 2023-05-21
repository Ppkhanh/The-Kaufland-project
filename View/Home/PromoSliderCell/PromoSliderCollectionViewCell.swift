//
//  PromoSliderCollectionViewCell.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 16.08.22.
//

import Combine
import Nuke
import NukeWebPPlugin
import UIKit

class PromoSliderCollectionViewCell: UICollectionViewCell, Reusable {
    typealias UIConst = Constants.PromoSliderView

    private var subscribers = Set<AnyCancellable>()

    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = KauflandColors.white
            collectionView.register(PromoSliderItemCollectionViewCell.self)
        }
    }

    var currentPage = 0
    var offset = CGPoint.zero

    var didSelectPromoSlider: ((String) -> Void)?

    var viewModel: PromoSliderCollectionViewModel? {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            bindViewModel()
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension PromoSliderCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel?.numberOfSections ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PromoSliderItemCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel?.viewModelPromoSlider(for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let index = collectionView.indexPathsForVisibleItems.first else { return }
        pageControl.currentPage = index.row
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
}

// MARK: View model binding
extension PromoSliderCollectionViewCell {
    private func bindViewModel() {
        viewModel?.$promoSlider
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }

                self.pageControl.numberOfPages = self.viewModel?.numberOfPages ?? 0
                self.collectionView.reloadData()
                self.pageControl.currentPage = self.currentPage
                self.collectionView.contentOffset = self.offset
            }).store(in: &subscribers)
    }
}
