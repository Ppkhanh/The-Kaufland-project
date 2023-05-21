//
//  RecoContainerSkeletonCell.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 10.12.21.
//

import UIKit

class RecoContainerSkeletonCell: UICollectionViewCell, Reusable {
    typealias UIConst = Constants.PDP

    @IBOutlet private var containerView: UIView!
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(RecoSkeletonCell.self)
            collectionView.collectionViewLayout = createLayout()
        }
    }

    func addBlinkAnimation() {
        for view in containerView.subviews where view.layer.animation(forKey: Constants.BlinkableAnimation.animation) == nil {
            view.layer.add(.blinkAnimation(), forKey: Constants.BlinkableAnimation.animation)
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
}

extension RecoContainerSkeletonCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        UIConst.numberOfRecoItemSkeletonCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(RecoSkeletonCell.self, for: indexPath)
        return cell
    }
}

// MARK: Layout
extension RecoContainerSkeletonCell {
    // MARK: Compositional Layout
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (_: Int,
                                 _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem.item(height: .fractionalHeight(1),
                                                   width: .fractionalWidth(1))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIConst.recommendationGroupFractionalWidth),
                                                   heightDimension: .absolute(310))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = UIConst.recommendationContainerInterGroupSpacing
            section.contentInsets = UIConst.recommendationContainerCellInsets
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = UIConst.recommendationContainerInterSectionSpacing
        config.scrollDirection = .horizontal

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider,
                                                         configuration: config)
        return layout
    }
}
