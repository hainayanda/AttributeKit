//
//  MatchedSpec.swift
//  AttributeKit_Tests
//
//  Created by Nayanda Haberty on 24/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AttributeKit
import Quick
import Nimble

class MatchedSpec: QuickSpec {
    
    // swiftlint:disable function_body_length
    override func spec() {
        it("should still assign nil") {
            @Matched(regex: .regexEmail) var text: String? = "hainayanda@outlook.com"
            text = nil
            expect(text).to(beNil())
        }
        describe("Keypath") {
            context("equatable keypath") {
                it("should assign if match keypath") {
                    @Matched(\.count, equal: 11) var text: String? = "Lorem Ipsum"
                    expect(text).to(equal("Lorem Ipsum"))
                    text =  "dolori amet"
                    expect(text).to(equal("dolori amet"))
                }
                it("should ignore assign if not match keypath") {
                    let assigned =  "Lorem Ipsum dolor"
                    @Matched(\.count, equal: 11) var text: String? = assigned
                    expect(text).to(beNil())
                    text = "Lorem Ipsum dolor sit amet"
                    expect(text).to(beNil())
                }
            }
            context("comparable keypath") {
                context("positive case") {
                    it("should assign if match lessThan") {
                        let assigned =  "Lorem"
                        @Matched(\.count, .lessThan(10)) var text: String? = assigned
                        expect(text).to(equal(assigned))
                    }
                    it("should assign if match lessThanOrEqual") {
                        let assigned =  "Lorem Ipsu"
                        @Matched(\.count, .lessThanOrEqual(10)) var text: String? = assigned
                        expect(text).to(equal(assigned))
                    }
                    it("should assign if match greaterThan") {
                        let assigned =  "Lorem Ipsum"
                        @Matched(\.count, .greaterThan(10)) var text: String? = assigned
                        expect(text).to(equal(assigned))
                    }
                    it("should assign if match greaterThanOrEqual") {
                        let assigned =  "Lorem Ipsu"
                        @Matched(\.count, .greaterThanOrEqual(10)) var text: String? = assigned
                        expect(text).to(equal(assigned))
                    }
                    it("should assign if match notEqual") {
                        let assigned =  "Lorem"
                        @Matched(\.count, .notEqual(10)) var text: String? = assigned
                        expect(text).to(equal(assigned))
                    }
                }
                context("negative case") {
                    it("should ignore assign if not match lessThan") {
                        let assigned =  "Lorem Ipsu"
                        @Matched(\.count, .lessThan(10)) var text: String? = assigned
                        expect(text).to(beNil())
                    }
                    it("should ignore assign if not match lessThanOrEqual") {
                        let assigned =  "Lorem Ipsum"
                        @Matched(\.count, .lessThanOrEqual(10)) var text: String? = assigned
                        expect(text).to(beNil())
                    }
                    it("should ignore assign if not match greaterThan") {
                        let assigned =  "Lorem Ipsu"
                        @Matched(\.count, .greaterThan(10)) var text: String? = assigned
                        expect(text).to(beNil())
                    }
                    it("should ignore assign if not match greaterThanOrEqual") {
                        let assigned =  "Lorem Ips"
                        @Matched(\.count, .greaterThanOrEqual(10)) var text: String? = assigned
                        expect(text).to(beNil())
                    }
                    it("should ignore assign if match notEqual") {
                        let assigned =  "Lorem Ipsu"
                        @Matched(\.count, .notEqual(10)) var text: String? = assigned
                        expect(text).to(beNil())
                    }
                }
            }
        }
        describe("String Match") {
            context("character set") {
                it("should assign if match character set") {
                    @Matched(is: .alphanumerics) var text = "4lpHAnUm3R1c"
                    expect(text).to(equal("4lpHAnUm3R1c"))
                }
                it("should ignore if not match character set") {
                    @Matched(is: .decimalDigits) var text = "4lpHAnUm3R1c"
                    expect(text).to(beNil())
                }
            }
            context("regex") {
                it("should assign if match regex") {
                    @Matched(regex: .regexEmail) var text = "hainayanda@outlook.com"
                    expect(text).to(equal("hainayanda@outlook.com"))
                }
                it("should ignore if not match character set") {
                    @Matched(regex: .regexEmail) var text = "4lpHAnUm3R1c"
                    expect(text).to(beNil())
                }
            }
        }
        describe("Comparable Match") {
            context("positive case") {
                it("should assign if match lessThan") {
                    let assigned =  Int.random(in: 0..<10)
                    @Matched(.lessThan(10)) var number: Int? = assigned
                    expect(number).to(equal(assigned))
                }
                it("should assign if match lessThanOrEqual") {
                    let assigned =  Int.random(in: 0..<11)
                    @Matched(.lessThanOrEqual(10)) var number: Int? = assigned
                    expect(number).to(equal(assigned))
                }
                it("should assign if match greaterThan") {
                    let assigned =  Int.random(in: 11..<20)
                    @Matched(.greaterThan(10)) var number: Int? = assigned
                    expect(number).to(equal(assigned))
                }
                it("should assign if match greaterThanOrEqual") {
                    let assigned =  Int.random(in: 10..<20)
                    @Matched(.greaterThanOrEqual(10)) var number: Int? = assigned
                    expect(number).to(equal(assigned))
                }
                it("should assign if match notEqual") {
                    let assigned =  Int.random(in: 11..<20)
                    @Matched(.notEqual(10)) var number: Int? = assigned
                    expect(number).to(equal(assigned))
                }
            }
            context("negative case") {
                it("should ignore assign if not match lessThan") {
                    let assigned =  Int.random(in: 10..<20)
                    @Matched(.lessThan(10)) var number: Int? = assigned
                    expect(number).to(beNil())
                }
                it("should ignore assign if not match lessThanOrEqual") {
                    let assigned =  Int.random(in: 11..<21)
                    @Matched(.lessThanOrEqual(10)) var number: Int? = assigned
                    expect(number).to(beNil())
                }
                it("should ignore assign if not match greaterThan") {
                    let assigned =  Int.random(in: 0..<10)
                    @Matched(.greaterThan(10)) var number: Int? = assigned
                    expect(number).to(beNil())
                }
                it("should ignore assign if not match greaterThanOrEqual") {
                    let assigned =  Int.random(in: 0..<9)
                    @Matched(.greaterThanOrEqual(10)) var number: Int? = assigned
                    expect(number).to(beNil())
                }
                it("should ignore assign if not match notEqual") {
                    let assigned =  10
                    @Matched(.notEqual(10)) var number: Int? = assigned
                    expect(number).to(beNil())
                }
            }
        }
    }
}
