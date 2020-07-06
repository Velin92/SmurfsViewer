/*
 * Copyright 2020 Bofin
 */

import Foundation
@testable import SmurfViewer
import XCTest

class MockDateService: DateService {
    var currentDateCalled = 0
    var timeStringBetweenCalledWithParams: (Date, Date, String?, [Calendar.Component])?
    var formatCalledWithParams: (Date, Date.Style)?
    var dateFromCalledWithParams: (String, Date.Style)?
    var returnFromFormat = "A dummy formatted date from mock date service"
    var returnFromDateFrom: Date?
    var returnFromTimeStringBetween: String = "A Mock time between String"
    var returnCurrentDate = Test.Dates._2020_01_01

    var currentDate: Date {
        currentDateCalled += 1
        return returnCurrentDate
    }

    func format(_ date: Date, style: Date.Style, timeZone: Date.TimeZoneType) -> String {
        formatCalledWithParams = (date, style)
        return returnFromFormat
    }
    func dateFrom(_ string: String, style: Date.Style, timeZone: Date.TimeZoneType) -> Date? {
        dateFromCalledWithParams = (string, style)
        return returnFromDateFrom
    }
    func timeStringBetween(_ date1: Date, and date2: Date, suffix: String?, components: [Calendar.Component]) -> String {
        timeStringBetweenCalledWithParams = (date1, date2, suffix, components)
        return returnFromTimeStringBetween
    }
}
