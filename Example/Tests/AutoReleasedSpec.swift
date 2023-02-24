//
//  AutoReleasedSpec.swift
//  AttributeKit_Tests
//
//  Created by Nayanda Haberty on 24/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AttributeKit
import Quick
import Nimble

class AutoReleasedSpec: QuickSpec {
    // swiftlint:disable force_try
    override func spec() {
        var lifeSpan: TimeInterval!
        var wrapperUnderTest: AutoReleased<Int>!
        beforeEach {
            lifeSpan = 1
            wrapperUnderTest = AutoReleased(wrappedValue: 100, lifeSpan: lifeSpan)
        }
        it("should released initial value after life span timeout") {
            expect(wrapperUnderTest.wrappedValue).to(equal(100))
            try! await Task.sleep(nanoseconds: UInt64(lifeSpan) * 1_000_000_000)
            expect(wrapperUnderTest.wrappedValue).to(beNil())
        }
        it("should released after life span timeout") {
            wrapperUnderTest.wrappedValue = 1
            expect(wrapperUnderTest.wrappedValue).to(equal(1))
            try await Task.sleep(nanoseconds: UInt64(lifeSpan) * 1_000_000_000)
            expect(wrapperUnderTest.wrappedValue).to(beNil())
        }
        it("should change life span via projectedValue") {
            let newLifeSpan = lifeSpan * 2
            wrapperUnderTest.projectedValue = newLifeSpan
            wrapperUnderTest.wrappedValue = 1
            expect(wrapperUnderTest.wrappedValue).to(equal(1))
            try await Task.sleep(nanoseconds: UInt64(lifeSpan) * 1_000_000_000)
            expect(wrapperUnderTest.wrappedValue).to(equal(1))
            try await Task.sleep(nanoseconds: UInt64(lifeSpan) * 1_000_000_000)
            expect(wrapperUnderTest.wrappedValue).to(beNil())
        }
    }
}
