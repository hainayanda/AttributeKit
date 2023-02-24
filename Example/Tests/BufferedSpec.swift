//
//  Buffered.swift
//  AttributeKit_Tests
//
//  Created by Nayanda Haberty on 24/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AttributeKit
import Quick
import Nimble

class BufferedSpec: QuickSpec {
    
    override func spec() {
        var initial: Int!
        var size: Int!
        var wrapperUnderTest: Buffered<Int>!
        beforeEach {
            initial = Int.random(in: 0..<100)
            size = 3
            wrapperUnderTest = Buffered(wrappedValue: initial, size: size)
        }
        it("should add value to buffer") {
            let added = Int.random(in: 0..<100)
            wrapperUnderTest.wrappedValue = added
            expect(wrapperUnderTest.projectedValue).to(equal([initial, added]))
        }
        it("should maintain buffer size to given size") {
            let added: [Int] = [.random(in: 0..<100), .random(in: 0..<100), .random(in: 0..<100)]
            added.forEach { wrapperUnderTest.wrappedValue = $0 }
            added.forEach { wrapperUnderTest.wrappedValue = $0 }
            expect(wrapperUnderTest.projectedValue).to(equal(added))
        }
    }
}
