//
//  PromoSliderCollectionViewModel.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 16.08.22.
//

import Foundation
import Combine

class PromoSliderCollectionViewModel {
    let service: PromoSliderServiceProtocol

    @Published var promoSlider: PromoSlider?
    private var subscribers = Set<AnyCancellable>()

    init(service: PromoSliderServiceProtocol) {
        self.service = service
        requestPromoSlider()
    }

    var numberOfPages: Int {
        promoSlider?.total ?? 0
    }

    var numberOfSections: Int {
        return 1
    }

    var numberOfItems: Int {
        return promoSlider?.banners.count ?? 0
    }

    func title(for indexPath: IndexPath) -> String {
        guard let item = promoSlider?.banners.safeRef(indexPath.row) else { return "" }
        return item.name
    }

    func viewModelPromoSlider(for indexPath: IndexPath) -> PromoSliderItemCollectionViewModel? {
        guard let item = promoSlider?.banners.safeRef(indexPath.row) else { return nil }
        return PromoSliderItemCollectionViewModel(item: item)
    }
}

// MARK: Promo Slider
extension PromoSliderCollectionViewModel {
    func requestPromoSlider() {
        service.promoSlider()
            .receive(on: DispatchQueue.main)
            .sink { resultCompletion in
                switch resultCompletion {
                case .failure, .finished: break
                }
            } receiveValue: { [weak self] promoSlider in
                self?.promoSlider = promoSlider
            }.store(in: &subscribers)
    }
}
