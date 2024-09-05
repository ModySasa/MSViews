//
//  File.swift
//  
//
//  Created by Corptia 02 on 16/08/2022.
//

import Foundation

public extension Date {
    
    func isAfter(than:Date) -> Bool {
        let otherHour = msViews.timeMethods.getHour(than)
        let myHour = msViews.timeMethods.getHour(self)
        let otherMin = msViews.timeMethods.getMin(than)
        let myMin = msViews.timeMethods.getMin(self)
        
        if(myHour > otherHour) {
            return true
        } else if (myHour < otherHour) {
            return false
        } else {
            if(myMin > otherMin) {
                return true
            } else {
                return false
            }
        }
    }
    
    //to display time ago () => date().timeAgoDisplay)
    @available(iOS 13.0, *)
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
    
    func getTimeIntervalToTime(_ hours:Int ,_ mins:Int)->TimeInterval{
        let min = Calendar.current.dateComponents(in: .current, from: self)
        var newComponents = DateComponents.init(calendar: min.calendar, timeZone: min.timeZone, era: min.era, year: min.year, month: min.month, day: min.day, hour: hours, minute: mins, second: 0, nanosecond: 0)
        
        let date = Calendar.current.date(from: newComponents)
        var interval = date!.timeIntervalSince(self)
        if(interval < 0){
            interval = date!.addingTimeInterval(24 * 60 * 60).timeIntervalSince(self)
        }
        return interval
    }
    
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
    
}

public extension TimeInterval {
    func asMinutes() -> Double { return self / (60.0) }
    func asHours()   -> Double { return self / (60.0 * 60.0) }
    func asDays()    -> Double { return self / (60.0 * 60.0 * 24.0) }
    func asWeeks()   -> Double { return self / (60.0 * 60.0 * 24.0 * 7.0) }
    func asMonths()  -> Double { return self / (60.0 * 60.0 * 24.0 * 30.4369) }
    func asYears()   -> Double { return self / (60.0 * 60.0 * 24.0 * 365.2422) }
}
