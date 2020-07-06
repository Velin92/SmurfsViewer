/*
 * Copyright 2020 Bofin
 */

import Foundation
protocol DateService {
    var currentDate: Date { get }
    func format(_ date: Date, style: Date.Style, timeZone: Date.TimeZoneType) -> String
    func dateFrom(_ string: String, style: Date.Style, timeZone: Date.TimeZoneType) -> Date?
    func timeStringBetween(_ date1: Date, and date2: Date, suffix: String?, components: [Calendar.Component]) -> String
    
}
extension DateService {
    func timeStringBetween(_ date1: Date, and date2: Date, components: [Calendar.Component]) -> String {
        return timeStringBetween(date1, and: date2, suffix: "", components: components)
    }
}
extension Date {
    enum TimeZoneType {
        case utc, device
        
        var timeZone: TimeZone {
            switch self {
            case .device:
                return .current
            case .utc:
                return TimeZone(abbreviation: "UTC")!
            }
        }
    }
    enum Style {
        case ddmmyyyy
        case yyyymmdd
        case iso8601Date
        case iso8601DateTime
        case shortDate
        case longDate
        case custom(format: String)
        
        var formatString: String {
            switch self {
            case .ddmmyyyy: return "dd/MM/yyyy"
            case .yyyymmdd: return "yyyy-MM-dd"
            case .iso8601Date: return "yyyy-MM-dd"
            case .iso8601DateTime: return "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            case .shortDate: return "d MMM yyy"
            case .longDate: return "d MMMM yyyy"
            case .custom(let format): return format
            }
        }
    }
    class Service: DateService {
        
        func timeStringBetween(_ date1: Date, and date2: Date, suffix: String?, components: [Calendar.Component] = [.day, .hour, .minute]) -> String {
            guard date1.timeIntervalSince1970 > date2.timeIntervalSince1970 else {
                return "-"
            }
            let calendar = NSCalendar.current
            
            let flags = Set(components)
            let components = calendar.dateComponents(flags, from: date2, to: date1)
            
            var outputArray = [String]()
            var hasTimeLeft = false
            if let days = components.day, days > 0 {
                outputArray.append("\(days) day" + (days > 1 ? "s" : ""))
                hasTimeLeft = true
            }
            
            if let hours = components.hour, hours > 0 {
                outputArray.append("\(hours) hour" + (hours > 1 ? "s" : ""))
                hasTimeLeft = true
                
            }
            if let mins = components.minute, mins > 0 {
                outputArray.append("\(mins) min" + (mins > 1 ? "s" : ""))
                hasTimeLeft = true
            }
            if hasTimeLeft {
                var output = outputArray.joined(separator: ", ")
                if let suffix = suffix, suffix.count > 0 {
                    output += " \(suffix)"
                }
                return output
            } else {
                return "0"
            }
        }

        var currentDate: Date {
            return Date()
        }
        
        lazy var formatter: DateFormatter = {
            let formatter = DateFormatter()
            return formatter
        }()
        
        func format(_ date: Date, style: Date.Style, timeZone: TimeZoneType) -> String {
            formatter.dateFormat = style.formatString
            formatter.timeZone = timeZone.timeZone
            return formatter.string(from: date)
        }
        
        func dateFrom(_ dateString: String, style: Style, timeZone: TimeZoneType) -> Date? {
            formatter.dateFormat = style.formatString
            formatter.timeZone = timeZone.timeZone
            return formatter.date(from: dateString)
        }
    }
    
    func format(style: Date.Style, timeZone: TimeZoneType) -> String {
        return Injected.dateService.format(self, style: style, timeZone: timeZone)
    }
}

extension String {
    var iso8601Date: Date? {
        let dateService = Injected.dateService!
        return dateService.dateFrom(self, style: .iso8601DateTime, timeZone: .utc) ?? dateService.dateFrom(self, style: .iso8601Date,  timeZone: .utc)
    }
}
