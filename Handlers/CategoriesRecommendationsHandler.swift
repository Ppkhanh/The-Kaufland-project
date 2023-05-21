//
//  CategoriesRecommendationsHandler.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 05.04.22.
//

import Foundation
import Combine
import Nuke

protocol CategoriesRecommendationsHandlerProtocol {
    var canFetchMore: Bool { get }
    var offset: Int { get set }
    var categoriesRecommendations: CategoriesRecommendations? { get set }
    var selectedCategoriesGroup: GroupedCategoryRecommendations? { get set }
    var categoriesGroups: [GroupedCategoryRecommendations]? { get }
    func fetchCategoriesRecommendationsAndBestSellerRecos(_ completion: @escaping (Result<[BestSellerRecommendation], Error>) -> Void)
    func fetchBestSellersRecos(_ completion: @escaping (Result<[BestSellerRecommendation], Error>) -> Void)
    func reset()
}

class CategoriesRecommendationsHandler: CategoriesRecommendationsHandlerProtocol {
    static let shared = CategoriesRecommendationsHandler()

    private var subscribers: Set<AnyCancellable> = []
    private let maxCategoriesLimit = 3

    var offset = 0
    var categoriesRecommendations: CategoriesRecommendations?
    var selectedCategoriesGroup: GroupedCategoryRecommendations?

    var categoriesGroups: [GroupedCategoryRecommendations]? {
        categoriesRecommendations?.grouped
    }

    var canFetchMore: Bool {
       categoriesToFetchBestRecos != nil
    }

    private var categoriesToFetchBestRecos: [Int]? {
        guard let categoryIds = selectedCategoriesGroup == nil ? self.categoriesRecommendations?.subCategoriesRecommendations : selectedCategoriesGroup?.subCategoriesRecommendations else { return nil }

        let nextOffset = offset + maxCategoriesLimit
        if categoryIds.count >= nextOffset {
            return Array(categoryIds[offset..<nextOffset])
        } else {
            return nil
        }
    }

    func reset() {
        categoriesRecommendations = nil
        selectedCategoriesGroup = nil
    }

    func fetchCategoriesRecommendationsAndBestSellerRecos(_ completion: @escaping (Result<[BestSellerRecommendation], Error>) -> Void) {
        self.fetchBestSellersRecos(completion)
    }

    func fetchBestSellersRecos(_ completion: @escaping (Result<[BestSellerRecommendation], Error>) -> Void) {
        subscribers.removeAll()

        BestSellersRecoService().fetchRecommendations(categoryIds: [])
            .sink { resultCompletion in
                switch resultCompletion {
                case .failure, .finished: break
                }
            } receiveValue: { [weak self] recos in
                guard let self = self else { return }
                completion(.success(recos.items ?? []))
                self.offset += recos.items?.count == 0 || recos.items == nil ? self.maxCategoriesLimit : (recos.items?.count ?? 0)
            }.store(in: &self.subscribers)
    }
}
