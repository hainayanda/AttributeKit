//
//  UniqueSpec.swift
//  AttributeKit_Tests
//
//  Created by Nayanda Haberty on 24/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AttributeKit
import Quick
import Nimble

class UniqueSpec: QuickSpec {
    
    override func spec() {
        it("should make sure property is unique using equatable") {
            @Unique var array: [EquatableDummy] = [1, 1, 2, 3, 3, 4, 5, 6, 6]
            expect(array).to(equal([1, 2, 3, 4, 5, 6]))
            expect($array).to(equal([1, 1, 2, 3, 3, 4, 5, 6, 6]))
        }
        it("should make sure property is unique using equatable when re set") {
            @Unique var array: [EquatableDummy] = [1, 1, 2, 3, 3, 4, 5, 6, 6]
            array = [11, 11, 12, 13, 13, 14, 15, 16, 16]
            expect(array).to(equal([11, 12, 13, 14, 15, 16]))
            expect($array).to(equal([11, 11, 12, 13, 13, 14, 15, 16, 16]))
        }
        it("should make sure property is unique using hashable") {
            @Unique var array: [HashDummy] = [1, 1, 2, 3, 3, 4, 5, 6, 6]
            expect(array).to(equal([1, 2, 3, 4, 5, 6]))
            expect($array).to(equal([1, 1, 2, 3, 3, 4, 5, 6, 6]))
        }
        it("should make sure property is unique using hashable when re set") {
            @Unique var array: [HashDummy] = [1, 1, 2, 3, 3, 4, 5, 6, 6]
            array = [11, 11, 12, 13, 13, 14, 15, 16, 16]
            expect(array).to(equal([11, 12, 13, 14, 15, 16]))
            expect($array).to(equal([11, 11, 12, 13, 13, 14, 15, 16, 16]))
        }
    }
}

private struct HashDummy: Hashable, ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = Int
    
    let number: Int
    
    init(integerLiteral value: IntegerLiteralType) {
        self.number = value
    }
}

private struct EquatableDummy: Equatable, ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = Int
    
    let number: Int
    
    init(integerLiteral value: IntegerLiteralType) {
        self.number = value
    }
}
