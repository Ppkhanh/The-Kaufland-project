//
//  BrandSliderCollectionViewModel.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 12.09.22.
//

import Combine
import Foundation

class BrandSliderCollectionViewModel {
    let service: BrandSliderServiceProtocol

    @Published var brandSlider: BrandSlider?
    private var subscribers = Set<AnyCancellable>()

    init(service: BrandSliderServiceProtocol) {
        self.service = service
        requestBrandSlider()
    }

    var title: String {
        Strings.mpHomeBrandSliderTitle.localized
    }

    var numberOfSections: Int {
        return 1
    }

    var numberOfItems: Int {
        return brandSlider?.brands.count ?? 0
    }

    var horizontalGroupItems: Int {
        return brandSlider?.brands.count ?? 0
    }

    func title(for row: Int) -> String {
        guard let item = brandSlider?.brands.safeRef(row) else { return "" }
        return item.name
    }

    func viewModelBrandSlider(for indexPath: IndexPath) -> BrandSliderItemCollectionViewModel? {
        guard let item = brandSlider?.brands.safeRef(indexPath.row) else { return nil }
        return BrandSliderItemCollectionViewModel(item: item)
    }
}

// MARK: Fetch Brand Slider
extension BrandSliderCollectionViewModel {
    func requestBrandSlider() {
        service.brandSlider()
            .receive(on: DispatchQueue.main)
            .sink { resultCompletion in
                switch resultCompletion {
                case .failure, .finished: break
                }
            } receiveValue: { [weak self] brandSlider in
                guard let self = self else { return }
                self.brandSlider = brandSlider
            }.store(in: &subscribers)
    }
}
