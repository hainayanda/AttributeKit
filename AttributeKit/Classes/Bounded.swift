//
//  Bounded.swift
//  AttributeKit
//
//  Created by Nayanda Haberty on 23/2/23.
//

import Foundation

// MARK: Bounded

@propertyWrapper
public class Bounded<Wrapped: Comparable> {
    
    private var range: ClosedRange<Wrapped>
    
    private var _wrappedValue: Wrapped
    public var wrappedValue: Wrapped {
        get {
            _wrappedValue
        }
        set {
            _wrappedValue = min(max(newValue, range.lowerBound), range.upperBound)
        }
    }
    
    /// Bounded range of this property
    public var projectedValue: ClosedRange<Wrapped> {
        get {
            range
        }
        set {
            range = newValue
            _wrappedValue = min(max(_wrappedValue, newValue.lowerBound), newValue.upperBound)
        }
    }
    
    public init(wrappedValue: Wrapped, _ range: ClosedRange<Wrapped>) {
        self.range = range
        self._wrappedValue = min(max(wrappedValue, range.lowerBound), range.upperBound)
    }
}

// MARK: LowerBounded

@propertyWrapper
public class LowerBounded<Wrapped: Comparable> {
    
    private var lowerBound: Wrapped
    
    private var _wrappedValue: Wrapped
    public var wrappedValue: Wrapped {
        get {
            _wrappedValue
        }
        set {
            _wrappedValue = max(newValue, lowerBound)
        }
    }
    
    /// Lower bound of this property
    public var projectedValue: Wrapped {
        get {
            lowerBound
        }
        set {
            lowerBound = newValue
            _wrappedValue = max(_wrappedValue, newValue)
        }
    }
    
    public init(wrappedValue: Wrapped, _ lowerBound: Wrapped) {
        self.lowerBound = lowerBound
        self._wrappedValue = wrappedValue
    }
}

// MARK: UpperBounded

@propertyWrapper
public class UpperBounded<Wrapped: Comparable> {
    
    private var upperBound: Wrapped
    
    private var _wrappedValue: Wrapped
    public var wrappedValue: Wrapped {
        get {
            _wrappedValue
        }
        set {
            _wrappedValue = min(newValue, upperBound)
        }
    }
    
    /// Upper bound of this property
    public var projectedValue: Wrapped {
        get {
            upperBound
        }
        set {
            upperBound = newValue
            _wrappedValue = min(_wrappedValue, newValue)
        }
    }
    
    public init(wrappedValue: Wrapped, _ upperBound: Wrapped) {
        self.upperBound = upperBound
        self._wrappedValue = wrappedValue
    }
}
