//
//  CustomerHistoryHandler.swift
//  KMarketPlaceKit
//
//  Created by Priyanka Saroha on 04.04.22.
//

import Foundation

class CustomerHistoryHandler {
    static let shared = CustomerHistoryHandler()

    private typealias UIConst = Constants.CustomerHistoryHandler

    private let maxHistoryEventLimit = 1000
    @JSONDefaults(key: UIConst.defaultsKey)
    private var customerHistory: CustomerHistory?

    private init() {
        if customerHistory == nil {
            customerHistory = CustomerHistory(events: [])
        }
    }

    private var isLimitExceeded: Bool {
        customerHistory?.events?.count == maxHistoryEventLimit
    }

    func addEvent(_ eventType: CustomerHistoryEventType, categoryId: String?) {
        // Customer history must be tracked only when he has given consent for 'Marketing'

        // If Last Seen cached limit exceeded then remove last before saving new
        if isLimitExceeded {
            customerHistory?.events?.removeFirst()
        }

        let categoryIdIntValue = Int(categoryId ?? "") ?? 0
        let event = CustomerHistoryEvent(categoryId: categoryIdIntValue,
                                         eventType: eventType,
                                         timestamp: Date().millisecondsSince1970)
        customerHistory?.events?.append(event)
    }

    func eventsDictWithCategoryLevel() -> Data? {
        var dict = ["customer_history": historyEventsAsDict] as [String: Any]
        return try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
    }

    private var historyEventsAsDict: [[String: Any]] {
        guard let historyEvents = customerHistory?.events else { return [] }

        var eventsDict = [[String: Any]]()

        historyEvents.forEach { event in
            var eventDict = [String: Any]()
            eventDict["category_id"] = event.categoryId
            eventDict["event"] = event.eventType.rawValue
            eventDict["timestamp"] = event.timestamp
            eventsDict.append(eventDict)
        }
        return eventsDict
    }
}
