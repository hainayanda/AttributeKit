//
//  Dated.swift
//  AttributeKit_Tests
//
//  Created by Nayanda Haberty on 24/2/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import AttributeKit
import Quick
import Nimble

class DatedSpec: QuickSpec {
    
    override func spec() {
        describe("String to Date") {
            it("should convert String to Date according to format") {
                let expected = Date(timeIntervalSince1970: 673_747_200)
                let timeZone = TimeZone(identifier: "Asia/Jakarta")!
                @Dated(format: "yyyy-MM-dd'T'HH:mm:ssZ", timeZone: timeZone) var stringDate: String = "1991-05-09T00:00:00+0000"
                expect($stringDate).to(equal(expected))
            }
        }
        describe("TimeIntervalConvertible to Date") {
            context("1970 based") {
                it("should convert Int to Date with seconds unit") {
                    let expected = Date(timeIntervalSince1970: 673_747_200)
                    @Dated(unit: .seconds) var intDate = 673_747_200
                    expect($intDate).to(equal(expected))
                }
                it("should convert Int to Date with miliseconds unit") {
                    let expected = Date(timeIntervalSince1970: 673_747_200)
                    @Dated(unit: .miliseconds) var intDate = 673_747_200_000
                    expect($intDate).to(equal(expected))
                }
                it("should convert Int to Date with miliseconds unit") {
                    let expected = Date(timeIntervalSince1970: 673_747_200)
                    @Dated(unit: .miliseconds) var intDate = 673_747_200_000
                    expect($intDate).to(equal(expected))
                }
                it("should convert Int to Date with minutes unit") {
                    let expected = Date(timeIntervalSince1970: 673_747_200)
                    @Dated(unit: .minutes) var intDate = 11_229_120
                    expect($intDate).to(equal(expected))
                }
                it("should convert Int to Date with hours unit") {
                    let expected = Date(timeIntervalSince1970: 673_747_200)
                    @Dated(unit: .hours) var intDate = 187_152
                    expect($intDate).to(equal(expected))
                }
                it("should convert Int to Date with days unit") {
                    let expected = Date(timeIntervalSince1970: 673_747_200)
                    @Dated(unit: .days) var intDate = 7798
                    expect($intDate).to(equal(expected))
                }
            }
            context("now based") {
                it("should convert Int to Date with seconds unit") {
                    let expected = Date(timeIntervalSinceNow: 673_747_200)
                    @Dated(unit: .seconds, .sinceNow) var intDate = 673_747_200
                    let result = $intDate!
                    let difference = result.timeIntervalSince1970 - expected.timeIntervalSince1970
                    expect(difference).to(beGreaterThanOrEqualTo(0))
                    expect(difference).to(beLessThan(0.001))
                }
                it("should convert Int to Date with miliseconds unit") {
                    let expected = Date(timeIntervalSinceNow: 673_747_200)
                    @Dated(unit: .miliseconds, .sinceNow) var intDate = 673_747_200_000
                    let result = $intDate!
                    let difference = result.timeIntervalSince1970 - expected.timeIntervalSince1970
                    expect(difference).to(beGreaterThanOrEqualTo(0))
                    expect(difference).to(beLessThan(0.001))
                }
                it("should convert Int to Date with miliseconds unit") {
                    let expected = Date(timeIntervalSinceNow: 673_747_200)
                    @Dated(unit: .miliseconds, .sinceNow) var intDate = 673_747_200_000
                    let result = $intDate!
                    let difference = result.timeIntervalSince1970 - expected.timeIntervalSince1970
                    expect(difference).to(beGreaterThanOrEqualTo(0))
                    expect(difference).to(beLessThan(0.001))
                }
                it("should convert Int to Date with minutes unit") {
                    let expected = Date(timeIntervalSinceNow: 673_747_200)
                    @Dated(unit: .minutes, .sinceNow) var intDate = 11_229_120
                    let result = $intDate!
                    let difference = result.timeIntervalSince1970 - expected.timeIntervalSince1970
                    expect(difference).to(beGreaterThanOrEqualTo(0))
                    expect(difference).to(beLessThan(0.001))
                }
                it("should convert Int to Date with hours unit") {
                    let expected = Date(timeIntervalSinceNow: 673_747_200)
                    @Dated(unit: .hours, .sinceNow) var intDate = 187_152
                    let result = $intDate!
                    let difference = result.timeIntervalSince1970 - expected.timeIntervalSince1970
                    expect(difference).to(beGreaterThanOrEqualTo(0))
                    expect(difference).to(beLessThan(0.001))
                }
                it("should convert Int to Date with days unit") {
                    let expected = Date(timeIntervalSinceNow: 673_747_200)
                    @Dated(unit: .days, .sinceNow) var intDate = 7798
                    let result = $intDate!
                    let difference = result.timeIntervalSince1970 - expected.timeIntervalSince1970
                    expect(difference).to(beGreaterThanOrEqualTo(0))
                    expect(difference).to(beLessThan(0.001))
                }
            }
            context("reference based") {
                it("should convert Int to Date with seconds unit") {
                    let referenceDate = Date()
                    let expected = Date(timeInterval: 673_747_200, since: referenceDate)
                    @Dated(unit: .seconds, .since(referenceDate)) var intDate = 673_747_200
                    expect($intDate).to(equal(expected))
                }
                it("should convert Int to Date with miliseconds unit") {
                    let referenceDate = Date()
                    let expected = Date(timeInterval: 673_747_200, since: referenceDate)
                    @Dated(unit: .miliseconds, .since(referenceDate)) var intDate = 673_747_200_000
                    expect($intDate).to(equal(expected))
                }
                it("should convert Int to Date with miliseconds unit") {
                    let referenceDate = Date()
                    let expected = Date(timeInterval: 673_747_200, since: referenceDate)
                    @Dated(unit: .miliseconds, .since(referenceDate)) var intDate = 673_747_200_000
                    expect($intDate).to(equal(expected))
                }
                it("should convert Int to Date with minutes unit") {
                    let referenceDate = Date()
                    let expected = Date(timeInterval: 673_747_200, since: referenceDate)
                    @Dated(unit: .minutes, .since(referenceDate)) var intDate = 11_229_120
                    expect($intDate).to(equal(expected))
                }
                it("should convert Int to Date with hours unit") {
                    let referenceDate = Date()
                    let expected = Date(timeInterval: 673_747_200, since: referenceDate)
                    @Dated(unit: .hours, .since(referenceDate)) var intDate = 187_152
                    expect($intDate).to(equal(expected))
                }
                it("should convert Int to Date with days unit") {
                    let referenceDate = Date()
                    let expected = Date(timeInterval: 673_747_200, since: referenceDate)
                    @Dated(unit: .days, .since(referenceDate)) var intDate = 7798
                    expect($intDate).to(equal(expected))
                }
            }
        }
    }
}
