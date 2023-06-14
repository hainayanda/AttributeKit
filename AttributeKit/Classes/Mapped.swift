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
public final class URLMapped: Mapped<String, URL> {
    
    public override var wrappedValue: String {
        get { super.wrappedValue }
        set { super.wrappedValue = newValue }
    }
    
    public override var projectedValue: URL? {
        super.projectedValue
    }
    
    public init(wrappedValue: String) {
        super.init(wrappedValue: wrappedValue) { URL(string: $0) }
    }
}

// MARK: URLMapped + Encodable

extension URLMapped: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

// MARK: URLMapped + Decodable

extension URLMapped: Decodable {
    
    public convenience init(from decoder: Decoder) throws {
        self.init(wrappedValue: try String(from: decoder))
    }
}
