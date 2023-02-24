//
//  FilteredSpec.swift
//  AttributeKit_Tests
//
//  Created by Nayanda Haberty on 24/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AttributeKit
import Quick
import Nimble

class FilteredSpec: QuickSpec {
    
    override func spec() {
        var initial: [Int]!
        var wrapperUnderTest: Filtered<Int>!
        beforeEach {
            initial = [1, 2, 3]
            wrapperUnderTest = Filtered(wrappedValue: initial, ignore: 1)
        }
        it("should filter the property on init") {
            expect(wrapperUnderTest.wrappedValue).to(equal([2, 3]))
            expect(wrapperUnderTest.projectedValue).to(equal(initial))
        }
        it("should filter the property when assign") {
            wrapperUnderTest.wrappedValue.append(1)
            expect(wrapperUnderTest.wrappedValue).to(equal([2, 3]))
            expect(wrapperUnderTest.projectedValue).to(equal([2, 3, 1]))
        }
    }
}
