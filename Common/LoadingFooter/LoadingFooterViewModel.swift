//
//  LoadingFooterViewModel.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 21.07.21.
//

import Foundation

class LoadingFooterViewModel {
    @Published var shouldShowLoadingView: Bool
    var message: String

    init(message: String, shouldShowLoadingView: Bool) {
        self.shouldShowLoadingView = shouldShowLoadingView
        self.message = message
    }

}
