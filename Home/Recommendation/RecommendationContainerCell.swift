//
//  RecommendationContainerCell.swift
//  KMarketPlaceKit
//
//  Created by Marcus Hopp on 04.11.21.
//

import Combine
import UIKit

class RecommendationContainerCell: UICollectionViewCell, Reusable {
    typealias UIConst = Constants.PDP

    var offset = CGPoint.zero

    private var subscribers = Set<AnyCancellable>()

    @IBOutlet private weak var recommendationsSectionTitleLabel: UILabel! {
        didSet {
            recommendationsSectionTitleLabel.font = UIConst.recommendationContainerTitleFont
            recommendationsSectionTitleLabel.textColor = KauflandColors.secondary900
        }
    }

    @IBOutlet private weak var recommendationsSectionSubTitleLabel: UILabel! {
        didSet {
            recommendationsSectionSubTitleLabel.font = Fonts.kauflandFont12
            recommendationsSectionSubTitleLabel.textColor = KauflandColors.secondary700
        }
    }

    @IBOutlet var recommendationsCollectionView: UICollectionView! {
        didSet {
            recommendationsCollectionView.register(RecommendationItemCell.self)
            recommendationsCollectionView.register(RecoSkeletonCell.self)
            recommendationsCollectionView.delegate = self
            recommendationsCollectionView.dataSource = self
            recommendationsCollectionView.collectionViewLayout = createLayout()
        }
    }
    @IBOutlet private weak var clearAllButton: UIButton! {
        didSet {
            clearAllButton.setTitle(Strings.mpRecommendationClearAllButtonTitle.localized, for: .normal)
            clearAllButton.setTitleColor(KauflandColors.secondary700, for: .normal)
            clearAllButton.titleLabel?.font = UIConst.recommendationClearAllButtonTitleFont
            clearAllButton.contentHorizontalAlignment = .right
        }
    }

    var viewModel: RecommendationContainerViewModel? {
        didSet {
            bindViewModel()
            updateUI()
        }
    }

    private func bindViewModel() {
        subscribers.removeAll()

        viewModel?.$updateContents
            .filter { _ in self.viewModel?.recommendationItems?.count ?? 0 > 0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.recommendationsCollectionView.collectionViewLayout.invalidateLayout()
                self.recommendationsCollectionView.reloadData()
                self.recommendationsCollectionView.contentOffset = self.offset
            }).store(in: &subscribers)
    }

    private func updateUI() {
        recommendationsSectionTitleLabel.text = viewModel?.containerTitle
        recommendationsSectionSubTitleLabel.text = viewModel?.containerSubTitle
        recommendationsSectionSubTitleLabel.isHidden = viewModel?.containerSubTitleHidden ?? true

        guard let viewModel = viewModel else { return }
        contentView.backgroundColor = .white
        recommendationsCollectionView.backgroundColor = .white

        recommendationsCollectionView.reloadData()
        recommendationsCollectionView.contentOffset = self.offset

        clearAllButton.isHidden = viewModel.type != .lastSeen
    }

    static func nib() -> UINib? {
        return UINib(nibName: reuseIdentifier, bundle: Bundle.main)
    }
}

// MARK: - Collection View DataSource & Delegate
extension RecommendationContainerCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel, !viewModel.showSkeleton else {
            let cell = collectionView.dequeueReusableCell(RecoSkeletonCell.self, for: indexPath)
            cell.addBlinkAnimation()
            return cell
        }

        guard let recommendationItemViewModel = viewModel.recommendationItemViewModelFor(indexPath.item) else {
            return UICollectionViewCell()
        }

        let cell = collectionView.dequeueReusableCell(RecommendationItemCell.self, for: indexPath)
        cell.viewModel = recommendationItemViewModel
        return cell
    }
}



// MARK: Layout
extension RecommendationContainerCell {
    // MARK: Compositional Layout
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider = { (_: Int,
                                 _: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemHeight = self.viewModel?.itemHeight ??  UIConst.recommendationItemHeight
            let item = NSCollectionLayoutItem.item(height: .fractionalHeight(1),
                                                   width: .fractionalWidth(1))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(UIConst.recommendationGroupFractionalWidth),
                                                   heightDimension: .absolute(itemHeight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = UIConst.recommendationContainerInterGroupSpacing
            section.contentInsets = UIConst.recommendationContainerCellInsets
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = UIConst.recommendationContainerInterSectionSpacing
        config.scrollDirection = .horizontal

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider,
                                                         configuration: config)
        return layout
    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        super.layoutIfNeeded()
        self.layoutIfNeeded()

        let height = (viewModel?.groupHeight ?? UIConst.recommendationContainerHeight)
        return CGSize(width: targetSize.width, height: height)
    }
}
