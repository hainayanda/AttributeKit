//
//  Matched.swift
//  AttributeKit
//
//  Created by Nayanda Haberty on 23/2/23.
//

import Foundation

// MARK: Matched

@propertyWrapper
public class Matched<Wrapped> {
    
    private var matcher: (Wrapped) -> Bool
    
    private var _wrappedValue: Wrapped?
    public var wrappedValue: Wrapped? {
        get {
            _wrappedValue
        }
        set {
            guard let newValue else {
                _wrappedValue = nil
                return
            }
            guard matcher(newValue) else { return }
            _wrappedValue = newValue
        }
    }
    
    public init(wrappedValue: Wrapped? = nil, _ matcher: @escaping (Wrapped) -> Bool) {
        self.matcher = matcher
        if let wrappedValue {
            self._wrappedValue = matcher(wrappedValue) ? wrappedValue: nil
        }
    }
    
    public convenience init<Property: Equatable>(wrappedValue: Wrapped? = nil, _ keyPath: KeyPath<Wrapped, Property>, equal matcher: Property) {
        self.init(wrappedValue: wrappedValue) { wrapped in
            wrapped[keyPath: keyPath] == matcher
        }
    }
    
    public convenience init<Property: Comparable>(wrappedValue: Wrapped? = nil, _ keyPath: KeyPath<Wrapped, Property>, _ relationship: CompareRelationship<Property>) {
        self.init(wrappedValue: wrappedValue) { wrapped in
            switch relationship {
            case .lessThan(let value):
                return wrapped[keyPath: keyPath] < value
            case .lessThanOrEqual(let value):
                return wrapped[keyPath: keyPath] <= value
            case .notEqual(let value):
                return wrapped[keyPath: keyPath] != value
            case .greaterThanOrEqual(let value):
                return wrapped[keyPath: keyPath] >= value
            case .greaterThan(let value):
                return wrapped[keyPath: keyPath] > value
            }
        }
    }
}

// MARK: Matched + String

public extension Matched where Wrapped == String {
    
    convenience init(wrappedValue: String? = nil, regex: String) {
        self.init(wrappedValue: wrappedValue) { text in
            text.match(regex)
        }
    }
    
    convenience init(wrappedValue: String? = nil, is characterSet: CharacterSet) {
        self.init(wrappedValue: wrappedValue) { text in
            text.rangeOfCharacter(from: characterSet.inverted) == nil
        }
    }
}

// MARK: String + Regex

public extension String {
    
    func match(_ regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: .anchorsMatchLines)
            let stringRange = NSRange(location: .zero, length: utf16.count)
            let matches = regex.matches(in: self, range: stringRange)
            return !matches.isEmpty
        } catch {
            return false
        }
    }
    
    static var regexEmail: String = #"^((?!\.)[\w\-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$"#
}

// MARK: CompareRelationship

public enum CompareRelationship<Value: Comparable> {
    case lessThan(Value)
    case lessThanOrEqual(Value)
    case notEqual(Value)
    case greaterThanOrEqual(Value)
    case greaterThan(Value)
}

// MARK: Matched + Comparable

public extension Matched where Wrapped: Comparable {
    
    convenience init(wrappedValue: Wrapped?, _ relationship: CompareRelationship<Wrapped>) {
        self.init(wrappedValue: wrappedValue) { comparable in
            switch relationship {
            case .lessThan(let value):
                return comparable < value
            case .lessThanOrEqual(let value):
                return comparable <= value
            case .notEqual(let value):
                return comparable != value
            case .greaterThanOrEqual(let value):
                return comparable >= value
            case .greaterThan(let value):
                return comparable > value
            }
        }
    }
}
