//
//  Mapped.swift
//  AttributeKit
//
//  Created by Nayanda Haberty on 23/2/23.
//

import Foundation

// MARK: Mapped

@propertyWrapper
public class Mapped<Wrapped, Projected> {
    
    private let mapper: (Wrapped) -> Projected?
    
    public var wrappedValue: Wrapped
    
    /// Mapped value
    public var projectedValue: Projected? {
        mapper(wrappedValue)
    }
    
    public init(wrappedValue: Wrapped, _ mapper: @escaping (Wrapped) -> Projected?) {
        self.mapper = mapper
        self.wrappedValue = wrappedValue
    }
    
    public convenience init(wrappedValue: Wrapped, keyPath: KeyPath<Wrapped, Projected>) {
        self.init(wrappedValue: wrappedValue) { $0[keyPath: keyPath] }
    }
}

// MARK: URLMapped

@propertyWrapper
public class URLMapped {
    
    public var wrappedValue: String
    
    /// URL from string property
    public var projectedValue: URL? {
        URL(string: wrappedValue)
    }
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
