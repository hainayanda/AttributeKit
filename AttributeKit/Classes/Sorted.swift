//
//  Sorted.swift
//  AttributeKit
//
//  Created by Nayanda Haberty on 23/2/23.
//

import Foundation

@propertyWrapper
public class Sorted<Wrapped: Comparable> {
    private let comparator: (Wrapped, Wrapped) -> Bool
    
    private var sortedValueUpdated: Bool = false
    private var sortedValue: [Wrapped] = []
    
    private var _wrappedValue: [Wrapped]
    public var wrappedValue: [Wrapped] {
        get {
            if !sortedValueUpdated {
                sortedValue = _wrappedValue.sorted(by: comparator)
                sortedValueUpdated = true
            }
            return sortedValue
        }
        set {
            _wrappedValue = newValue
            sortedValueUpdated = false
        }
    }
    
    /// Unsorted value
    public var projectedValue: [Wrapped] { _wrappedValue }
    
    public init(wrappedValue: [Wrapped], _ comparator: @escaping (Wrapped, Wrapped) -> Bool) {
        self._wrappedValue = wrappedValue
        self.comparator = comparator
    }
    
    public convenience init(wrappedValue: [Wrapped]) {
        self.init(wrappedValue: wrappedValue, <)
    }
}
