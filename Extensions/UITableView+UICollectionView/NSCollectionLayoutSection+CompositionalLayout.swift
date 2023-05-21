//
//  NSCollectionLayoutSection+CompositionalLayout.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 06.10.21.
//

import UIKit

// MARK: - CollectionViewLayoutSection
extension NSCollectionLayoutSection {
    // It could be helpful when we have more than one section with different configurations
    static func section(groupSize: (width: NSCollectionLayoutDimension, height: NSCollectionLayoutDimension),
                        items: [NSCollectionLayoutItem],
                        headerHeight: NSCollectionLayoutDimension? = nil,
                        footerHeight: NSCollectionLayoutDimension? = nil,
                        isverticalGroup: Bool = true,
                        spacing: (groupSpacing: CGFloat, interItemSpacing: NSCollectionLayoutSpacing)? = nil,
                        edgeInset: NSDirectionalEdgeInsets = .zero) -> NSCollectionLayoutSection {
        let groupSize = NSCollectionLayoutSize(widthDimension: groupSize.width, heightDimension: groupSize.height)
        var group: NSCollectionLayoutGroup
        if isverticalGroup {
           group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: items)
        } else {
            group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: items)
        }
        group.interItemSpacing = spacing?.interItemSpacing
        let sectionLayout = NSCollectionLayoutSection(group: group)
        if edgeInset != .zero {
            sectionLayout.contentInsets = edgeInset
        }
        var supplemetaryView: [NSCollectionLayoutBoundarySupplementaryItem] = []
        if let headerHeight = headerHeight {
            supplemetaryView.append(supplementaryView(height: headerHeight, type: UICollectionView.elementKindSectionHeader))
        }
        if let footerHeight = footerHeight {
            supplemetaryView.append(supplementaryView(height: footerHeight, type: UICollectionView.elementKindSectionFooter))
        }

        sectionLayout.boundarySupplementaryItems = supplemetaryView
        sectionLayout.interGroupSpacing = spacing?.groupSpacing ?? 0
        return sectionLayout
    }

    // SupplementartView for Header/ Footer
    static func supplementaryView(height: NSCollectionLayoutDimension,
                                  width: NSCollectionLayoutDimension = .fractionalWidth(1),
                                  type: String) -> NSCollectionLayoutBoundarySupplementaryItem {
        let alignment = (type == UICollectionView.elementKindSectionFooter) ? NSRectAlignment.bottom : NSRectAlignment.top
        let supplementItemSize = NSCollectionLayoutSize(widthDimension: width, heightDimension: height)
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementItemSize, elementKind: type, alignment: alignment)
    }
}
