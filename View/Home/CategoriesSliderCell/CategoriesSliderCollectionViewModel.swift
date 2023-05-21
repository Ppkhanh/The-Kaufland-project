//
//  CategoriesSliderCollectionViewModel.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 07.07.22.
//

import Foundation
import Combine

class CategoriesSliderCollectionViewModel {
    let service: CategorySliderServiceProtocol

    var onError: (() -> Void)?
    var categorySliderDealsEnabled: Bool
    @Published var categorySlider: CategorySlider?

    private var subscribers = Set<AnyCancellable>()

    init(service: CategorySliderServiceProtocol, categorySliderDeals: Bool) {
        self.service = service
        self.categorySliderDealsEnabled = categorySliderDeals
        requestSliderCategories()
    }

    var title: String {
        Strings.mpHomeCategorySliderTitle.localized
    }

    var numberOfSections: Int {
        return 1
    }

    var numberOfItems: Int {
        return categorySlider?.categories.count ?? 0
    }

    func viewModelCategorySlider(for indexPath: IndexPath) -> CategoriesSliderItemViewModel? {
        guard let item = categorySlider?.categories.safeRef(indexPath.row) else { return nil }
        return CategoriesSliderItemViewModel(item: item)
    }

    func title(for row: Int) -> String? {
        guard let item = categorySlider?.categories.safeRef(row) else { return nil }
        return item.title
    }
}

// MARK: Fetch Slider Categories
extension CategoriesSliderCollectionViewModel {
    func requestSliderCategories() {
        service.categorySlider()
            .receive(on: DispatchQueue.main)
            .sink { resultCompletion in
                switch resultCompletion {
                case .failure, .finished: break
                }
            } receiveValue: { [weak self] categorySlider in
                guard let self = self else { return }
                self.categorySlider = categorySlider

                // Filter the deals if A/B flag for deals is not set
                guard self.categorySliderDealsEnabled else {
                    self.categorySlider?.categories = categorySlider.categories.filter { $0.name != "deals" }
                    return
                }
            }.store(in: &subscribers)
    }
}
