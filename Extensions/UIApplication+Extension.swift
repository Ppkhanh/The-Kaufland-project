//
//  UIApplication+Extension.swift
//  KMarketPlaceKit
//
//  Created by Zuhaib Rasheed on 22.06.22.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
