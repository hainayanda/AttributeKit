//
//  Unique.swift
//  AttributeKit
//
//  Created by Nayanda Haberty on 22/2/23.
//

import Foundation

// MARK: Unique

@propertyWrapper
public final class Unique<Wrapped> {
    
    private let distinctor: ([Wrapped]) -> [Wrapped]
    
    private var uniqueValueUpdated: Bool = false
    private var uniqueValue: [Wrapped] = []
    
    private var _wrappedValue: [Wrapped]
    public var wrappedValue: [Wrapped] {
        get {
            if !uniqueValueUpdated {
                uniqueValue = distinctor(_wrappedValue)
                uniqueValueUpdated = true
            }
            return uniqueValue
        }
        set {
            _wrappedValue = newValue
            uniqueValueUpdated = false
        }
    }
    
    /// Unfiltered value
    public var projectedValue: [Wrapped] { _wrappedValue }
    
    public init(wrappedValue: [Wrapped], comparator: @escaping (Wrapped, Wrapped) -> Bool) {
        self._wrappedValue = wrappedValue
        self.distinctor = { input in
            var output: [Wrapped] = []
            for value in input where !output.contains(where: { comparator(value, $0) }) {
                output.append(value)
            }
            return output
        }
    }
    
    public init(wrappedValue: [Wrapped], projection: @escaping (Wrapped) -> AnyHashable) {
        self._wrappedValue = wrappedValue
        self.distinctor = { input in
            var seen: [AnyHashable: Void] = [:]
            return input.filter {
                let hashable = projection($0)
                guard seen[hashable] == nil else { return false }
                seen[hashable] = ()
                return true
            }
        }
    }
    
    public convenience init<Property: Hashable>(wrappedValue: [Wrapped], by keyPath: KeyPath<Wrapped, Property>) {
        self.init(wrappedValue: wrappedValue, projection: { $0[keyPath: keyPath] })
    }
    
}

// MARK: Unique + Equatable

extension Unique where Wrapped: Equatable {
    public convenience init(wrappedValue: [Wrapped]) {
        self.init(wrappedValue: wrappedValue, comparator: ==)
    }
}

extension Unique: Decodable where Wrapped: Decodable, Wrapped: Equatable {
    
    public convenience init(from decoder: Decoder) throws {
        self.init(wrappedValue: try [Wrapped](from: decoder))
    }
}

// MARK: Unique + Hashable

extension Unique where Wrapped: Hashable {
    public convenience init(wrappedValue: [Wrapped]) {
        self.init(wrappedValue: wrappedValue) { $0 }
    }
}

// MARK: Unique + Encodable

extension Unique: Encodable where Wrapped: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}
