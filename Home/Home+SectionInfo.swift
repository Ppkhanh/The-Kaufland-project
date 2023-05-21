//
//  HomeRecoViewModel+SectionInfo.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 08.04.22.
//

import Foundation

// MARK: - Section
struct HomeSection {
    let sectionType: HomeSectionType
    var items: [HomeSectionItem]
}

// MARK: SectionType
enum HomeSectionType: Equatable {
    case recommender
    case lastSeenRecommender
    case categoriesSlider
    case promoSlider
    case bestSellersRecommender
    case brandSlider
    case gameArea // gameAreaButton
}

// MARK: - SectionItem
struct HomeSectionItem {
    let itemType: HomeSectionItemType
    let data: Any?
}

// MARK: SectionItemType
enum HomeSectionItemType: String {
    case footer
    case recommender
    case categoriesSlider
    case promoSlider
    case brandSlider
    case gameAreaItem //gameAreaButton
}

struct RecommendationsData {
    var type: RecommendationType?
    var title: String?
    var recoItems: [Recommendation]?
    var productId: String?
}
