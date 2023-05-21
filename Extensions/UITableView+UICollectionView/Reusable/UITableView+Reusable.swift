//
//  UITableView+Reusable.swift
//  KCommonUIKit
//
//  Created by Markus Troßbach on 30.06.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import UIKit

public extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib() {
            register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(T.reuseIdentifier) is not a \(String(describing: T.self))")
        }
        return cell
    }

    func dequeueReusableCell<T: UITableViewCell & Reusable & Accessible>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("\(T.reuseIdentifier) is not a \(String(describing: T.self))")
        }
        cell.setAccessibilityIdentifiers(path: indexPath.pathDescription)
        return cell
    }

    func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) where T: Reusable {
        if let nib = T.nib() {
            register(nib, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        } else {
            register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
        }
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) -> T where T: Reusable {
        guard let cell = dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("\(T.reuseIdentifier) is not a \(String(describing: T.self))")
        }
        return cell
    }

    /// Scrolls to the bottom of the table view.
    func scrollToBottom() {
        /// Get the `IndexPath` for the last element in the last section.
        let lastSection = max(numberOfSections - 1, 0)
        let lastRow = max(numberOfRows(inSection: lastSection) - 1, 0)
        let lastIndexPath = IndexPath(row: lastRow, section: lastSection)

        scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }

    /// Scrolls to the top of the table view.
    func scrollToTop() {
        guard visibleCells.count > 0 else { return }
        let lastIndexPath = IndexPath(row: 0, section: 0)
        scrollToRow(at: lastIndexPath, at: .top, animated: true)
    }
}
