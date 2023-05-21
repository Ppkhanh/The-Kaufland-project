//
//  Constants.swift
//  KMarketPlaceKit
//
//  Created by Bulgantamir Jugder on 26.02.21.
//

import Foundation
import CoreGraphics
import SwiftUI

// swiftlint:disable type_body_length
struct Constants {
    static let webpageUserAgent = "Mobile App - Marketplace"
    static let channel = "channel"
    static let onlineShop = "onlineshop"
    static let activityIndicatorTag = 420

    struct TabBar {
        static let tabBarBadgeCountLimit = 999
        static let tabBarBadgeFont: CGFloat = 10
        static let tabBarShadowRadius: CGFloat = 5
        static let tabBarShadowOpacity: Float = 0.25
    }
    
    struct LogoutView {
        static let logoutFont = UIFont.boldKauflandFont(ofSize: 16)
    }
    
    struct NameInCircleView {
        static let font = UIFont.systemFont(ofSize: 16, weight: .bold)
    }
    
    struct CustomerReviewDetail {
        static let createdDateFont = UIFont.kauflandFont(ofSize: 12)
        static let verificationFont = UIFont.kauflandFont(ofSize: 12)
        static let titleFont = UIFont.boldKauflandFont(ofSize: 14)
        static let specificationFont = UIFont.kauflandFont(ofSize: 12)
        static let descriptionFont = UIFont.kauflandFont(ofSize: 14)
        static let descriptionTextViewDTFont = UIFont.boldKauflandFont(ofSize: 14)
    }
    
    struct Rating {
        static let maxRatingCount: Int = 5
        static let ratingsFontSize: CGFloat = 12
    }

    struct LastSeenPersistence {
        static let defaultsKey = "last_seen"
    }

    struct CustomerHistoryHandler {
        static let defaultsKey = "customer_history"
    }

    struct LastOrdersHandler {
        static let defaultsKey = "closed_statuses"
    }

    struct LoadingFooterView {
        static let messageLabelFont = UIFont.mediumSystemFont(ofSize: 16)
    }

    struct Home {
        static let homeTopHeaderHeight: CGFloat = 78
        static let searchBarHeaderHeight: CGFloat = 46
        static let itemHeight: CGFloat = 1000
        static let contentInsets = NSDirectionalEdgeInsets(top: 14, leading: 0, bottom: 0, trailing: 0)
    }

    struct HomeRecommender {
        static let defaultsKey = "homeModal"

        static let brandSliderHeight: CGFloat = 211
        static let promoSliderHeight: CGFloat = 260
        static let categorySliderHeight: CGFloat = 192
        static let gameAreaHeight: CGFloat = 300 // height for game area button collectionViewCell
        static let recommendationContainerHeight: CGFloat = 350
        static let statusItemHeight: CGFloat = 140
        static let sectionInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        static let statusFooterHeight: CGFloat = 70
        static let statusGroupSpacing: CGFloat = 10
        static let triggerDismissYOffset: CGFloat = 50
        static let headerHeight: CGFloat = 25
        static let headerHeightWithTopMargins: CGFloat = 32
        static let defaultContentSize: CGFloat = 800
        static let bottomPadding: CGFloat = 200
        static let loadingFooterHeight: CGFloat = 50
        static let offsetToHideHeader: CGFloat = -70
        static let offsetToFetchNewBestSeller: Int = 2
    }

