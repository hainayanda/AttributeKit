//
//  Dated.swift
//  AttributeKit
//
//  Created by Nayanda Haberty on 23/2/23.
//

import Foundation

// MARK: Dated

@propertyWrapper
public class Dated<Wrapped>: Mapped<Wrapped, Date> {
    
    public override var wrappedValue: Wrapped {
        get { super.wrappedValue }
        set { super.wrappedValue = newValue }
    }
    
    public override var projectedValue: Date? {
        super.projectedValue
    }
    
    public init(wrappedValue: Wrapped, converter: @escaping (Wrapped) -> Date?) {
        super.init(wrappedValue: wrappedValue, converter)
    }
}

// MARK: TimeIntervalBase

public enum TimeIntervalBase {
    case since1970
    case sinceNow
    case since(Date)
}

// MARK: TimeIntervalUnit

public enum TimeIntervalUnit {
    case days
    case hours
    case minutes
    case seconds
    case miliseconds
}

// MARK: TimeIntervalConvertible

public protocol TimeIntervalConvertible {
    var asTimeInterval: TimeInterval { get }
    func convertToTimeInterval(unit: TimeIntervalUnit) -> TimeInterval
}

// MARK: TimeIntervalConvertible + default implementation

extension TimeIntervalConvertible {
    public func convertToTimeInterval(unit: TimeIntervalUnit) -> TimeInterval {
        switch unit {
        case .days:
            return self.asTimeInterval * 86_400
        case .hours:
            return self.asTimeInterval * 3_600
        case .minutes:
            return self.asTimeInterval * 60
        case .seconds:
            return self.asTimeInterval
        case .miliseconds:
            return self.asTimeInterval / 1000
        }
    }
}

// MARK: TimeInterval + extension

public extension TimeInterval {
    func convertToDate(using base: TimeIntervalBase) -> Date {
        switch base {
        case .since1970:
            return Date(timeIntervalSince1970: self)
        case .sinceNow:
            return Date(timeIntervalSinceNow: self)
        case .since(let date):
            return Date(timeInterval: self, since: date)
        }
    }
}

// MARK: Int + TimeIntervalConvertible

extension Int: TimeIntervalConvertible {
    public var asTimeInterval: TimeInterval { TimeInterval(self) }
}

// MARK: Int32 + TimeIntervalConvertible

extension Int32: TimeIntervalConvertible {
    public var asTimeInterval: TimeInterval { TimeInterval(self) }
}

// MARK: Int64 + TimeIntervalConvertible

extension Int64: TimeIntervalConvertible {
    public var asTimeInterval: TimeInterval { TimeInterval(self) }
}

// MARK: Float + TimeIntervalConvertible

extension Float: TimeIntervalConvertible {
    public var asTimeInterval: TimeInterval { TimeInterval(self) }
}

// MARK: Double + TimeIntervalConvertible

extension Double: TimeIntervalConvertible {
    public var asTimeInterval: TimeInterval { self }
}

// MARK: Dated + TimeIntervalConvertible

public extension Dated where Wrapped: TimeIntervalConvertible {
    convenience init(wrappedValue: Wrapped, unit: TimeIntervalUnit, _ intervalBase: TimeIntervalBase = .since1970) {
        self.init(wrappedValue: wrappedValue) { value in
            value.convertToTimeInterval(unit: unit).convertToDate(using: intervalBase)
        }
    }
}

// MARK: Dated + String

public extension Dated where Wrapped == String {
    
    convenience init(wrappedValue: Wrapped, formatter: DateFormatter) {
        self.init(wrappedValue: wrappedValue) { text in
            formatter.date(from: text)
        }
    }
    
    convenience init(wrappedValue: Wrapped, format: String, timeZone: TimeZone = .current, locale: Locale = .current) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = timeZone
        dateFormatter.locale = locale
        self.init(wrappedValue: wrappedValue, formatter: dateFormatter)
    }
}
