/*
 * Copyright 2020 Papa Smurf
 */

import Foundation
@testable import SmurfViewer
import XCTest

class DateServiceTests: UnitTestCase {
    static let startDate = Test.Dates._1998_01_01
    let oneMinuteLaterDate = DateServiceTests.startDate.addingTimeInterval(60)
    let oneHourLaterLaterDate = DateServiceTests.startDate.addingTimeInterval(60*60)
    let twoHoursLaterLaterDate = DateServiceTests.startDate.addingTimeInterval(60*60*2)
    let oneDayLaterLaterDate = DateServiceTests.startDate.addingTimeInterval(60*60*24)
    let twoDaysLaterLaterDate = DateServiceTests.startDate.addingTimeInterval(60*60*24*2)

    var sut: DateService!

    override func setUp() {
        super.setUp()
        sut = Injected.dateService
    }

    override func createMockDateService() -> MockDateService? {
        return nil // we want to test this service
    }

    func test_DDMMYYYYFormatting() {
        let formatted = sut.format(Test.Dates._2000_5_15, style: .ddmmyyyy, timeZone: .device)
        XCTAssertEqual(formatted, "15/05/2000")
    }

    func test_YYYYMMDDFormatting() {
        let formatted = sut.format(Test.Dates._2000_5_15, style: .yyyymmdd, timeZone: .device)
        XCTAssertEqual(formatted, "2000-05-15")
    }

    func test_LongDateFormatting() {
        let formatted = sut.format(Test.Dates._2000_5_15, style: .longDate, timeZone: .device)
        XCTAssertEqual(formatted, "15 May 2000")
    }

    func test_ReturnDateFormattedAsDDMMYYYY() {
        let date = sut.dateFrom("15/05/2000", style: .ddmmyyyy, timeZone: .utc)
        XCTAssertEqual(date?.timeIntervalSince1970, 958348800)
    }

    func test_ReturnDateFormattedAsYYYYMMYY() {
        let date = sut.dateFrom("2000-05-15", style: .yyyymmdd, timeZone: .utc)
        XCTAssertEqual(date?.timeIntervalSince1970, 958348800)
    }

    func test_ReturnDateFormattedAsLongDate() {
        let date = sut.dateFrom("15 May 2000", style: .longDate, timeZone: .utc)
        XCTAssertEqual(date?.timeIntervalSince1970, 958348800)
    }
    func test_ReturnDateFormattedAsIsoDate() {
        let date = sut.dateFrom("2019-08-02T09:49:19.000+00:00", style: .iso8601DateTime, timeZone: .device)
        XCTAssertEqual(date?.timeIntervalSince1970, 1564739359)
    }
    func test_ReturnDateFormatted_asIsoDatePlus1() {
        let date = sut.dateFrom("2019-08-02T09:49:19.000+01:00", style: .iso8601DateTime, timeZone: .device)
        XCTAssertEqual(date?.timeIntervalSince1970, 1564735759)
    }

    func test_timeStringBetween_aDateAndAnotherDateOneHourLater_thenCorrectlyFormattedStringIsReturned() {
        let x = sut.timeStringBetween(oneHourLaterLaterDate, and: DateServiceTests.startDate, components: [.day, .hour])
        XCTAssertEqual(x, "1 hour")
    }
    func test_timeStringBetween_aDateAndAnotherDateTwoHoursLater_thenCorrectlyFormattedStringIsReturned() {
        let x = sut.timeStringBetween(twoHoursLaterLaterDate, and: DateServiceTests.startDate, components: [.day, .hour])
        XCTAssertEqual(x, "2 hours")
    }

    func test_timeStringBetween_aDateAndAnotherDateTwoDaysLater_thenCorrectlyFormattedStringIsReturned() {
        let x = sut.timeStringBetween(twoDaysLaterLaterDate, and: DateServiceTests.startDate, components: [.day, .hour])
        XCTAssertEqual(x, "2 days")
    }
}