    struct Variants {
        static let itemHeight: CGFloat = 45
        static let itemWidth: CGFloat = 70
        static let groupHeight: CGFloat = 45
        static let headerHeight: CGFloat = 22
        static let interGroupSpacing: CGFloat = 10
        static let sectionInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 20, trailing: 16)
    }


    struct Variant {
        static let titleFont = UIFont.kauflandFont(ofSize: 16)
        static let cartTitleFont = UIFont.systemFont(ofSize: 12)
        static let selectedValueFont = UIFont.mediumKauflandFont(ofSize: 16)
        static let cartselectedValueFont = UIFont.semiboldSystemFont(ofSize: 12)
    }

    struct Offer {
        static let infoStringFont = UIFont.systemFont(ofSize: 14)
        static let infoStringFontBold = UIFont.semiboldSystemFont(ofSize: 14)
        static let conditionLabelFont = UIFont.mediumKauflandFont(ofSize: 14)
    }

    struct DescriptionCollectionViewCell {
        static let descriptionCellFont = UIFont.boldKauflandFont(ofSize: 18)
    }

    struct EnergyBadgeView {
        static let energyRangeFont = UIFont.boldKauflandFont(ofSize: 7)
        static let energyLevelFont = UIFont.boldKauflandFont(ofSize: 22)
    }

    struct PIEnergyBadgeView {
        static let energyLevelFont = UIFont.boldKauflandFont(ofSize: 16)
        static let energyRangeFont = UIFont.boldKauflandFont(ofSize: 6)
    }

    struct EnergyBadgeOldView {
        static let energyLevelFirstCharPosition = 1
        static let energyRangeFont = UIFont.kauflandFont(ofSize: 11)
        static let energyLevelPIFont = UIFont.boldKauflandFont(ofSize: 16)
        static let energyLevelFont = UIFont.boldKauflandFont(ofSize: 22)
        static let energyLevelAdditionFont = UIFont.boldKauflandFont(ofSize: 10)
    }

    struct DescriptionDetail {
        static let descriptionTextViewFont = UIFont.kauflandFont(ofSize: 14)
        static let descriptionTextViewDTFont = UIFont.boldKauflandFont(ofSize: 14)
        static let descriptionTextViewContentInset = UIEdgeInsets(top: 32,
                                                                  left: 16,
                                                                  bottom: 0,
                                                                  right: 16)
    }

    struct Account {
        static let profileItemHeight: CGFloat = 104
        static let logoutItemHeight: CGFloat = 90
        static let itemHeight: CGFloat = 50 
        static let streakLPHeight: CGFloat = 320 // height for streak and LP view
    }

    struct AccountItem {
        static let titleFont = UIFont.systemFont(ofSize: 16)
    }

    struct AccountVersion {
        static let titleFont = UIFont.kauflandFont(ofSize: 14)
    }

    struct EnergyBadges {
        static let productTitleLabelFont = UIFont.mediumKauflandFont(ofSize: 12)
        static let descriptionLabelFont = UIFont.kauflandFont(ofSize: 11)
        static let itemHeightWithOldRatings: CGFloat = 200
        static let itemHeight: CGFloat = 43
        static let groupSpacing: CGFloat = 10
        static let dataSheetButtonFont = UIFont.kauflandFont(ofSize: 12)
    }

    struct PIEnergyRatings {
        static let contentHeight: CGFloat = 16
        static let contentHeightPDP: CGFloat = 20
    }

    struct PIEnergyBadges {
        static let itemWidth: CGFloat = 31
        static let itemHeight: CGFloat = 16
        static let interItemSpacing: CGFloat = 10
        static let dataSheetButtonFont = UIFont.kauflandFont(ofSize: 12)
        static let collectionViewWidthWithNewSingleEnergyRating: CGFloat = 37
    }

    struct RecommendationEnergyBadges {
        static let itemWidth: CGFloat = 31
        static let itemHeight: CGFloat = 16
        static let interItemSpacing: CGFloat = 5
    }

    struct BlinkableAnimation {
        static let animation = "blink"
    }

    struct MoreActions {
        static let wishlistContentHeight: CGFloat = 130
    }

    struct RecommenderContainer {
        static let topMargin: CGFloat = 68
        static let containerHeight: CGFloat = 323
    }

    struct RecoHelper {
        static let normalHeight: CGFloat = 378
        static let normalHeightWithFBKInfo: CGFloat = 392
        static let heightWithEnergyRangeOrDataSheet: CGFloat = 415
        static let heightWithEnergyRangeAndDataSheet: CGFloat = 435
    }

    struct BrandSliderView {
        static let numberOfSkeletonCells = 6
        static let itemHeight: CGFloat = 53
        static let itemWidth: CGFloat = 100
        static let groupWidth: CGFloat = 500
        static let groupHeight: CGFloat = 148
        static let groupSpacing: CGFloat = 10
        static let sectionInsets = NSDirectionalEdgeInsets(top: 16,
                                                           leading: 16,
                                                           bottom: 16,
                                                           trailing: 16)
        static let parentViewItemCellShadow = SketchShadow(color: KauflandColors.black, alpha: 0.15, x: 0, y: 3, blur: 8, spread: 0)
    }

    struct CategoriesSliderView {
        static let shadowRadius: CGFloat = 8
        static let shadowOpacity: Float = 1
        static let shadowOffset: CGSize = CGSize(width: 0, height: 3)
        static let itemHeight: CGFloat = 130
        static let itemWidth: CGFloat = 100
        static let groupWidth: CGFloat = 500
        static let groupHeight: CGFloat = 130
        static let groupSpacing: CGFloat = 10
        static let sectionInsets = UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 8)
        static let parentViewItemCellShadow = SketchShadow(color: KauflandColors.black, alpha: 0.15, x: 0, y: 3, blur: 8, spread: 0)
    }
    
    struct CustomerReview {
        static let titleFont = UIFont.boldKauflandFont(ofSize: 18)
        static let detailFont = UIFont.kauflandFont(ofSize: 14)
        static let reviewCountFont = UIFont.kauflandFont(ofSize: 12)
        static let legalInfoFont = UIFont.systemFont(ofSize: 12)
        static let itemHeight: CGFloat = 20
        static let groupSpacing: CGFloat = 16
        static let numberOfSectionsForReviewBars = 5
    }
    
    struct TagLabel {
        static let inset: CGFloat = 5
    }
    
    struct UserProfileView {
        static let cornerRadius: CGFloat = 8
        static let titleFont = UIFont.boldKauflandFont(ofSize: 16)
        static let subtitleFont = UIFont.mediumKauflandFont(ofSize: 12)
    }
    
    struct KButton {
        static let shadowRadius: CGFloat = 3
        static let shadowOpacity: Float = 0.2
    }

    struct PromoSliderView {
        static let itemHeight: CGFloat = 260
        static let groupSpacing: CGFloat = 0
        static let sectionInsets = NSDirectionalEdgeInsets(top: 8,
                                                           leading: 0,
                                                           bottom: 0,
                                                           trailing: 0)
        static let parentViewItemCellShadow = SketchShadow(color: KauflandColors.black, alpha: 0.15, x: 0, y: 3, blur: 8, spread: 0)
    }
    
    struct PDP {
        static let headlineHeight: CGFloat = 95
        static let imagePresenterHeight: CGFloat = 411
        static let headlineGroupHeight: CGFloat =  460
        static let priceHeight: CGFloat =  450
        static let priceHeightWithMultipleEnergy: CGFloat =  502
        static let productNotAvailableHeight: CGFloat = 123
        static let deliveryAndSellerHeight: CGFloat =  90
        static let instalmentHeight: CGFloat = 35
        static let paymentMethodsHeight: CGFloat = 117
        static let descriptionHeight: CGFloat = 69
        static let customerReviewHeight: CGFloat = 117
        static let skeletonHeight: CGFloat = 920
        static let otherOfferHeight: CGFloat = 100
        static let otherOfferOneLineHeight: CGFloat = 80

        static let descriptionGroupHeight: CGFloat =  215
        static let interGroupSpacing: CGFloat = 10
        static let headerSectionInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        static let headerFooterHeight: CGFloat = 11
        static let sectionInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        static let otherOffersSectionInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 10, trailing: 8)
        static let brandImageMinWidth: CGFloat = 17
        static let brandImageMaxWidth: CGFloat = 55
        static let preferredImageSizeString: String = "1024x1024"
        static let nameLabelLineSpacing: CGFloat = 22
        static let titleFont = UIFont.boldKauflandFont(ofSize: 16)
        static let variantHeight: CGFloat = 97
        static let variantOffset: CGFloat = 14
        static let singleEnergyHeight: CGFloat = 40

        static let notificationPositionFromBottom: CGFloat = 70
        static let addToCartNotificationViewDuration: Double = 4.0

        static let recommendationContainerHeight: CGFloat = 383
        static let recommendationContainerTitleFont = UIFont.boldKauflandFont(ofSize: 18)
        static let recommendationClearAllButtonTitleFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let recommendationItemWidth: CGFloat = 160
        static let recommendationGroupFractionalWidth = CGFloat(0.428)
        static let recommendationItemHeight: CGFloat = 320
        static let recommendationItemCellShadow = SketchShadow(color: KauflandColors.black, alpha: 0.15, x: 0, y: 3, blur: 8, spread: 0)
        static let recommendationNameLabelFont = UIFont.boldKauflandFont(ofSize: 14)
        static let recommendationBasePriceLabelFont = UIFont.kauflandFont(ofSize: 12)
        static let recommendationPriceLabelFont = UIFont.boldKauflandFont(ofSize: 18)
        static let recommendationShippingLabelFont = UIFont.kauflandFont(ofSize: 12)
        static let recommendationDiscountLabelFont = UIFont.boldKauflandFont(ofSize: 14)
        static let recommendationPlaceHolderImageName = "placeholder_image"
        static let recommendationPreferredImageSizeString = "200x200"
        static let recommendationBadgeLabelFont = UIFont.mediumKauflandFont(ofSize: 12)
        static let recommendationBadgeLabelInset: CGFloat = 12
        static let recommendationBadgeLabelCornerRadius: CGFloat = 6
        static let recommendationDiscountLabelInset: CGFloat = 8
        static let recommendationEnergyRangeLabelFont = UIFont.kauflandFont(ofSize: 11)
        static let recommendationPackagingLabelFont = UIFont.kauflandFont(ofSize: 11)
        static let recommendationDepositLabelFont = UIFont.mediumKauflandFont(ofSize: 12)
        static let recommendationContainerCellInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 0, trailing: 16)
        static let ageRestrictionTitleFont = UIFont.boldKauflandFont(ofSize: 11)
        static let ageRestrictionSubtitleFont = UIFont.kauflandFont(ofSize: 10)
        static let dataSheetButtonFont = UIFont.kauflandFont(ofSize: 12)

        static let sharePreferredImageSizeString = "200x200"
        static let wishlistButtonAnimationScaleFactor: Double = 0.6
        static let wishlistButtonAnimationDuration: Double = 0.2

        static let recommendationContainerInterGroupSpacing: CGFloat = 10
        static let recommendationContainerInterSectionSpacing: CGFloat = 20
        static let numberOfRecoItemSkeletonCells = 6
        static let cornerRadius: CGFloat = 8
    }
    
}
