//
//  CategoriesSliderCollectionViewCell.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 07.07.22.
//

import Combine
import UIKit

class CategoriesSliderCollectionViewCell: UICollectionViewCell, Reusable {
    typealias UIConst = Constants.CategoriesSliderView

    @IBOutlet private weak var headerLabel: UILabel! {
        didSet {
            headerLabel.font = UIFont.boldKauflandFont(ofSize: 18)
            headerLabel.textColor = KauflandColors.secondary900
        }
    }

    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.backgroundColor = KauflandColors.white
            collectionView.register(CategoriesSliderItemCollectionViewCell.self)
        }
    }

    var offset = CGPoint.zero
    var trackedIndexes = [Int]()
    private var subscribers = Set<AnyCancellable>()

    var didSelectCategory: ((String) -> Void)?
    var viewModel: CategoriesSliderCollectionViewModel? {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            headerLabel.text = viewModel?.title
            bindViewModel()
        }
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
}

// MARK: UICollectionViewDelegate, UICollectionViewDataSource
extension CategoriesSliderCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel?.numberOfSections ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CategoriesSliderItemCollectionViewCell.self, for: indexPath)
        cell.viewModel = viewModel?.viewModelCategorySlider(for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIConst.itemWidth, height: UIConst.itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIConst.sectionInsets
    }
}

// MARK: View model binding
extension CategoriesSliderCollectionViewCell {
    private func bindViewModel() {
        viewModel?.$categorySlider
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.collectionView.reloadData()
                self.collectionView.contentOffset = self.offset
            }).store(in: &subscribers)
    }
}
