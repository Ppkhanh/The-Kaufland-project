//
//  Observable.swift
//  KCoreKit-iOS
//
//  Created by Plamen Penchev on 4.11.21.
//  Copyright © 2021 Markus Troßbach. All rights reserved.
//

#if canImport(Combine)
import Foundation
import Combine

@available(iOS 13, *)
/// Object that represents an observable to which subscribers can attach.
/// Current implementation relies entirely on Combines `CurrentValueSubject`,
/// therefore it's available for iOS 13+ only.
public final class Observable<T> {
    private let subject: CurrentValueSubject<T, Never>
    // FUTURE PPe: If needed implement key/value logic for removing the subscription.
    private var cancellables = Set<AnyCancellable>()

    /// The current value held in the observable.
    public var value: T {
        set {
            subject.send(newValue)
        }
        get {
            subject.value
        }
    }

    public init(_ value: T) {
        self.subject = CurrentValueSubject(value)
    }

    /// Attaches a closure to execute when the binding value changes.
    /// - Parameter queue: The queue the publisher uses for element delivery.
    /// - Parameter receiveValue: The closure to execute with the new value.
    public func sink(on queue: DispatchQueue = .main, receiveValue: @escaping (T) -> Void) {
        subject
            .receive(on: queue)
            .sink(receiveValue: receiveValue)
            .store(in: &cancellables)
    }
}
#endif
