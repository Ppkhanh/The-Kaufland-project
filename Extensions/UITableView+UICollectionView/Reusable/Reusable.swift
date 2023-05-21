//
//  Reusable.swift
//  KCommonUIKit
//
//  Created by Markus Troßbach on 30.06.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation
import UIKit

public protocol Reusable {
    static var reuseIdentifier: String { get }
    static func nib() -> UINib?
    static func view() -> UIView?
}

public extension Reusable {

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static func nib() -> UINib? {
        return nil
    }

    static func view() -> UIView? {
        return nil
    }

}
