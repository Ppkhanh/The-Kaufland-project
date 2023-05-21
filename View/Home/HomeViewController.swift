//
//  HomeViewController.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 24.03.2022
//

import Combine
import UIKit
import SwiftUI

class HomeViewController: UIViewController, UIScrollViewDelegate {
    private typealias UIConst = Constants.HomeRecommender

    private var subscribers = Set<AnyCancellable>()
    private var accountViewController: AccountViewController?
    private var cancellable: AnyCancellable?
    
    private let lpButtonView = LPButtonView()

    var viewModel: HomeViewModel? {
        didSet {
            bindViewModel()
        }
    }
    private var previousScrollOffset = CGPoint.zero
    private let minTopConstraint: CGFloat = -78


    @IBOutlet private weak var headerView: UIView!
    @IBOutlet private weak var headerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet private weak var logoImageView: UIImageView! {
        didSet {
            setupLogoImageView()
        }
    }
    
    // UIHostingController to display SwiftUI view inside UIKit
    @IBSegueAction func toLPButtonView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: lpButtonView)
    }
    
    // UIHostingController to display SwiftUI view inside UIKit
    @IBSegueAction func toStreakButtonView(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: StreakButtonView())
    }
    
    
    @IBOutlet private weak var searchBarButton: KButton! {
        didSet {
            setupSearchBar()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            // register gameArea-button collectionViewCell
            collectionView.register(GameAreaButtonCollectionViewCell.self, forCellWithReuseIdentifier: GameAreaButtonCollectionViewCell.identifier)
            collectionView.register(RecommendationContainerCell.self)
            collectionView.register(RecoContainerSkeletonCell.self)
            collectionView.register(CategoriesSliderCollectionViewCell.self)
            collectionView.register(PromoSliderCollectionViewCell.self)
            collectionView.register(BrandSliderCollectionViewCell.self)
            collectionView.collectionViewLayout = generateLayout()
        }
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        //viewModel?.resetAndFetchNewData()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // navigationController?.isNavigationBarHidden = true - brings side effects at swipe back (navigationbar gets fully transparent).
        // https://stackoverflow.com/questions/47470145/difference-between-navigationbar-ishidden-and-setnavigationbarhidden for more info.
        navigationController?.setNavigationBarHidden(true, animated: true)
        lpButtonView.updateLP = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        lpButtonView.updateLP = true

    }

    // MARK: - Setup

    // MARK: SearchBar
    private func setupSearchBar() {
        let searchImage =  UIImage(named: "explore", in: Bundle.main, compatibleWith: nil)
        searchBarButton.setImage(searchImage,
                                 for: .normal)
        searchBarButton.style(as: .secondary(state: .normal, hasShadow: true), font: UIFont.systemFont(ofSize: 16))
        searchBarButton.layer.cornerRadius = 6
        searchBarButton.imageEdgeInsets = UIEdgeInsets.zero
        searchBarButton.layer.borderColor = KauflandColors.lightGray.cgColor
        searchBarButton.setTitle(Strings.mpHomeSearch.localized, for: .normal)
        searchBarButton.setTitleColor(KauflandColors.secondary700, for: .normal)
    }

    // MARK: LogoImage
    private func setupLogoImageView() {
        logoImageView.image = UIImage(named: "kaufland_logo_noText")
        logoImageView.contentMode = .scaleAspectFill
    }

    // MARK: - Actions

    @IBAction private func backButtonDidTapped() {
        guard let tabBarVC = tabBarController as? MainTabBarViewController,
              let navigationController = tabBarVC.navigationController else { return }
        navigationController.popViewController(animated: true)
    }

}

