//
//  SortedSpec.swift
//  AttributeKit_Tests
//
//  Created by Nayanda Haberty on 24/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
@testable import AttributeKit
import Quick
import Nimble

class SortedSpec: QuickSpec {
    
    override func spec() {
        it("should sort the array ascendingly") {
            @Ascending var array: [Int] = [3, 5, 1, 6, 2, 4]
            expect(array).to(equal([1, 2, 3, 4, 5, 6]))
            expect($array).to(equal([3, 5, 1, 6, 2, 4]))
        }
        it("should sort the array after re set ascendingly") {
            @Ascending var array: [Int] = [3, 5, 1, 6, 2, 4]
            array = [13, 15, 11, 16, 12, 14]
            expect(array).to(equal([11, 12, 13, 14, 15, 16]))
            expect($array).to(equal([13, 15, 11, 16, 12, 14]))
        }
        it("should sort the array descendingly") {
            @Descending var array: [Int] = [3, 5, 1, 6, 2, 4]
            expect(array).to(equal([6, 5, 4, 3, 2, 1]))
            expect($array).to(equal([3, 5, 1, 6, 2, 4]))
        }
        it("should sort the array after re set descendingly") {
            @Descending var array: [Int] = [3, 5, 1, 6, 2, 4]
            array = [13, 15, 11, 16, 12, 14]
            expect(array).to(equal([16, 15, 14, 13, 12, 11]))
            expect($array).to(equal([13, 15, 11, 16, 12, 14]))
        }
    }
}
