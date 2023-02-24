//
//  Mapped.swift
//  AttributeKit_Tests
//
//  Created by Nayanda Haberty on 24/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AttributeKit
import Quick
import Nimble

class MappedSpec: QuickSpec {
    
    override func spec() {
        it("should map the property") {
            @Mapped(keyPath: \.count) var text = "Lorem ipsum"
            expect($text).to(equal(11))
        }
        it("should map to url if can") {
            @URLMapped var text = "www.github.com"
            expect($text).toNot(beNil())
        }
        it("should not map to url cannot") {
            @URLMapped var text = "Lorem ipsum"
            expect($text).to(beNil())
        }
    }
}