// MARK: - CollectionView Datasource & Delegate

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection(section: section) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = viewModel?.sections.safeRef(indexPath.section)

        // MARK: Skeleton Cells
        guard viewModel?.showSkeleton.value == false else {
            let cell = collectionView.dequeueReusableCell(RecoContainerSkeletonCell.self, for: indexPath)
            cell.addBlinkAnimation()
            return cell
        }

        switch section?.sectionType {
            
        case .promoSlider:
            let cell = collectionView.dequeueReusableCell(PromoSliderCollectionViewCell.self, for: indexPath)
            cell.currentPage = 0
            cell.viewModel = viewModel?.promoSliderViewModel
            return cell
            // display SwiftUI view for GameArea-button through UIHostingConfiguration
        case .gameArea:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameAreaButtonCollectionViewCell.identifier, for: indexPath)
            cell.contentConfiguration = UIHostingConfiguration {
                GameAreaButtonView().padding(.vertical, 10)
            }
            return cell
        case .brandSlider:
            let cell = collectionView.dequeueReusableCell(BrandSliderCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel?.brandSliderViewModel
            return cell
        case .categoriesSlider:
            let cell = collectionView.dequeueReusableCell(CategoriesSliderCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel?.categoriesSliderViewModel
            return cell
        default:
            // Cell for recommender
            let cell = collectionView.dequeueReusableCell(RecommendationContainerCell.self, for: indexPath)
            cell.viewModel = viewModel?.recommendationViewModel(indexPath)
            cell.offset = .zero
            return cell
        }
    }

    // MARK: Collapsible Header

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let delta = collectionView.contentOffset.y - previousScrollOffset.y

        let canScrollUp: Bool = delta < 0 && headerViewTopConstraint.constant < 0 && scrollView.contentOffset.y < 0
        let canScrollDown: Bool = delta >= 0 && headerViewTopConstraint.constant > minTopConstraint  && collectionView.contentOffset.y > 0

        if canScrollUp || canScrollDown {
            headerViewTopConstraint.constant -= delta
            validateTopConstraint()
            collectionView.contentOffset.y -= delta
        }
        previousScrollOffset.y = collectionView.contentOffset.y
    }

    private func validateTopConstraint() {
        headerView.isHidden = headerViewTopConstraint.constant < UIConst.offsetToHideHeader
        headerViewTopConstraint.constant = headerViewTopConstraint.constant < minTopConstraint ? minTopConstraint : headerViewTopConstraint.constant
        headerViewTopConstraint.constant = headerViewTopConstraint.constant > 0 ? 0 : headerViewTopConstraint.constant
    }
}

// MARK: - Actions

extension HomeViewController {
    // MARK: Clear

    private func showClearAlert() {
        let title = Strings.mpClearAllAlertTitle.localized
        let message = Strings.mpClearAllAlertMessage.localized
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: Strings.mpClearAllAlertCancelButtonTitle.localized,
                                         style: .cancel)
        let clearAction = UIAlertAction(title: Strings.mpClearAllAlertClearAllButtonTitle.localized,
                                        style: .default) { [weak self] _ in
            LastSeenRecoHandler.shared.removeAllEntries()

            self?.viewModel?.removeRecommendationsWith(.lastSeen)
            self?.collectionView.collectionViewLayout.invalidateLayout()
            self?.collectionView.reloadData()
        }
        alert.addAction(cancelAction)
        alert.addAction(clearAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

extension HomeViewController {
    private func bindViewModel() {

        viewModel?.updateContents
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.collectionView.reloadData()
            })

        viewModel?.showSkeleton
            .sink(receiveValue: { [weak self] needtoShowSkeleton in
                guard needtoShowSkeleton ?? false else { return }

                self?.collectionView.collectionViewLayout.invalidateLayout()
                self?.collectionView.reloadData()
            })
    }
}

// MARK: - CompositionLayout

extension HomeViewController {
    private func generateLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int, _) -> NSCollectionLayoutSection? in
            let sectionType = self?.viewModel?.sections.safeRef(sectionIndex)?.sectionType

            let sectionInsets = sectionType == .recommender ? UIConst.sectionInsets : nil

            var height = 0.0
            switch sectionType {
                // set height for game Area button
            case .gameArea:
                height = UIConst.gameAreaHeight
            case .categoriesSlider:
                height = UIConst.categorySliderHeight
            case .promoSlider:
                height = UIConst.promoSliderHeight
            case .brandSlider:
                height = UIConst.brandSliderHeight
            default:
                height = UIConst.recommendationContainerHeight
            }

            return NSCollectionLayoutSection.section(groupSize: (width: .fractionalWidth(1),
                                                                 height: .estimated(height)),
                                                     items: [.item(height: .estimated(height),
                                                                   width: .fractionalWidth(1))],
                                                     edgeInset: sectionInsets ?? .zero)
        }
    }
}
