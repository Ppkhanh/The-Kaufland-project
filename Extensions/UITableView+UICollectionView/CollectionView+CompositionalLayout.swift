//
//  CollectionView+CompositionalLayout.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 04.10.21.
//

import UIKit

// MARK: - CollectionView
extension UICollectionView {
    var indexPathsForFullyVisibleItems: [IndexPath] {
        return self.indexPathsForVisibleItems.filter { indexPath in
            guard let cell = cellForItem(at: indexPath), let superview = superview else { return false }

            let cellRect = convert(cell.frame, to: superview)
            return frame.contains(cellRect) }
    }

    // This method could be helpful when we have only one section
    // It could simply return the "UICollectionViewCompositionalLayout"
    func generateSingleSectionLayout(itemSize: (width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension),
                                     headerHeight: NSCollectionLayoutDimension? = nil,
                                     footerHeight: NSCollectionLayoutDimension? = nil,
                                     spacing: (groupSpacing: CGFloat, interItemSpacing: NSCollectionLayoutSpacing)? = nil,
                                     edgeInset: NSDirectionalEdgeInsets = .zero,
                                     isverticalGroup: Bool = true) {
        let item: NSCollectionLayoutItem = .item(height: itemSize.height, width: itemSize.width)
        let sectionLayout: NSCollectionLayoutSection = .section(groupSize: (width: .fractionalWidth(1),
                                                                            height: itemSize.height),
                                                                items: [item],
                                                                headerHeight: headerHeight,
                                                                footerHeight: footerHeight,
                                                                isverticalGroup: isverticalGroup,
                                                                spacing: spacing,
                                                                edgeInset: edgeInset)
        collectionViewLayout = UICollectionViewCompositionalLayout(section: sectionLayout)
    }
}

// MARK: - CollectionViewLayoutItem
extension NSCollectionLayoutItem {
    static func item(height: NSCollectionLayoutDimension, width: NSCollectionLayoutDimension = .fractionalWidth(1)) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        return NSCollectionLayoutItem(layoutSize: itemSize)
    }
}
