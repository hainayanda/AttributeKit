//
//  Stats.swift
//  AttributeKit
//
//  Created by Nayanda Haberty on 24/2/23.
//

import Foundation
#if canImport(UIKit)
import UIKit
#endif

// MARK: DividableByInt

public protocol DividableByInt {
    func divided(by number: Int) -> Self
}

// MARK: Int + DividableByInt

extension Int: DividableByInt {
    public func divided(by number: Int) -> Int { self / number }
}

// MARK: Float + DividableByInt

extension Float: DividableByInt {
    public func divided(by number: Int) -> Float { self / Float(number) }
}

// MARK: Double + DividableByInt

extension Double: DividableByInt {
    public func divided(by number: Int) -> Double { self / Double(number) }
}

#if canImport(UIKit)
// MARK: CGFloat + DividableByInt

extension CGFloat: DividableByInt {
    public func divided(by number: Int) -> CGFloat { self / CGFloat(number) }
}
#endif

// MARK: Calculatable

public typealias Calculatable = AdditiveArithmetic & Comparable & DividableByInt

// MARK: Statistic

public struct Statistic<Value: Calculatable> {
    public private(set) var maximum: Value
    public private(set) var minimum: Value
    public private(set) var total: Value
    public private(set) var count: Int
    public var average: Value { total.divided(by: count) }
    
    init(initial: Value) {
        self.maximum = initial
        self.minimum = initial
        self.total = initial
        self.count = 1
    }
    
    mutating func add(value: Value) {
        maximum = max(value, maximum)
        minimum = min(value, minimum)
        total += value
        count += 1
    }
}

// MARK: Stats

@propertyWrapper
public final class Stats<Wrapped: Calculatable> {
    private var stats: Statistic<Wrapped>
    
    public var wrappedValue: Wrapped {
        didSet {
            stats.add(value: wrappedValue)
        }
    }
    
    public var projectedValue: Statistic<Wrapped> { stats }
    
    public init(wrappedValue: Wrapped) {
        self.stats = Statistic(initial: wrappedValue)
        self.wrappedValue = wrappedValue
    }
}

// MARK: Stats + Encodable

extension Stats: Encodable where Wrapped: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

// MARK: Stats + Decodable

extension Stats: Decodable where Wrapped: Decodable {
    
    public convenience init(from decoder: Decoder) throws {
        self.init(wrappedValue: try Wrapped(from: decoder))
    }
}
