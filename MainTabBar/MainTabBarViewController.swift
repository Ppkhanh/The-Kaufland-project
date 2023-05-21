//
//  MainTabBarViewController.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 24.02.21.
//
import UIKit

enum MarketPlaceTabs: Int, CaseIterable {
    case home = 0
    case account

    func controllerWithTabBarItem() -> UINavigationController {
        let controller: UIViewController
        switch self {
        case .home:
                controller = MarketPlaceRouter.instantiateHomeViewController()
        case .account:
            controller = MarketPlaceRouter.instantiateAccountViewController()
        }

        controller.tabBarItem = tabBarItem()
        return UINavigationController(rootViewController: controller)
    }

    private func image() -> UIImage? {
        switch self {
        case .home:
            return UIImage(named: "icHome")
        case .account:
            return UIImage(named: "icProfile")
        }
    }

    private func tabBarItem() -> UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: Strings.mpTabHome.localized, image: image(), tag: rawValue)
        case .account:
            return UITabBarItem(title: Strings.mpTabAccount.localized, image: image(), tag: rawValue)
        }
    }
}

public class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private typealias UIConst = Constants.TabBar

    // The following two values (proceedToPDP and productId are set when a UniversalLink is called)
    var productId: String?

    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true

        instantiateViewControllers()
        setupTabBarShadow()
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func instantiateViewControllers() {
        var viewControllers = [UIViewController]()
        for tab in MarketPlaceTabs.allCases {
            viewControllers.append(tab.controllerWithTabBarItem())
        }

        setViewControllers(viewControllers, animated: true)
    }

    private func setupTabBarShadow() {
        tabBar.layer.shadowOffset = .zero
        tabBar.layer.shadowRadius = UIConst.tabBarShadowRadius
        tabBar.layer.shadowColor = KauflandColors.secondary900.cgColor
        tabBar.layer.shadowOpacity = UIConst.tabBarShadowOpacity
    }
}

// MARK: - UINavigationControllerDelegate
extension MainTabBarViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
