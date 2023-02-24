//
//  BoundedSpec.swift
//  AttributeKit_Tests
//
//  Created by Nayanda Haberty on 24/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AttributeKit
import Quick
import Nimble

class BoundedSpec: QuickSpec {
    
    override func spec() {
        describe("Bounded") {
            var range: ClosedRange<Int>!
            var wrapperUnderTest: Bounded<Int>!
            beforeEach {
                range = 11...20
                wrapperUnderTest = Bounded(wrappedValue: 1, range)
            }
            it("should assign if still in range") {
                let assigned = (11...20).randomElement()!
                wrapperUnderTest.wrappedValue = assigned
                expect(wrapperUnderTest.wrappedValue).to(equal(assigned))
            }
            it("should capped to the upperbound") {
                wrapperUnderTest.wrappedValue = (21...30).randomElement()!
                expect(wrapperUnderTest.wrappedValue).to(equal(20))
            }
            it("should capped to the lowerbound") {
                wrapperUnderTest.wrappedValue = (0...10).randomElement()!
                expect(wrapperUnderTest.wrappedValue).to(equal(11))
            }
            it("should capped to the new upperbound") {
                wrapperUnderTest.projectedValue = 0...10
                wrapperUnderTest.wrappedValue = (21...30).randomElement()!
                expect(wrapperUnderTest.wrappedValue).to(equal(10))
            }
            it("should capped to the new lowerbound") {
                wrapperUnderTest.projectedValue = 21...30
                wrapperUnderTest.wrappedValue = (0...10).randomElement()!
                expect(wrapperUnderTest.wrappedValue).to(equal(21))
            }
        }
        describe("UpperBounded") {
            var wrapperUnderTest: UpperBounded<Int>!
            beforeEach {
                wrapperUnderTest = UpperBounded(wrappedValue: 11, 10)
            }
            it("should assign if still lower than the upperbound") {
                let assigned = (0...10).randomElement()!
                wrapperUnderTest.wrappedValue = assigned
                expect(wrapperUnderTest.wrappedValue).to(equal(assigned))
            }
            it("should capped to the upperbound") {
                wrapperUnderTest.wrappedValue = (11...20).randomElement()!
                expect(wrapperUnderTest.wrappedValue).to(equal(10))
            }
            it("should capped to the new upperbound") {
                wrapperUnderTest.projectedValue = 5
                wrapperUnderTest.wrappedValue = (11...20).randomElement()!
                expect(wrapperUnderTest.wrappedValue).to(equal(5))
            }
        }
        describe("LowerBounded") {
            var wrapperUnderTest: LowerBounded<Int>!
            beforeEach {
                wrapperUnderTest = LowerBounded(wrappedValue: 9, 10)
            }
            it("should assign if still higher than the lowerbound") {
                let assigned = (10...20).randomElement()!
                wrapperUnderTest.wrappedValue = assigned
                expect(wrapperUnderTest.wrappedValue).to(equal(assigned))
            }
            it("should capped to the lowerbound") {
                wrapperUnderTest.wrappedValue = (0...9).randomElement()!
                expect(wrapperUnderTest.wrappedValue).to(equal(10))
            }
            it("should capped to the new lowerbound") {
                wrapperUnderTest.projectedValue = 5
                wrapperUnderTest.wrappedValue = (0...4).randomElement()!
                expect(wrapperUnderTest.wrappedValue).to(equal(5))
            }
        }
    }
}
