//
//  AutoReleased.swift
//  AttributeKit
//
//  Created by Nayanda Haberty on 24/2/23.
//

import Foundation

@propertyWrapper
public class AutoReleased<Wrapped> {
    
    private var worker: DispatchWorkItem? {
        didSet {
            oldValue?.cancel()
        }
    }
    private var lifeSpan: TimeInterval
    
    public var wrappedValue: Wrapped? {
        didSet {
            guard wrappedValue != nil else { return }
            resetTimer()
        }
    }
    
    /// Life span of the property
    public var projectedValue: TimeInterval {
        get {
            lifeSpan
        }
        set {
            lifeSpan = newValue
        }
    }
    
    public init(wrappedValue: Wrapped? = nil, lifeSpan: TimeInterval) {
        self.lifeSpan = lifeSpan
        self.wrappedValue = wrappedValue
        if wrappedValue != nil {
            resetTimer()
        }
    }
    
    private func resetTimer() {
        let worker = DispatchWorkItem { [weak self] in
            self?.wrappedValue = nil
        }
        self.worker = worker
        DispatchQueue.main.asyncAfter(deadline: .now() + lifeSpan, execute: worker)
    }
}
