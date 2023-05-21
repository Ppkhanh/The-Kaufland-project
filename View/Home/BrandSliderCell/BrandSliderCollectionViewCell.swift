//
//  BrandSliderCollectionViewCell.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 12.09.22.
//

import Combine
import Foundation
import UIKit

class BrandSliderCollectionViewCell: UICollectionViewCell, Reusable {
    typealias UIConst = Constants.BrandSliderView

    @IBOutlet private weak var headerLabel: UILabel! {
        didSet {
            headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
            headerLabel.textColor = UIColor.darkGray
        }
    }

    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.register(BrandSliderItemCollectionViewCell.self)
        }
    }

    var offset = CGPoint.zero

    private var subscribers = Set<AnyCancellable>()

    var viewModel: BrandSliderCollectionViewModel? {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            headerLabel.text = viewModel?.title
            generateLayout()
            bindViewModel()
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension BrandSliderCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(BrandSliderItemCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel?.viewModelBrandSlider(for: indexPath)

        return cell
    }

}

// MARK: Generate layout
extension BrandSliderCollectionViewCell {
    private func generateLayout() {
        let sectionProvider = { (_: Int, _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let horizontalGroupItems = self.viewModel?.horizontalGroupItems ?? 0
            let horizontalGroupTopItems = horizontalGroupItems / 2 == 0 ? horizontalGroupItems / 2 : (horizontalGroupItems / 2) + 1
            var items = [NSCollectionLayoutItem]()

            let brandSliderTopHorizontalGroup = self.horiontalBrandSliderCategoriesGroup(numberOfitems: horizontalGroupTopItems)
            items.append(brandSliderTopHorizontalGroup)

            let brandSliderBottomHorizontalGroup = self.horiontalBrandSliderCategoriesGroup(numberOfitems: horizontalGroupItems / 2)
            items.append(brandSliderBottomHorizontalGroup)

            let brandSliderGridGroup = NSCollectionLayoutGroup.vertical(layoutSize: self.groupSize,
                                                                         subitems: items)
            brandSliderGridGroup.interItemSpacing = .fixed(16)

            let section = NSCollectionLayoutSection(group: brandSliderGridGroup)
            section.contentInsets = UIConst.sectionInsets
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal

        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider,
                                                                                  configuration: config)
    }

    var groupSize: NSCollectionLayoutSize {
        NSCollectionLayoutSize(widthDimension: .estimated(collectionView.frame.width),
                               heightDimension: .estimated(UIConst.itemHeight))
    }

    ///  Brand slider grid will have two horizontal groups if items are more than 3.
    ///  It will provide horizontal group with given number of items.
    /// - Parameter numberOfitems: Number of items in horiontal group
    /// - Returns: Collection layout group
    func horiontalBrandSliderCategoriesGroup(numberOfitems: Int) -> NSCollectionLayoutGroup {
        let item = NSCollectionLayoutItem.item(height: .absolute(UIConst.itemHeight),
                                               width: .absolute(UIConst.itemWidth))

        let setMinNumberItems = numberOfitems == 0 ? 1 : numberOfitems
        var items = [NSCollectionLayoutItem]()
        for _ in 0..<setMinNumberItems {
            items.append(item)
        }

        let brandSliderHorizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                             subitems: items)
        brandSliderHorizontalGroup.interItemSpacing = .fixed(16)
        return brandSliderHorizontalGroup
    }
}

// MARK: View model binding
extension BrandSliderCollectionViewCell {
    private func bindViewModel() {
        viewModel?.$brandSlider
            .filter { $0?.brands.isEmpty == false }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }

                self.generateLayout()
                self.collectionView.reloadData()
                self.collectionView.contentOffset = self.offset
            }).store(in: &subscribers)
    }
}
