//
//  AccountItemViewModel.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 01.06.21.
//

import Foundation
import UIKit

struct AccountItemViewModel {
    let title: String
    let imageName: String?
    var backgroundColor: UIColor = KauflandColors.white
    var isSeparatorViewHidden: Bool = false
    var isSeparatorViewBottomHidden: Bool = true
}
