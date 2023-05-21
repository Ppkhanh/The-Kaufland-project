//
//  HomeViewModel.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 07.12.21.
//

import Foundation
import Combine
import UIKit

class HomeViewModel {
    typealias UIConst = Constants.HomeRecommender

    // MARK: - Dependencies
    var brandService: BrandSliderServiceProtocol
    var recoService: RecoServiceProtocol
    var categoryService: CategorySliderServiceProtocol
    var promoSliderService: PromoSliderServiceProtocol
    var lastSeenRecoHandler: LastSeenRecoHandlerProtocol
    var recommendationHandler: CategoriesRecommendationsHandlerProtocol

    let updateContents = Observable<Bool?>(nil)
    let showSkeleton = Observable<Bool?>(nil)

    var subscribers = Set<AnyCancellable>()
    var sections = [HomeSection]()

    var recommendationsData = [RecommendationsData]()
    var bestSellersRecommendations = [BestSellerRecommendation]()

    init(recommenderService: RecoServiceProtocol,
         lastSeenHandler: LastSeenRecoHandlerProtocol,
         handler: CategoriesRecommendationsHandlerProtocol,
         categorySliderService: CategorySliderServiceProtocol,
         promoService: PromoSliderServiceProtocol,
         brandSliderService: BrandSliderServiceProtocol) {

        recoService = recommenderService
        recommendationHandler = handler
        lastSeenRecoHandler = lastSeenHandler
        categoryService = categorySliderService
        promoSliderService = promoService
        brandService = brandSliderService

        fetchData()
    }

    var isLastSeenRecoVisible: Bool {
        !LastSeenRecoHandler.shared.isLastSeenProductsEmpty && isAllCategoriesGroupsSelected && recoData(.lastSeen) != nil
    }

    var isAllCategoriesGroupsSelected: Bool {
        recommendationHandler.selectedCategoriesGroup == nil
    }

    func recoData(_ type: RecommendationType) -> RecommendationsData? {
        recommendationsData.first(where: { $0.type == type })
    }

    func sectionType(section: Int) -> HomeSectionType? {
        sections.safeRef(section)?.sectionType
    }

    func numberOfItemsInSection(section: Int) -> Int {
        sections.safeRef(section)?.items.count ?? 0
    }

    var numberOfSections: Int? {
        sections.count
    }

    private func itemDataForIndexPath(_ indexPath: IndexPath) -> Any? {
        guard let section = sections.safeRef(indexPath.section),
              let item = section.items.safeRef(indexPath.row) else {
                  return nil
              }
        return item.data
    }

    func resetAndFetchNewData() {
        // If user has selected any categories group then do not refresh and fetch data
        guard isAllCategoriesGroupsSelected else { return }

        showSkeleton.value = true
        fetchData()
        recommendationsData.removeAll()
        bestSellersRecommendations.removeAll()
    }
}

// MARK: - View Models
extension HomeViewModel {
    // MARK: CategoriesSlider
    var categoriesSliderViewModel: CategoriesSliderCollectionViewModel? {
        return CategoriesSliderCollectionViewModel(service: categoryService, categorySliderDeals: true)
    }

    // MARK: PromoSlider
    var promoSliderViewModel: PromoSliderCollectionViewModel? {
        return PromoSliderCollectionViewModel(service: promoSliderService)
    }

    // MARK: BrandSlider
    var brandSliderViewModel: BrandSliderCollectionViewModel? {
        return BrandSliderCollectionViewModel(service: brandService)
    }

    // MARK: Reco
    func recommendationViewModel(_ indexPath: IndexPath) -> RecommendationContainerViewModel? {
        guard let recoData = itemDataForIndexPath(indexPath) as? RecommendationsData else {
            return nil
        }

        return RecommendationContainerViewModel(title: recoData.title,
                                                recommenders: recoData.recoItems,
                                                type: recoData.type ?? .lastSeen)
    }
}

extension HomeViewModel {
    func removeRecommendationsWith(_ type: RecommendationType) {
        LastSeenRecoHandler.shared.removeAllEntries()
        generateSections()
        updateContents.value = true
        showSkeleton.value = false
    }
}
