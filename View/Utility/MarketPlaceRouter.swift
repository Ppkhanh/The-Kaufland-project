//
//  MarketPlaceRouter.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 18.02.21.
//

import Foundation
import SwiftUI

enum StoryboardName: String {
    case home = "Home"
    case account = "Account"
    case mainTab = "MainTabBar"
}

class MarketPlaceRouter {
    static func instantiateHomeViewController() -> HomeViewController {
        guard let viewController = UIStoryboard(name: StoryboardName.home.rawValue, bundle: Bundle.main).instantiateViewController(identifier: "HomeViewController") as? HomeViewController else {
            fatalError("HomeViewController not found!")
        }

        viewController.viewModel = HomeViewModel(recommenderService: RecoService(),
                                                 lastSeenHandler: LastSeenRecoHandler(),
                                                 handler: CategoriesRecommendationsHandler.shared,
                                                 categorySliderService: CategorySliderService(),
                                                 promoService: PromoSliderService(),
                                                 brandSliderService: BrandSliderService())
        return viewController
    }

    static func instantiateAccountViewController() -> AccountViewController {
        guard let viewController = UIStoryboard(name: StoryboardName.account.rawValue, bundle: Bundle.main).instantiateViewController(identifier: "AccountViewController") as? AccountViewController else {
            fatalError("Account View Controller not found!")
        }

        viewController.viewModel = AccountViewModel(logoutViewModel: LogoutViewModel())
        return viewController
    }

    static func instantiateMainTabBarViewController(proceedToPDP: Bool = false,
                                                    productId: String? = nil) -> MainTabBarViewController {

        guard let viewController = UIStoryboard(name: StoryboardName.mainTab.rawValue, bundle: Bundle.main).instantiateViewController(withIdentifier: "MainTabBarViewController") as? MainTabBarViewController else {
            fatalError("Main Tab Bar View Controller not found!")
        }
        // Universal linking
        viewController.productId = productId
        return viewController
    }
   
}
