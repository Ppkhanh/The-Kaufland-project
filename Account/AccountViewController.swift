//
//  AccountViewController.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 22.03.21.
//

import Combine
import UIKit
import SwiftUI

class AccountViewController: UIViewController {
    private typealias UIConst = Constants.Account

    var viewModel: AccountViewModel?

    private var subscribers = Set<AnyCancellable>()

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.register(UserProfileCollectionViewCell.self)
            // register collectionViewCell for displaying streak and loyalty points inside the account tab
            collectionView.register(ProfileStreakLPCollectionViewCell.self, forCellWithReuseIdentifier: ProfileStreakLPCollectionViewCell.identifier)
            collectionView.register(AccountItemCollectionViewCell.self)
            collectionView.register(AccountVersionCollectionViewCell.self)
            collectionView.register(LogoutCollectionViewCell.self)
            collectionView.backgroundColor = KauflandColors.almostWhite
            collectionView.collectionViewLayout = generateLayout()

        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Strings.mpAccountTitle.localized

        bindViewModel()
    }
}

extension AccountViewController {
    private func generateLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let viewModel = self?.viewModel, let sectionType = viewModel.sectionType(sectionIndex) else { return nil }

            switch sectionType {
                // set layout for streakLP section
            case .streakLP:
                let numberOfItemsWithoutAccountItem = viewModel.numberOfItemsInSection(sectionIndex) - 1
                var items: [NSCollectionLayoutItem] = [.item(height: .absolute(UIConst.streakLPHeight))]
                for _ in 0...numberOfItemsWithoutAccountItem {
                    items.append(.item(height: .absolute(UIConst.streakLPHeight)))
                }
                let groupHeight = UIConst.streakLPHeight + CGFloat(numberOfItemsWithoutAccountItem) * UIConst.streakLPHeight
                return NSCollectionLayoutSection.section(
                    groupSize: (width: .fractionalWidth(1.0),
                                height: .absolute(groupHeight)),
                    items: items)
            case .user:
                let numberOfItemsWithoutAccountItem = viewModel.numberOfItemsInSection(sectionIndex) - 1
                var items: [NSCollectionLayoutItem] = [.item(height: .absolute(UIConst.profileItemHeight))]
                for _ in 0...numberOfItemsWithoutAccountItem {
                    items.append(.item(height: .absolute(UIConst.itemHeight)))
                }
                let groupHeight = UIConst.profileItemHeight + CGFloat(numberOfItemsWithoutAccountItem) * UIConst.itemHeight
                return NSCollectionLayoutSection.section(
                    groupSize: (width: .fractionalWidth(1.0),
                                height: .absolute(groupHeight)),
                    items: items)
            case .info:
                let numberOfItems = viewModel.numberOfItemsInSection(sectionIndex)
                let groupHeight = CGFloat(numberOfItems) * UIConst.itemHeight
                return NSCollectionLayoutSection.section(
                    groupSize: (width: .fractionalWidth(1.0),
                                height: .absolute(groupHeight)),
                    items: [.item(height: .absolute( UIConst.itemHeight))])
            case .logout:
                let numberOfItems = viewModel.numberOfItemsInSection(sectionIndex)
                let groupHeight = CGFloat(numberOfItems) * UIConst.logoutItemHeight
                return NSCollectionLayoutSection.section(
                    groupSize: (width: .fractionalWidth(1.0),
                                height: .absolute(groupHeight)),
                    items: [.item(height: .absolute(UIConst.logoutItemHeight))])
            }
        }
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
//
extension AccountViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection(section) ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel,
              let sectionType = viewModel.sectionType(indexPath.section),
              let itemType = viewModel.itemType(indexPath) else { return UICollectionViewCell() }

        switch (sectionType, itemType) {
            // display SwiftUI view inside the collection view through UIHostingConfiguration
        case(.streakLP, .swiftUIView):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileStreakLPCollectionViewCell.identifier, for: indexPath)
            cell.contentConfiguration = UIHostingConfiguration {
                ProfileStreakLPView()
            }
            cell.backgroundColor = .white
            return cell
        case (.user, .profile):
            let cell = collectionView.dequeueReusableCell(UserProfileCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.profileViewModel
            return cell
        case (.logout, .logout):
            let cell = collectionView.dequeueReusableCell(LogoutCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.logoutViewModel
            return cell
        case (.info, .version):
            let cell = collectionView.dequeueReusableCell(AccountVersionCollectionViewCell.self, for: indexPath)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(AccountItemCollectionViewCell.self, for: indexPath)
            cell.viewModel = viewModel.itemViewModel(itemType)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel,
              let sectionType = viewModel.sectionType(indexPath.section),
              let itemType = viewModel.itemType(indexPath) else { return }

        switch (sectionType, itemType) {
        case (.logout, .logout):
            viewModel.logout()
        case (.user, _):
            _ = viewModel.itemViewModel(itemType)
          //  viewModel.login()
        default:
            print("Not needed any action.")
        }
    }
}

// MARK: View Model binding
extension AccountViewController {
    private func bindViewModel() {

        viewModel?.$isUserLoggedInToBFF
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.viewModel?.generateSections()
                self?.collectionView.reloadData()
            }).store(in: &subscribers)
    }
}



