//
//  Filtered.swift
//  AttributeKit
//
//  Created by Nayanda Haberty on 23/2/23.
//

import Foundation

// MARK: Filtered

@propertyWrapper
public class Filtered<Wrapped> {
    
    private let filterWorker: (Wrapped) -> Bool
    
    private var filteredValueUpdated: Bool = false
    private var filteredValue: [Wrapped] = []
    
    private var _wrappedValue: [Wrapped]
    public var wrappedValue: [Wrapped] {
        get {
            if !filteredValueUpdated {
                filteredValue = _wrappedValue.filter(filterWorker)
                filteredValueUpdated = true
            }
            return filteredValue
        }
        set {
            _wrappedValue = newValue
            filteredValueUpdated = false
        }
    }
    
    /// Unfiltered property value
    public var projectedValue: [Wrapped] { _wrappedValue }
    
    public init(wrappedValue: [Wrapped], _ isIncluded: @escaping (Wrapped) -> Bool) {
        self._wrappedValue = wrappedValue
        self.filterWorker = isIncluded
    }
}

// MARK: Filtered + Equatable

public extension Filtered where Wrapped: Equatable {
    
    convenience init(wrappedValue: [Wrapped], ignore element: Wrapped) {
        self.init(wrappedValue: wrappedValue) { $0 != element }
    }
    
}
