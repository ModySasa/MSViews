//
//  File.swift
//
//
//  Created by Corptia 02 on 16/08/2022.
//

import Foundation
import L10n_swift

////// Time methods
public class TimeMethods {
    public static let shared = TimeMethods.init()
    
    public let dateFormatterGet = DateFormatter()
    
    public func getTime(_ date:Date) -> String {
        dateFormatterGet.dateFormat = "HH:mm"
        return dateFormatterGet.string(from: date)
    }
    
    public func isNight() -> Bool {
        let date = Date()
        
        dateFormatterGet.dateFormat = "HH"
        
        let hourNow = dateFormatterGet.string(from: date)
        
        let hour = Int(msViews.langMethods.replaceArabicNumbers(number: hourNow))!
        return hour > 13
    }
    
    public func getDate(_ date:Date) -> String {
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        return dateFormatterGet.string(from: date)
    }
    
    public func getLocalDate(_ date:Date) -> String {
        dateFormatterGet.dateFormat = "yyyy-MM-dd"
        dateFormatterGet.locale = Locale(identifier: "en")
        return dateFormatterGet.string(from: date)
    }
    
    public func getDateFormated(_ stringDate : String , inFormante: String? = nil , outFormate: String = "dd MMMM yyyy" , locale: String = "") -> String {
        let formatter = DateFormatter()
        if !locale.isEmpty {
            formatter.locale = Locale(identifier: locale)
        }
        
        let possibleFormats = [
            inFormante,
            "yyyy-MM-dd",
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ssZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        ].compactMap { $0 }
        
        var date: Date? = nil
        for format in possibleFormats {
            formatter.dateFormat = format
            if let parsedDate = formatter.date(from: stringDate) {
                date = parsedDate
                break
            }
        }
        
        if date == nil {
            print("⚠️ Date parsing failed for:", stringDate)
        }
        
        formatter.dateFormat = outFormate
        return formatter.string(from: date ?? Date())
    }
    
    public func getTimeDiff(
        time:String ,
        inputFormat : String = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ",
        isSince : Bool = true
    ) -> String {
        var since : String = strings("Since")
        let ago : String = strings("Ago")
        
        let formatter = DateFormatter()
        formatter.dateFormat = inputFormat
        //    yyyy-MM-dd HH:mm:ss"
        if(formatter.date(from: time) != nil ){
            let date1 = formatter.date(from: time)!
            let date2 = Date()
            
            let elapsedTime = date2.timeIntervalSince(date1) + 7200//000
            
            let years = floor(elapsedTime / 365 / 24 / 60 / 60)
            if(years < 1){
                let months = floor(elapsedTime / 30 / 24 / 60 / 60)
                if(months < 1){
                    let days = floor(elapsedTime / 24 / 60 / 60)
                    if(days < 1){
                        
                        let hours = floor(elapsedTime / 60 / 60)
                        if (hours < 1){
                            let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
                            if(minutes < 1){
                                let seconds = elapsedTime
                                since = "\(isSince ? "\(since) " : "")\(Int(seconds)) \(strings("Second"))\(isSince ? "" : " \(ago)")"
                            } else {
                                since = "\(isSince ? "\(since) " : "")\(Int(minutes)) \(strings("minute"))\(isSince ? "" : " \(ago)")"
                            }
                        } else {
                            since = "\(isSince ? "\(since) " : "")\(Int(hours)) \(strings("Hour"))\(isSince ? "" : " \(ago)")"
                        }
                    } else {
                        since = "\(isSince ? "\(since) " : "")\(Int(days)) \(strings("Day"))\(isSince ? "" : " \(ago)")"
                    }
                } else {
                    since = "\(isSince ? "\(since) " : "")\(Int(months)) \(strings("Month"))\(isSince ? "" : " \(ago)")"
                }
            } else {
                since = "\(isSince ? "\(since) " : "")\(Int(years)) \(strings("Year"))\(isSince ? "" : " \(ago)")"
            }
            return since
        } else {
            return time
        }
        
    }
    
    public func startCountDown(time:Int , interval:Double = 1.0 , onDone:@escaping (Int)->Void ){
        var countDownTime = time
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { timer in
            if(countDownTime > 0){
                countDownTime -= 1
                onDone(countDownTime)
            } else if(countDownTime == 0) {
                timer.invalidate()
            }
        }
        )
    }
    
    public func getDayOfWeek(_ date: Date = .now) -> Days {
        let weekDay = Calendar.current.component(.weekday, from: date)
        
        switch weekDay {
        case 1: return .Sunday
        case 2: return .Monday
        case 3: return .Tuesday
        case 4: return .Wednesday
        case 5: return .Thursday
        case 6: return .Friday
        default: return .Saturday
        }
    }
    
    public func getDayNum(_ date: Date = .now) -> Int {
        let weekDay = Calendar.current.component(.day, from: date)
        return weekDay
    }
    
    public func getHour(_ date: Date = .now) -> Int {
        let hour = Calendar.current.component(.hour, from: date)
        return hour
    }
    
    public func getMin(_ date: Date = .now) -> Int {
        let min = Calendar.current.component(.minute, from: date)
        return min
    }
    
    public func dateFrom(hours:Int? , mins:Int?) -> Date{
        return Calendar.current.date(from: .init(hour:hours,minute: mins))!
    }
    
    public func daySt(day:Days) -> String {
        switch day {
        case .Saturday:  return strings("days.\(DaysNames.Saturday.rawValue)".l10n())
        case .Sunday: return strings("days.\(DaysNames.Sunday.rawValue)".l10n())
        case .Monday: return strings("days.\(DaysNames.Monday.rawValue)".l10n())
        case .Tuesday: return strings("days.\(DaysNames.Tuesday.rawValue)".l10n())
        case .Wednesday: return strings("days.\(DaysNames.Wednesday.rawValue)".l10n())
        case .Thursday: return strings("days.\(DaysNames.Thursday.rawValue)".l10n())
        case .Friday: return strings("days.\(DaysNames.Friday.rawValue)".l10n())
        }
    }
    
    public func getTimeSt(date:Date) -> String {
        var hour = getHour(date)
        let mins = getMin(date)
        let isPM = hour > 11
        
        if(hour > 12) {
            hour = hour - 12
        } else if (hour == 0) {
            hour = 12
        }
        
        var hourSt = "\(hour)"
        if(hour < 10) {
            hourSt = "0\(hour)"
        }
        var minSt = "\(mins)"
        if(mins < 10) {
            minSt = "0\(mins)"
        }
        
        return "\(hourSt):\(minSt)"
    }
    
    public func isPmSt(time:Date , isEnglishOnly:Bool = false)-> String {
        let hour = getHour(time)
        let mins = getMin(time)
        let isPM = hour > 11
        if(isEnglishOnly) {
            return isPM ? "PM" : "AM"
        } else {
            return isPM ? strings("time.pm") : strings("time.am")
        }
    }
}

public enum Days : Int {
    case Sunday = 1
    case Monday = 2
    case Tuesday = 3
    case Wednesday = 4
    case Thursday = 5
    case Friday = 6
    case Saturday = 7
}

public enum DaysNames : String {
    case Sunday = "Sunday"
    case Monday = "Monday"
    case Tuesday = "Tuesday"
    case Wednesday = "Wednesday"
    case Thursday = "Thursday"
    case Friday = "Friday"
    case Saturday = "Saturday"
}
