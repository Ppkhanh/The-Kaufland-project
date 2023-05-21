//
//  UICollectionView+Reusable.swift
//  KCommonUIKit
//
//  Created by Markus Troßbach on 30.06.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import UIKit

public extension UICollectionView {

    func register<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib() {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }

    func register<T: UICollectionReusableView>(_: T.Type, forSupplementaryViewOfKind kind: String) where T: Reusable {
        if let nib = T.nib() {
            self.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(T.reuseIdentifier) is not a \(String(describing: T.self))")
        }
        return cell
    }

    func dequeueReusableCell<T: UICollectionViewCell & Reusable & Accessible>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(T.reuseIdentifier) is not a \(String(describing: T.self))")
        }
        cell.setAccessibilityIdentifiers(path: indexPath.pathDescription)
        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(_: T.Type, ofKind kind: String, for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(T.reuseIdentifier) is not a \(String(describing: T.self))")
        }
        return cell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView & Reusable & Accessible>(_: T.Type, ofKind kind: String, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(T.reuseIdentifier) is not a \(String(describing: T.self))")
        }
        cell.setAccessibilityIdentifiers(path: indexPath.pathDescription)
        return cell
    }

    /// Scrolls to the top of the table view.
    func scrollToTop() {
        guard visibleCells.count > 0 else { return }
        let lastIndexPath = IndexPath(row: 0, section: 0)
        scrollToItem(at: lastIndexPath, at: .top, animated: true)
    }
}
