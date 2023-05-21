//
//  UserProfileViewModel.swift
//  KCommonUIKit-iOS
//
//  Created by Zuhaib Rasheed on 31.08.21.
//  Copyright © 2021 Markus Troßbach. All rights reserved.
//

import Foundation
import Combine
import UIKit

public class UserProfileViewModel {
    var givenName: String?
    var familyName: String?
    var isUserLoggedIn: Bool = false

    public init(givenName: String? = nil, familyName: String? = nil, isUserLoggedIn: Bool = false) {
        self.givenName = givenName
        self.familyName = familyName
        self.isUserLoggedIn = isUserLoggedIn
    }

    var hideNameView: Bool {
        !isUserLoggedIn
    }

    var nameInitials: String? {
        guard isUserLoggedIn,
              let givenNameFirstCharacter =  givenName?.first,
              let familyNameFirstCharacter = familyName?.first else {
            return nil
        }

        return "\(givenNameFirstCharacter)\(familyNameFirstCharacter)"
    }

    var title: String {
        guard let givenName = givenName,
              let familyName = familyName else {
            return "Register or Sign in"
        }

        return "\(givenName) \(familyName)"
    }

    var titleColor: UIColor {
        isUserLoggedIn ? KauflandColors.secondary900 : KauflandColors.red
    }

    var subtitle: String {
        isUserLoggedIn ? "View and update your profile" : "Register or Sign in"
    }
}
