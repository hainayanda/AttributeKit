//
//  StatsSpec.swift
//  AttributeKit_Tests
//
//  Created by Nayanda Haberty on 24/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AttributeKit
import Quick
import Nimble

class StatsSpec: QuickSpec {
    
    override func spec() {
        var initial: Int!
        var wrapperUnderTest: Stats<Int>!
        beforeEach {
            initial = 6
            wrapperUnderTest = Stats(wrappedValue: initial)
        }
        it("should calculate stats of the property") {
            let added: [Int] = [8, 2, 4]
            added.forEach { wrapperUnderTest.wrappedValue = $0 }
            let stats = wrapperUnderTest.projectedValue
            expect(stats.count).to(equal(4))
            expect(stats.total).to(equal(20))
            expect(stats.maximum).to(equal(8))
            expect(stats.minimum).to(equal(2))
            expect(stats.average).to(equal(5))
        }
    }
}
