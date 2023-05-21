//
//  DateFormats.swift
//  KCommonUIKit-iOS
//
//  Created by Felix Zardai on 31.10.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

import Foundation

public enum OffersDateFormats {
    case long
    case week
    case short
    case shortWithDay

    public var dateFormat: String {
        switch self {
        case .long:
            return "dd.MM.yyyy"
        case .week:
            return "EEEE, dd.MM."
        case .short:
            return "dd.MM."
        case .shortWithDay:
            return "EEEEEE, dd.MM."
        }
    }
}

public enum CustomerDateFormats {
    case birthday

    public var dateFormat: String {
        switch self {
        case .birthday:
            return "yyyy-MM-dd"
        }
    }

}

public enum AdobeAnalyticsFormats {
    case dayTime
    case date
    case time

    public var dateFormat: String {
        switch self {
        case .dayTime:
            return "d.M.yyyy-H:m"
        case .date:
            return "d.M.yyyy"
        case .time:
            return "h:m:s.ms"
        }
    }
}
