//
//  RecommendationViewModel.swift
//  KMarketPlaceKit
//
//  Created by Marcus Hopp on 04.11.21.
//

import Combine
import CoreGraphics

class RecommendationContainerViewModel {
    typealias UIConst = Constants.RecommenderContainer

    @Published private(set) var updateContents: Bool?
    private var subscribers = Set<AnyCancellable>()
    private(set) var showSkeleton: Bool = false

    let type: RecommendationType
    let productId: String?
    var groupHeight: CGFloat?
    private var title: String?
    private var recoService: RecoServiceProtocol

    private (set) var recommendationItems: [Recommendation]?

    init(title: String? = nil,
         productId: String? = nil,
         recommenders: [Recommendation]? = nil,
         type: RecommendationType,
         recoService: RecoServiceProtocol = RecoService()) {
        self.title = title
        self.productId = productId
        self.type = type
        self.recoService = recoService

        recommendationItems = recommenders
        showSkeleton = recommendationItems == nil

        if recommendationItems == nil {
            fetchRecommendations(type)
        } else if let recommenders = recommenders {
            groupHeight = RecoHelper.recommendationContainerHeight(recommenders)
            updateContents = true
        }
    }

    var containerTitle: String {
        switch type {
        case .similar:
            return Strings.mpPdpRecoSimilar.localized
        case .sponsored:
            return Strings.mpPdpRecoMoreMatchingProducts.localized
        case .bestSeller:
            return title ?? ""
        case .lastSeen:
            return Strings.mpPdpRecoLastseen.localized
        case .personalized:
            return Strings.mpPdpRecoPersonalized.localized
        case .careco:
            return Strings.mpPdpRecoCareco.localized
        case .associate:
            return Strings.mpPdpRecoAssociate.localized
        }
    }

    var containerSubTitle: String {
        Strings.mpPdpRecoSponsored.localized
    }

    var containerSubTitleHidden: Bool {
        type != .sponsored
    }

    var itemHeight: CGFloat? {
        (groupHeight ?? UIConst.containerHeight) - UIConst.topMargin
    }

    var numberOfItems: Int {
        return showSkeleton ? 1 : recommendationItems?.count ?? 0
    }

    func recommendationItemFor(_ index: Int) -> Recommendation? {
        guard let item = recommendationItems?.safeRef(index) else { return nil }
        return item
    }

    func recommendationItemViewModelFor(_ index: Int) -> RecommendationItemViewModel? {
        guard let item = recommendationItems?.safeRef(index) else { return nil }
        return RecommendationItemViewModel(recommendation: item)
    }
}

extension RecommendationContainerViewModel {
    func fetchRecommendations(_ recoType: RecommendationType) {
        recoService.fetchRecommendations(recoType, productId: productId)
            .receive(on: DispatchQueue.main)
            .sink { resultCompletion in
                switch resultCompletion {
                case .failure, .finished: break
                }
            } receiveValue: { [weak self] recommenders in
                self?.showSkeleton = false
                self?.groupHeight = RecoHelper.recommendationContainerHeight(recommenders.items)
                self?.recommendationItems = recommenders.items
                self?.updateContents = true
            }.store(in: &self.subscribers)
    }
}
