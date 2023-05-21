//
//  RecommenderEnergyBadgesView.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 18.10.21.
//

import UIKit

class RecommenderEnergyBadgesView: NibLoadingView {

    private typealias UIConst = Constants.RecommendationEnergyBadges
    var isVertical: Bool?

    var viewModel: PIEnergyBadgesViewModel? {
        didSet {
            guard viewModel != nil else { return }

            collectionView?.collectionViewLayout.invalidateLayout()
            collectionView?.reloadData()
        }
    }

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(PIEnergyBadgesCollectionViewCell.self)
            generateLayout()
        }
    }

    override var bundle: Bundle {
        return Bundle.main
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
 extension RecommenderEnergyBadgesView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(PIEnergyBadgesCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel?.cellViewModelAtIndexPath(indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
}

// MARK: UICollectionViewCompositionalLayout
private extension RecommenderEnergyBadgesView {
    private func generateLayout() {
        collectionView.semanticContentAttribute = .forceRightToLeft
        collectionView.generateSingleSectionLayout(itemSize: (.estimated(UIConst.itemWidth), .absolute(UIConst.itemHeight)),
                                                   spacing: (groupSpacing: UIConst.interItemSpacing,
                                                             interItemSpacing: .fixed(0)),
                                                   isverticalGroup: true)
    }
}
