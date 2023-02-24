//
//  Buffered.swift
//  AttributeKit
//
//  Created by Nayanda Haberty on 24/2/23.
//

import Foundation

@propertyWrapper
public class Buffered<Wrapped> {
    private var buffer: [Wrapped]
    private let bufferSize: Int
    
    public var wrappedValue: Wrapped {
        didSet {
            appendBuffer(with: wrappedValue)
        }
    }
    
    /// buffer
    public var projectedValue: [Wrapped] { buffer }
    
    public init(wrappedValue: Wrapped, size: Int) {
        self.bufferSize = size
        self.wrappedValue = wrappedValue
        self.buffer = [wrappedValue]
    }
    
    private func appendBuffer(with value: Wrapped) {
        let removeCount = max(buffer.count - bufferSize + 1, 0)
        if removeCount > 0 {
            buffer.removeFirst(removeCount)
        }
        buffer.append(value)
    }
}
